import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;
  Future<Either<Exception, dynamic>> getData() async {
    http.Response response;
    try {
      response = await http.get(url);
      return right(jsonDecode(response.body));
    } catch (exception) {
      return left(exception);
    }
  }
}
