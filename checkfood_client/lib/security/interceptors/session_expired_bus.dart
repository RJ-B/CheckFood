import 'dart:async';

/// Global broadcast channel for "session expired" notifications emitted by
/// [AuthInterceptor] when refresh-token flow fails. UI layer (AuthBloc)
/// listens to the stream and performs the forced logout / navigation.
///
/// Why a global singleton instead of injecting into AuthBloc: the
/// interceptor is constructed inside `dio` (which is created in DI before
/// any bloc), and pulling AuthBloc into the DI graph at interceptor
/// construction time would create a circular dependency. A plain broadcast
/// stream keeps the direction of data flow one-way (data layer → UI layer)
/// without coupling.
class SessionExpiredBus {
  SessionExpiredBus._();

  static final SessionExpiredBus instance = SessionExpiredBus._();

  final StreamController<void> _controller = StreamController<void>.broadcast();

  /// Public stream for UI to subscribe to. Each emit indicates that the
  /// access/refresh token pair is gone and the user must be taken back to
  /// the login screen.
  Stream<void> get stream => _controller.stream;

  /// Emit a session-expired signal. Called by [AuthInterceptor] after it
  /// has wiped tokens from [TokenStorage].
  void signalExpired() {
    if (!_controller.isClosed) {
      _controller.add(null);
    }
  }

  /// For tests — resets the stream so assertions can check single-event
  /// semantics without cross-test pollution.
  Future<void> disposeForTest() async {
    await _controller.close();
  }
}
