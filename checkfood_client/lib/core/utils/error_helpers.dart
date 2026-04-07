import 'package:dio/dio.dart';

String userFriendlyError(Object e) {
  if (e is DioException) {
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout) {
      return 'Nepodařilo se připojit k serveru. Zkontrolujte připojení k internetu.';
    }
    final msg = _extractServerMessage(e);
    if (msg != null) return msg;
    return 'Došlo k chybě serveru. Zkuste to prosím později.';
  }
  if (e is Exception) {
    final str = e.toString();
    if (str.contains('SocketException') || str.contains('Connection refused')) {
      return 'Nepodařilo se připojit k serveru.';
    }
  }
  return 'Neočekávaná chyba. Zkuste to prosím později.';
}

String? _extractServerMessage(DioException e) {
  try {
    final data = e.response?.data;
    if (data is Map<String, dynamic> && data.containsKey('message')) {
      return data['message'] as String;
    }
  } catch (_) {}
  return null;
}
