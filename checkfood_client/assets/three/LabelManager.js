// assets/three/LabelManager.js
//
// Centrální správce všech 3D labelů.
// Odděleno od editoru i panoramatu.

import { Label3D, TableStatus } from './Label3D.js';

export class LabelManager {
  constructor({ scene, camera }) {
    this.scene = scene;
    this.camera = camera;

    this.labels = [];
    this._raycastMeshes = [];

    this._raycaster = new THREE.Raycaster();
    this._mouse = new THREE.Vector2();
  }

  /* ------------------------------------------------------------------
   * CRUD
   * ------------------------------------------------------------------ */

  addLabel({
    id,
    position,
    status = TableStatus.AVAILABLE,
    text = 'Stůl',
  }) {
    const label = new Label3D({
      id,
      position,
      status,
      text,
    });

    label.addToScene(this.scene);

    this.labels.push(label);
    this._raycastMeshes.push(label.mesh);

    return label;
  }

  removeLabelById(id) {
    const index = this.labels.findIndex(l => l.id === id);
    if (index === -1) return;

    const label = this.labels[index];
    label.removeFromScene(this.scene);

    this.labels.splice(index, 1);
    this._raycastMeshes = this._raycastMeshes.filter(
      m => m !== label.mesh
    );
  }

  clear() {
    this.labels.forEach(label => label.removeFromScene(this.scene));
    this.labels = [];
    this._raycastMeshes = [];
  }

  /* ------------------------------------------------------------------
   * INTERACTION
   * ------------------------------------------------------------------ */

  handleClick(event) {
    this._mouse.x = (event.clientX / window.innerWidth) * 2 - 1;
    this._mouse.y = -(event.clientY / window.innerHeight) * 2 + 1;

    this._raycaster.setFromCamera(this._mouse, this.camera);

    const hits = this._raycaster.intersectObjects(
      this._raycastMeshes,
      false
    );

    if (hits.length === 0) return null;

    const mesh = hits[0].object;
    const label = this.labels.find(l => l.mesh === mesh);

    return label || null;
  }

  /* ------------------------------------------------------------------
   * RENDER LOOP
   * ------------------------------------------------------------------ */

  update() {
    // billboard efekt
    for (const label of this.labels) {
      label.lookAt(this.camera);
    }
  }
}
