// reservation_app.js — Read-only panorama viewer with table markers for reservation flow.
// Communicates with Flutter via ReservationChannel.postMessage(JSON).

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
const markers = [];       // { id, mesh, capacity, label, status }
const markerMeshes = [];  // for raycasting
const raycaster = new THREE.Raycaster();
const mouse = new THREE.Vector2();

const MARKER_RADIUS = 420;

// Status → color mapping
const STATUS_COLORS = {
  FREE:     0x22c55e,  // green
  RESERVED: 0xf59e0b,  // orange
  OCCUPIED: 0xef4444,  // red
};

// ============================================================
// INIT
// ============================================================
init();
animate();

function init() {
  const container = document.getElementById('scene');

  camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 1, 1100);
  scene = new THREE.Scene();

  // WebGL: conservative settings for mobile WebView / emulator compatibility
  renderer = new THREE.WebGLRenderer({
    antialias: false,             // MSAA calls unsupported GL on weak HW
    precision: 'mediump',         // lower shader precision = wider GPU support
    powerPreference: 'low-power', // prefer integrated GPU, avoid overheating
    failIfMajorPerformanceCaveat: false,
  });
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 1.5));
  renderer.setSize(window.innerWidth, window.innerHeight);
  container.appendChild(renderer.domElement);

  // Handle WebGL context loss/restore (prevents permanent freeze)
  renderer.domElement.addEventListener('webglcontextlost', (e) => {
    e.preventDefault();
    console.warn('[ReservationViewer] WebGL context lost — pausing render');
  });
  renderer.domElement.addEventListener('webglcontextrestored', () => {
    console.log('[ReservationViewer] WebGL context restored — resuming');
    cameraDirty = true;
  });

  // Panorama sphere (inverted normals)
  const geometry = new THREE.SphereGeometry(500, 60, 40);
  geometry.scale(-1, 1, 1);
  panoMesh = new THREE.Mesh(geometry, new THREE.MeshBasicMaterial({ color: 0x000000 }));
  scene.add(panoMesh);

  // Events — use {passive: false} to allow preventDefault on touch
  container.addEventListener('pointerdown', onPointerDown, { passive: false });
  container.addEventListener('pointermove', onPointerMove, { passive: false });
  container.addEventListener('pointerup', onPointerUp);
  container.addEventListener('pointercancel', onPointerUp);
  container.addEventListener('click', onClick);
  window.addEventListener('resize', onResize);

  console.log('[ReservationViewer] initialized');
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
      console.log('[ReservationViewer] panorama loaded');
    } catch (e) {
      console.error('[ReservationViewer] panorama error', e);
    }
  };
  img.onerror = e => console.error('[ReservationViewer] image load error', e);
  img.src = 'data:image/jpeg;base64,' + base64Jpg;
};

// ============================================================
// FLUTTER BRIDGE — setTables(json)
// Expects: [ { "tableId":"...", "label":"...", "yaw":1.2, "pitch":-0.1, "capacity":4 } ]
// ============================================================
window.setTables = function (jsonString) {
  const tables = JSON.parse(jsonString);
  clearMarkers();

  for (const t of tables) {
    addMarker(t.tableId, t.label, t.yaw, t.pitch, t.capacity, 'FREE');
  }
  cameraDirty = true;
  console.log('[ReservationViewer] loaded', tables.length, 'tables');
};

// ============================================================
// FLUTTER BRIDGE — updateStatuses(json)
// Expects: [ { "tableId":"...", "status":"FREE"|"RESERVED"|"OCCUPIED" } ]
// ============================================================
window.updateStatuses = function (jsonString) {
  const statuses = JSON.parse(jsonString);
  for (const s of statuses) {
    const marker = markers.find(m => m.id === s.tableId);
    if (marker) {
      marker.status = s.status;
      updateMarkerTexture(marker);
    }
  }
  console.log('[ReservationViewer] statuses updated');
};

// ============================================================
// MARKER MANAGEMENT
// ============================================================
function addMarker(id, label, yawDeg, pitchDeg, capacity, status) {
  const pos = yawPitchToPosition(yawDeg, pitchDeg, MARKER_RADIUS);

  const canvas = createMarkerCanvas(label, capacity, status);
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

  const marker = { id, mesh, capacity, label, status, canvas };
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
  const canvas = createMarkerCanvas(marker.label, marker.capacity, marker.status);
  const texture = new THREE.CanvasTexture(canvas);
  texture.minFilter = THREE.LinearFilter;
  texture.magFilter = THREE.LinearFilter;

  marker.mesh.material.map.dispose();
  marker.mesh.material.map = texture;
  marker.mesh.material.needsUpdate = true;
  marker.canvas = canvas;
}

function createMarkerCanvas(label, capacity, status) {
  const canvas = document.createElement('canvas');
  canvas.width = 320;
  canvas.height = 96;
  const ctx = canvas.getContext('2d');

  // Background color based on status
  const colorHex = STATUS_COLORS[status] || STATUS_COLORS.FREE;
  const r = (colorHex >> 16) & 0xff;
  const g = (colorHex >> 8) & 0xff;
  const b = colorHex & 0xff;

  // Rounded rectangle
  const radius = 16;
  ctx.beginPath();
  ctx.roundRect(4, 4, canvas.width - 8, canvas.height - 8, radius);
  ctx.fillStyle = `rgba(${r}, ${g}, ${b}, 0.85)`;
  ctx.fill();

  // Text
  ctx.fillStyle = '#ffffff';
  ctx.font = 'bold 28px system-ui, Arial';
  ctx.textAlign = 'center';
  ctx.textBaseline = 'middle';
  ctx.fillText(`${label}`, canvas.width / 2, canvas.height / 2 - 12);

  ctx.font = '20px system-ui, Arial';
  ctx.fillText(`${capacity} míst`, canvas.width / 2, canvas.height / 2 + 18);

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

  // Capture pointer so events continue even if finger leaves the element
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
  // Release capture
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

  const hits = raycaster.intersectObjects(markerMeshes, false);
  if (hits.length === 0) return;

  const hitMesh = hits[0].object;
  const marker = markers.find(m => m.mesh === hitMesh);
  if (!marker) return;

  // Notify Flutter
  if (window.ReservationChannel) {
    window.ReservationChannel.postMessage(JSON.stringify({
      type: 'TABLE_CLICKED',
      tableId: marker.id,
      label: marker.label,
      capacity: marker.capacity,
      status: marker.status,
    }));
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

  // Skip rendering if WebGL context is lost
  if (renderer.getContext().isContextLost()) return;

  // Apply inertia when not dragging
  if (!isInteracting && (Math.abs(velocityX) > VELOCITY_THRESHOLD || Math.abs(velocityY) > VELOCITY_THRESHOLD)) {
    lon += velocityX;
    lat += velocityY;
    velocityX *= DAMPING;
    velocityY *= DAMPING;
    cameraDirty = true;
  }

  if (cameraDirty) {
    updateCamera();
    // Billboard: all markers face camera
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
