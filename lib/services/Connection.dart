import 'dart:io';

class Connection {
  static String status;

  static getConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        status = 'connected';
      }
    } on SocketException catch (_) {
      status = 'not connected';
    }
  }
}
