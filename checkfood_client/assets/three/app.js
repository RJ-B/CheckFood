// assets/three/app.js

import { EditorState } from './EditorState.js';
import { LabelManager } from './LabelManager.js';

let camera, scene, renderer;
let panoMesh;

// ===============================
// CAMERA STATE
// ===============================
let lon = 0;
let lat = 0;
let isInteracting = false;
let startX = 0;
let startY = 0;
let startLon = 0;
let startLat = 0;

// ===============================
// STATE & MANAGERS
// ===============================
let editorState;
let labelManager;

let cameraDirty = true;

// ======================================================
// INIT
// ======================================================
init();
animate();

function init() {
  const container = document.getElementById('scene');

  // --------------------
  // CAMERA
  // --------------------
  camera = new THREE.PerspectiveCamera(
    75,
    window.innerWidth / window.innerHeight,
    1,
    1100
  );

  scene = new THREE.Scene();

  // --------------------
  // RENDERER
  // --------------------
  renderer = new THREE.WebGLRenderer({ antialias: true });
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 1.5));
  renderer.setSize(window.innerWidth, window.innerHeight);
  container.appendChild(renderer.domElement);

  // --------------------
  // PANORAMA SPHERE
  // --------------------
  const geometry = new THREE.SphereGeometry(500, 60, 40);
  geometry.scale(-1, 1, 1);

  panoMesh = new THREE.Mesh(
    geometry,
    new THREE.MeshBasicMaterial({ color: 0x000000 })
  );

  scene.add(panoMesh);

  // --------------------
  // STATE & MANAGERS
  // --------------------
  editorState = new EditorState();

  labelManager = new LabelManager({
    scene,
    camera,
  });

  // --------------------
  // EVENTS
  // --------------------
  container.addEventListener('pointerdown', onPointerDown);
  container.addEventListener('pointermove', onPointerMove);
  container.addEventListener('pointerup', onPointerUp);
  container.addEventListener('click', onClick);

  window.addEventListener('resize', onResize);

  console.log('[Three] initialized');
}

// ======================================================
// PANORAMA (BASE64 Z FLUTTERU)
// ======================================================
window.setPanoramaBase64 = function (base64Jpg) {
  const img = new Image();

  img.onload = () => {
    try {
      const maxSize = renderer.capabilities.maxTextureSize || 4096;

      let w = img.width;
      let h = img.height;

      if (w > maxSize || h > maxSize) {
        const scale = Math.min(maxSize / w, maxSize / h);
        w = Math.floor(w * scale);
        h = Math.floor(h * scale);
      }

      const canvas = document.createElement('canvas');
      canvas.width = w;
      canvas.height = h;

      const ctx = canvas.getContext('2d');
      ctx.drawImage(img, 0, 0, w, h);

      const texture = new THREE.CanvasTexture(canvas);
      texture.needsUpdate = true;

      panoMesh.material.dispose();
      panoMesh.material = new THREE.MeshBasicMaterial({ map: texture });

      console.log('[Three] panorama loaded');
    } catch (e) {
      console.error('[Three] panorama error', e);
    }
  };

  img.onerror = e => {
    console.error('[Three] panorama image load error', e);
  };

  img.src = 'data:image/jpeg;base64,' + base64Jpg;
};

// ======================================================
// EDITOR API (VOLÁ FLUTTER)
// ======================================================
window.startLabelEditor = function () {
  editorState.enterEditMode();
  console.log('[Editor] enabled');
};

window.finishLabelEditor = function () {
  editorState.exitEditMode();
  console.log('[Editor] disabled');
};

// ======================================================
// INTERACTION
// ======================================================
function onPointerDown(e) {
  isInteracting = true;
  startX = e.clientX;
  startY = e.clientY;
  startLon = lon;
  startLat = lat;
}

function onPointerMove(e) {
  if (!isInteracting) return;

  const ROTATION_SPEED = 0.25;
  lon = (startX - e.clientX) * ROTATION_SPEED + startLon;
  lat = (e.clientY - startY) * ROTATION_SPEED + startLat;

  cameraDirty = true;
}


function onPointerUp() {
  isInteracting = false;
}

function onClick(event) {
  // 1️⃣ Klik na existující label
  const hitLabel = labelManager.handleClick(event);
  if (hitLabel) {
    hitLabel.toggleStatus();
    return;
  }

  // 2️⃣ Přidání labelu (jen v editor módu)
  if (!editorState.isEditing()) return;

  const position = getLookDirectionPosition(420);

  labelManager.addLabel({
    id: crypto.randomUUID(),
    position,
    status: 'free', // free | occupied
    text: 'Stůl',
  });
}

// ======================================================
// CAMERA
// ======================================================
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

function getLookDirectionPosition(distance) {
  const dir = new THREE.Vector3();
  camera.getWorldDirection(dir);
  return dir.multiplyScalar(distance);
}

// ======================================================
// LOOP
// ======================================================
function animate() {
  requestAnimationFrame(animate);

  if (cameraDirty) {
    updateCamera();
    labelManager.update();
    cameraDirty = false;
  }

  renderer.render(scene, camera);
}


// ======================================================
// RESIZE
// ======================================================
function onResize() {
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();
  renderer.setSize(window.innerWidth, window.innerHeight);
}
