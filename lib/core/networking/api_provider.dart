import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_exception.dart';

class ApiProvider {
  final http.Client httpClient;

  ApiProvider({this.httpClient})
      : assert(httpClient != null);

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await httpClient.get(url);
      responseJson = _response(response);
    } on SocketException {
      throw DefaultException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        if (response.body.toString().isEmpty){
          throw DefaultException('Data not found');
        }

        var responseJson;
        try{
          responseJson = json.decode(response.body.toString());
        } on FormatException{
          throw DefaultException('Data incompatible');
        }

        return responseJson;
      case 400:
        throw ClientErrorException(response.body.toString());
      case 500:
        throw ServerErrorException(response.body.toString());
      default:
        throw DefaultException(response.statusCode.toString());
    }
  }
}