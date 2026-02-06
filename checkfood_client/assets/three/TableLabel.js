export class TableLabel {
  constructor({ id, capacity, position }, scene) {
    this.id = id;
    this.capacity = capacity;
    this.position = position.clone();

    this.mesh = this._createMesh();
    this.mesh.position.copy(this.position);
    this.mesh.position.y += 25; // label nad stolem

    // data pro raycasting + Flutter
    this.mesh.userData = {
      type: 'TABLE_LABEL',
      id: this.id,
      capacity: this.capacity,
    };

    scene.add(this.mesh);
  }

  /* ------------------------------------------------------------------
   * PUBLIC API
   * ------------------------------------------------------------------ */

  lookAt(camera) {
    // billboard efekt (správně pro panoramu)
    this.mesh.lookAt(camera.position);
  }

  setSelected(selected) {
    this.mesh.material.opacity = selected ? 1.0 : 0.85;
    this.mesh.material.color.set(selected ? 0x22c55e : 0xffffff);
  }

  dispose(scene) {
    scene.remove(this.mesh);
    this.mesh.geometry.dispose();
    this.mesh.material.map.dispose();
    this.mesh.material.dispose();
  }

  /* ------------------------------------------------------------------
   * INTERNALS
   * ------------------------------------------------------------------ */

  _createMesh() {
    const texture = this._createCanvasTexture();

    const material = new THREE.MeshBasicMaterial({
      map: texture,
      transparent: true,
      depthTest: false,
      depthWrite: false,
    });

    const geometry = new THREE.PlaneGeometry(60, 16);

    return new THREE.Mesh(geometry, material);
  }

  _createCanvasTexture() {
    const canvas = document.createElement('canvas');
    canvas.width = 256;
    canvas.height = 64;

    const ctx = canvas.getContext('2d');

    // background
    ctx.fillStyle = 'rgba(0, 0, 0, 0.65)';
    ctx.fillRect(0, 0, canvas.width, canvas.height);

    // text
    ctx.fillStyle = '#ffffff';
    ctx.font = 'bold 24px system-ui, Arial';
    ctx.textAlign = 'center';
    ctx.textBaseline = 'middle';
    ctx.fillText(
      `Stůl pro ${this.capacity}`,
      canvas.width / 2,
      canvas.height / 2
    );

    const texture = new THREE.CanvasTexture(canvas);
    texture.minFilter = THREE.LinearFilter;
    texture.magFilter = THREE.LinearFilter;
    texture.needsUpdate = true;

    return texture;
  }
}
