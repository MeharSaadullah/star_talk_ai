import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:star_talk_ai/Data/base_api_services.dart';

class NetworkApiServices implements BaseAppiServices {
  @override
  //...................GET Api......................

  Future getApi(String url) async {
    dynamic jsonResponse;
    // // TODO: implement getApi
    // throw UnimplementedError();

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 30));
      jsonResponse = returnResponse(response);
      if (response.statusCode == 200) {}
    } catch (E) {}
    // on SocketException {
    //   throw NoInternetException(
    //       ""); //here no internet exception come from app_exceptions
    // } on TimeoutException {
    //   FetchDataException("Time out Try Agian");
    // }
    return jsonResponse;
  }

  @override
  //......................POST Api..................

  Future<http.Response> postApi(String url, var data) async {
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json', // Set content type to JSON
            },
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 30));

      return response; // Return the raw HTTP response
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to load data");
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 401:
        log('Error: ${response.body}');
        // You might want to throw specific exceptions here
        return jsonDecode(response.body);
      default:
        log('Error: ${response.statusCode} ${response.body}');
        throw Exception('Failed to fetch data: ${response.statusCode}');

      //   throw UnauthorisedException();
      // case 500:
      //   throw FetchDataException(
      //       "Error communication with server" + response.statusCode.toString());
    }
  }
}
