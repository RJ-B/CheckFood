// assets/three/app.js — Panorama editor with table placement.
// Communicates with Flutter via EditorChannel.postMessage(JSON).
// Based on the working reservation_app.js pattern.

import { EditorState } from './EditorState.js';

let camera, scene, renderer;
let panoMesh;

// Camera state
let lon = 0, lat = 0;
let isInteracting = false;
let prevX = 0, prevY = 0;
let startX = 0, startY = 0;
let velocityX = 0, velocityY = 0;
let cameraDirty = true;

const DRAG_SENSITIVITY = 0.25;
const DAMPING = 0.92;
const VELOCITY_THRESHOLD = 0.05;

// Marker state
const markers = [];       // { id, mesh, capacity, label, yaw, pitch }
const markerMeshes = [];  // for raycasting
const raycaster = new THREE.Raycaster();
const mouse = new THREE.Vector2();

const MARKER_RADIUS = 420;
const MARKER_COLOR = 0x3b82f6; // blue for editor

// Editor state
const editorState = new EditorState();

// ============================================================
// INIT
// ============================================================
init();
animate();

function init() {
  const container = document.getElementById('scene');

  camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 1, 1100);
  scene = new THREE.Scene();

  renderer = new THREE.WebGLRenderer({
    antialias: false,
    precision: 'mediump',
    powerPreference: 'low-power',
    failIfMajorPerformanceCaveat: false,
  });
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 1.5));
  renderer.setSize(window.innerWidth, window.innerHeight);
  container.appendChild(renderer.domElement);

  // Handle WebGL context loss/restore
  renderer.domElement.addEventListener('webglcontextlost', (e) => {
    e.preventDefault();
    console.warn('[Editor] WebGL context lost');
  });
  renderer.domElement.addEventListener('webglcontextrestored', () => {
    console.log('[Editor] WebGL context restored');
    cameraDirty = true;
  });

  // Panorama sphere (inverted normals)
  const geometry = new THREE.SphereGeometry(500, 60, 40);
  geometry.scale(-1, 1, 1);
  panoMesh = new THREE.Mesh(geometry, new THREE.MeshBasicMaterial({ color: 0x000000 }));
  scene.add(panoMesh);

  // Events
  container.addEventListener('pointerdown', onPointerDown, { passive: false });
  container.addEventListener('pointermove', onPointerMove, { passive: false });
  container.addEventListener('pointerup', onPointerUp);
  container.addEventListener('pointercancel', onPointerUp);
  container.addEventListener('click', onClick);
  window.addEventListener('resize', onResize);

  // UI buttons
  const btnAdd = document.getElementById('btn-add');
  const btnDone = document.getElementById('btn-done');

  if (btnAdd) {
    btnAdd.addEventListener('click', (e) => {
      e.stopPropagation();
      window.enterEditMode();
    });
  }
  if (btnDone) {
    btnDone.addEventListener('click', (e) => {
      e.stopPropagation();
      window.exitEditMode();
    });
  }

  // Listen for mode changes to toggle UI
  editorState.on('modeChanged', ({ next }) => {
    if (btnAdd) btnAdd.style.display = next === 'ADD_LABEL' ? 'none' : 'block';
    if (btnDone) btnDone.style.display = next === 'ADD_LABEL' ? 'block' : 'none';
  });

  console.log('[Editor] initialized');
}

// ============================================================
// FLUTTER BRIDGE — setPanoramaBase64
// ============================================================
window.setPanoramaBase64 = function (base64Jpg) {
  const img = new Image();
  img.onload = () => {
    try {
      const maxSize = renderer.capabilities.maxTextureSize || 4096;
      let w = img.width, h = img.height;
      if (w > maxSize || h > maxSize) {
        const s = Math.min(maxSize / w, maxSize / h);
        w = Math.floor(w * s);
        h = Math.floor(h * s);
      }
      const canvas = document.createElement('canvas');
      canvas.width = w; canvas.height = h;
      canvas.getContext('2d').drawImage(img, 0, 0, w, h);

      const texture = new THREE.CanvasTexture(canvas);
      texture.needsUpdate = true;
      panoMesh.material.dispose();
      panoMesh.material = new THREE.MeshBasicMaterial({ map: texture });
      console.log('[Editor] panorama loaded');
    } catch (e) {
      console.error('[Editor] panorama error', e);
    }
  };
  img.onerror = e => console.error('[Editor] image load error', e);
  img.src = 'data:image/jpeg;base64,' + base64Jpg;
};

// ============================================================
// FLUTTER BRIDGE — loadTables(json)
// Expects: [ { "id":"...", "label":"...", "yaw":1.2, "pitch":-0.1, "capacity":4 } ]
// ============================================================
window.loadTables = function (jsonString) {
  const tables = JSON.parse(jsonString);
  clearMarkers();

  for (const t of tables) {
    addMarker(t.id, t.label, t.yaw, t.pitch, t.capacity);
  }
  cameraDirty = true;
  console.log('[Editor] loaded', tables.length, 'tables');
};

// ============================================================
// FLUTTER BRIDGE — exportTables()
// Sends all markers back to Flutter via EditorChannel
// ============================================================
window.exportTables = function () {
  const tables = markers.map(m => ({
    id: m.id,
    label: m.label,
    capacity: m.capacity,
    yaw: m.yaw,
    pitch: m.pitch,
  }));

  if (window.EditorChannel) {
    window.EditorChannel.postMessage(JSON.stringify({
      type: 'TABLES_EXPORTED',
      tables: tables,
    }));
  }
  console.log('[Editor] exported', tables.length, 'tables');
};

// ============================================================
// FLUTTER BRIDGE — enterEditMode / exitEditMode
// ============================================================
window.enterEditMode = function () {
  editorState.enterAddLabelMode();
  console.log('[Editor] edit mode ON');
};

window.exitEditMode = function () {
  editorState.exitToViewMode();
  console.log('[Editor] edit mode OFF');
};

// ============================================================
// FLUTTER BRIDGE — updateLabel(json)
// Expects: { "id":"...", "label":"...", "capacity":4 }
// ============================================================
window.updateLabel = function (jsonString) {
  const data = JSON.parse(jsonString);
  const marker = markers.find(m => m.id === data.id);
  if (!marker) return;

  marker.label = data.label;
  marker.capacity = data.capacity;
  updateMarkerTexture(marker);
  console.log('[Editor] label updated:', data.id);
};

// ============================================================
// FLUTTER BRIDGE — removeLabel(id)
// ============================================================
window.removeLabel = function (id) {
  const index = markers.findIndex(m => m.id === id);
  if (index === -1) return;

  const marker = markers[index];
  scene.remove(marker.mesh);
  marker.mesh.geometry.dispose();
  marker.mesh.material.map.dispose();
  marker.mesh.material.dispose();

  markers.splice(index, 1);
  const meshIdx = markerMeshes.indexOf(marker.mesh);
  if (meshIdx !== -1) markerMeshes.splice(meshIdx, 1);

  console.log('[Editor] label removed:', id);
};

// ============================================================
// MARKER MANAGEMENT
// ============================================================
function addMarker(id, label, yawDeg, pitchDeg, capacity) {
  const pos = yawPitchToPosition(yawDeg, pitchDeg, MARKER_RADIUS);

  const canvas = createMarkerCanvas(label, capacity);
  const texture = new THREE.CanvasTexture(canvas);
  texture.minFilter = THREE.LinearFilter;
  texture.magFilter = THREE.LinearFilter;

  const material = new THREE.MeshBasicMaterial({
    map: texture,
    transparent: true,
    depthTest: false,
    depthWrite: false,
  });
  const mesh = new THREE.Mesh(new THREE.PlaneGeometry(70, 24), material);
  mesh.position.copy(pos);
  mesh.userData = { type: 'TABLE_MARKER', id, capacity };

  scene.add(mesh);

  const marker = { id, mesh, capacity, label, yaw: yawDeg, pitch: pitchDeg, canvas };
  markers.push(marker);
  markerMeshes.push(mesh);
}

function clearMarkers() {
  for (const m of markers) {
    scene.remove(m.mesh);
    m.mesh.geometry.dispose();
    m.mesh.material.map.dispose();
    m.mesh.material.dispose();
  }
  markers.length = 0;
  markerMeshes.length = 0;
}

function updateMarkerTexture(marker) {
  const canvas = createMarkerCanvas(marker.label, marker.capacity);
  const texture = new THREE.CanvasTexture(canvas);
  texture.minFilter = THREE.LinearFilter;
  texture.magFilter = THREE.LinearFilter;

  marker.mesh.material.map.dispose();
  marker.mesh.material.map = texture;
  marker.mesh.material.needsUpdate = true;
  marker.canvas = canvas;
}

function createMarkerCanvas(label, capacity) {
  const canvas = document.createElement('canvas');
  canvas.width = 320;
  canvas.height = 96;
  const ctx = canvas.getContext('2d');

  // Blue rounded rectangle
  const r = (MARKER_COLOR >> 16) & 0xff;
  const g = (MARKER_COLOR >> 8) & 0xff;
  const b = MARKER_COLOR & 0xff;

  const radius = 16;
  ctx.beginPath();
  ctx.roundRect(4, 4, canvas.width - 8, canvas.height - 8, radius);
  ctx.fillStyle = `rgba(${r}, ${g}, ${b}, 0.85)`;
  ctx.fill();

  // Border
  ctx.strokeStyle = 'rgba(255, 255, 255, 0.6)';
  ctx.lineWidth = 2;
  ctx.stroke();

  // Text
  ctx.fillStyle = '#ffffff';
  ctx.font = 'bold 28px system-ui, Arial';
  ctx.textAlign = 'center';
  ctx.textBaseline = 'middle';
  ctx.fillText(label, canvas.width / 2, canvas.height / 2 - 12);

  ctx.font = '20px system-ui, Arial';
  ctx.fillText(`${capacity} mist`, canvas.width / 2, canvas.height / 2 + 18);

  return canvas;
}

// ============================================================
// COORDINATE CONVERSION
// ============================================================
function yawPitchToPosition(yawDeg, pitchDeg, radius) {
  const phi = THREE.MathUtils.degToRad(90 - pitchDeg);
  const theta = THREE.MathUtils.degToRad(yawDeg);

  return new THREE.Vector3(
    radius * Math.sin(phi) * Math.cos(theta),
    radius * Math.cos(phi),
    radius * Math.sin(phi) * Math.sin(theta)
  );
}

function positionToYawPitch(position) {
  const r = position.length();
  const pitchDeg = 90 - THREE.MathUtils.radToDeg(Math.acos(position.y / r));
  const yawDeg = THREE.MathUtils.radToDeg(Math.atan2(position.z, position.x));
  return { yaw: yawDeg, pitch: pitchDeg };
}

function getLookDirectionPosition(distance) {
  const dir = new THREE.Vector3();
  camera.getWorldDirection(dir);
  return dir.multiplyScalar(distance);
}

// ============================================================
// INTERACTION — pointer capture + velocity damping
// ============================================================
function onPointerDown(e) {
  e.preventDefault();
  isInteracting = true;
  prevX = e.clientX;
  prevY = e.clientY;
  startX = e.clientX;
  startY = e.clientY;
  velocityX = 0;
  velocityY = 0;

  const container = document.getElementById('scene');
  container.setPointerCapture(e.pointerId);
}

function onPointerMove(e) {
  if (!isInteracting) return;
  e.preventDefault();

  const dx = prevX - e.clientX;
  const dy = e.clientY - prevY;

  lon += dx * DRAG_SENSITIVITY;
  lat += dy * DRAG_SENSITIVITY;

  velocityX = dx * DRAG_SENSITIVITY;
  velocityY = dy * DRAG_SENSITIVITY;

  prevX = e.clientX;
  prevY = e.clientY;
  cameraDirty = true;
}

function onPointerUp(e) {
  isInteracting = false;
  if (e.pointerId !== undefined) {
    const container = document.getElementById('scene');
    try { container.releasePointerCapture(e.pointerId); } catch (_) {}
  }
}

function onClick(event) {
  // Only fire if no significant drag
  const dx = event.clientX - startX;
  const dy = event.clientY - startY;
  if (Math.abs(dx) > 5 || Math.abs(dy) > 5) return;

  mouse.x = (event.clientX / window.innerWidth) * 2 - 1;
  mouse.y = -(event.clientY / window.innerHeight) * 2 + 1;
  raycaster.setFromCamera(mouse, camera);

  // Check if clicked on an existing marker
  const hits = raycaster.intersectObjects(markerMeshes, false);
  if (hits.length > 0) {
    const hitMesh = hits[0].object;
    const marker = markers.find(m => m.mesh === hitMesh);
    if (marker && window.EditorChannel) {
      window.EditorChannel.postMessage(JSON.stringify({
        type: 'LABEL_CLICKED',
        id: marker.id,
        label: marker.label,
        capacity: marker.capacity,
        yaw: marker.yaw,
        pitch: marker.pitch,
      }));
    }
    return;
  }

  // In ADD_LABEL mode: place new marker at camera look direction
  if (editorState.isAddLabelMode) {
    const position = getLookDirectionPosition(MARKER_RADIUS);
    const { yaw, pitch } = positionToYawPitch(position);
    const id = crypto.randomUUID();

    addMarker(id, 'Novy stul', yaw, pitch, 4);

    if (window.EditorChannel) {
      window.EditorChannel.postMessage(JSON.stringify({
        type: 'LABEL_ADDED',
        id: id,
        yaw: yaw,
        pitch: pitch,
      }));
    }
  }
}

// ============================================================
// CAMERA
// ============================================================
function updateCamera() {
  lat = Math.max(-85, Math.min(85, lat));
  const phi = THREE.MathUtils.degToRad(90 - lat);
  const theta = THREE.MathUtils.degToRad(lon);
  camera.lookAt(
    500 * Math.sin(phi) * Math.cos(theta),
    500 * Math.cos(phi),
    500 * Math.sin(phi) * Math.sin(theta)
  );
}

// ============================================================
// LOOP — with inertia damping
// ============================================================
function animate() {
  requestAnimationFrame(animate);

  if (renderer.getContext().isContextLost()) return;

  if (!isInteracting && (Math.abs(velocityX) > VELOCITY_THRESHOLD || Math.abs(velocityY) > VELOCITY_THRESHOLD)) {
    lon += velocityX;
    lat += velocityY;
    velocityX *= DAMPING;
    velocityY *= DAMPING;
    cameraDirty = true;
  }

  if (cameraDirty) {
    updateCamera();
    for (const m of markers) {
      m.mesh.lookAt(camera.position);
    }
    cameraDirty = false;
  }

  renderer.render(scene, camera);
}

// ============================================================
// RESIZE
// ============================================================
function onResize() {
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();
  renderer.setSize(window.innerWidth, window.innerHeight);
}
