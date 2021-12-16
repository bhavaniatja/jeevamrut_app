import 'package:http/http.dart' as http;

class HttpService {
  static Future<http.Response> getRequest() async {
    http.Response response;

    final url = Uri.parse("http://192.168.43.174:3000");
    try {
      response = await http.get(url);
      print(response);
    } on Exception catch (e) {
      throw e;
    }

    return response;
  }

  static Future<http.Response> getRequestAddress() async {
    http.Response response;

    final url = Uri.parse(
        "http://ec2-18-188-87-26.us-east-2.compute.amazonaws.com:8080/address/6ec1fa7c-e39c-46b8-9771-2e8593141973");
    try {
      response = await http.get(url);
    } on Exception catch (e) {
      throw e;
    }

    return response;
  }
}
