
class ApiException implements Exception {
  final _prefix;
  final _message;

  ApiException([this._prefix, this._message]);

  String toString() {
    return "$_prefix$_message";
  }
}

class DefaultException extends ApiException {
  DefaultException([String message])
      : super("Error During Communication With Server: ", message);
}

class ClientErrorException extends ApiException {
  ClientErrorException([message]) : super("Client Error: ", message);
}

class ServerErrorException extends ApiException {
  ServerErrorException([message]) : super("Server Error: ", message);
}