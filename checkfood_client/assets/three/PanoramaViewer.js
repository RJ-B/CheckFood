// assets/three/PanoramaViewer.js
//
// Odpovědnost:
// - Three.js scéna
// - kamera
// - 360° panorama
// - ovládání pohledu
//
// Neobsahuje žádnou editor logiku ani labely.

export class PanoramaViewer {
  constructor(container) {
    this.container = container;

    this.camera = null;
    this.scene = null;
    this.renderer = null;

    this._lon = 0;
    this._lat = 0;

    this._isDragging = false;
    this._startX = 0;
    this._startY = 0;
    this._startLon = 0;
    this._startLat = 0;

    this._init();
  }

  /* ------------------------------------------------------------------
   * INIT
   * ------------------------------------------------------------------ */

  _init() {
    this.camera = new THREE.PerspectiveCamera(
      75,
      window.innerWidth / window.innerHeight,
      1,
      1100
    );

    this.scene = new THREE.Scene();

    this.renderer = new THREE.WebGLRenderer({ antialias: true });
    this.renderer.setPixelRatio(window.devicePixelRatio || 1);
    this.renderer.setSize(window.innerWidth, window.innerHeight);

    this.container.appendChild(this.renderer.domElement);

    this._initPanoramaMesh();
    this._bindEvents();
  }

  _initPanoramaMesh() {
    const geometry = new THREE.SphereGeometry(500, 60, 40);
    geometry.scale(-1, 1, 1);

    const material = new THREE.MeshBasicMaterial({ color: 0x000000 });

    this._panoMesh = new THREE.Mesh(geometry, material);
    this.scene.add(this._panoMesh);
  }

  /* ------------------------------------------------------------------
   * PANORAMA API
   * ------------------------------------------------------------------ */

  setPanoramaFromBase64(base64Jpg) {
    const img = new Image();

    img.onload = () => {
      const maxSize =
        this.renderer.capabilities.maxTextureSize || 4096;

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

      this._panoMesh.material.dispose();
      this._panoMesh.material = new THREE.MeshBasicMaterial({
        map: texture,
      });
    };

    img.onerror = e => {
      console.error('Panorama load error', e);
    };

    img.src = 'data:image/jpeg;base64,' + base64Jpg;
  }

  /* ------------------------------------------------------------------
   * INPUT
   * ------------------------------------------------------------------ */

  _bindEvents() {
    const el = this.renderer.domElement;

    el.addEventListener('pointerdown', this._onPointerDown);
    el.addEventListener('pointermove', this._onPointerMove);
    el.addEventListener('pointerup', this._onPointerUp);
    el.addEventListener('pointerleave', this._onPointerUp);

    window.addEventListener('resize', () => this._onResize());
  }

  _onPointerDown = e => {
    this._isDragging = true;
    this._startX = e.clientX;
    this._startY = e.clientY;
    this._startLon = this._lon;
    this._startLat = this._lat;
  };

  _onPointerMove = e => {
    if (!this._isDragging) return;

    const ROTATION_SPEED = 0.25;

    this._lon =
      (this._startX - e.clientX) * ROTATION_SPEED + this._startLon;
    this._lat =
      (e.clientY - this._startY) * ROTATION_SPEED + this._startLat;
  };

  _onPointerUp = () => {
    this._isDragging = false;
  };

  /* ------------------------------------------------------------------
   * RENDER LOOP
   * ------------------------------------------------------------------ */

  update() {
    this._updateCamera();
    this.renderer.render(this.scene, this.camera);
  }

  _updateCamera() {
    this._lat = Math.max(-85, Math.min(85, this._lat));

    const phi = THREE.MathUtils.degToRad(90 - this._lat);
    const theta = THREE.MathUtils.degToRad(this._lon);

    this.camera.lookAt(
      500 * Math.sin(phi) * Math.cos(theta),
      500 * Math.cos(phi),
      500 * Math.sin(phi) * Math.sin(theta)
    );
  }

  /* ------------------------------------------------------------------
   * UTILS
   * ------------------------------------------------------------------ */

  getCamera() {
    return this.camera;
  }

  getScene() {
    return this.scene;
  }

  getRendererDomElement() {
    return this.renderer.domElement;
  }

  _onResize() {
    this.camera.aspect = window.innerWidth / window.innerHeight;
    this.camera.updateProjectionMatrix();
    this.renderer.setSize(window.innerWidth, window.innerHeight);
  }
}
