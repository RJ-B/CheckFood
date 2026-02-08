// assets/three/EditorState.js
//
// Jednoduchý stavový automat pro editor.
// Neobsahuje žádnou Three.js logiku, jen drží režim a stav UI.
// Režimy:
// - VIEW: běžné prohlížení + klik na label
// - ADD_LABEL: klik do scény přidá nový label

export const EditorMode = Object.freeze({
  VIEW: 'VIEW',
  ADD_LABEL: 'ADD_LABEL',
});

export class EditorState {
  constructor({ initialMode = EditorMode.VIEW } = {}) {
    this._mode = initialMode;

    // Event listeners: { [eventName]: Set<fn> }
    this._listeners = new Map();
  }

  /* ------------------------------------------------------------------
   * PUBLIC API
   * ------------------------------------------------------------------ */

  get mode() {
    return this._mode;
  }

  get isViewMode() {
    return this._mode === EditorMode.VIEW;
  }

  get isAddLabelMode() {
    return this._mode === EditorMode.ADD_LABEL;
  }

  setMode(mode) {
    if (!Object.values(EditorMode).includes(mode)) {
      throw new Error(`EditorState.setMode: invalid mode "${mode}"`);
    }

    if (this._mode === mode) return;

    const prev = this._mode;
    this._mode = mode;

    this._emit('modeChanged', { prev, next: mode });
  }

  enterAddLabelMode() {
    this.setMode(EditorMode.ADD_LABEL);
  }

  exitToViewMode() {
    this.setMode(EditorMode.VIEW);
  }

  /* ------------------------------------------------------------------
   * EVENTS
   * ------------------------------------------------------------------ */

  on(eventName, handler) {
    if (typeof handler !== 'function') {
      throw new Error('EditorState.on: handler must be a function');
    }

    if (!this._listeners.has(eventName)) {
      this._listeners.set(eventName, new Set());
    }

    const set = this._listeners.get(eventName);
    set.add(handler);

    // return unsubscribe function
    return () => {
      set.delete(handler);
    };
  }

  _emit(eventName, payload) {
    const set = this._listeners.get(eventName);
    if (!set || set.size === 0) return;

    for (const fn of set) {
      try {
        fn(payload);
      } catch (e) {
        // záměrně nehážeme dál, aby jeden handler nesestřelil aplikaci
        console.error(`EditorState listener error for "${eventName}"`, e);
      }
    }
  }
}
