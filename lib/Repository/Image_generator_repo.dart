import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart'; // Add this

class ImageGeneratorRepo {
  static Future<File> generateImage(String prompt) async {
    String url =
        'https://api-inference.huggingface.co/models/stabilityai/stable-diffusion-3.5-large';
    //'https://api.stability.ai/v2beta/stable-image/generate/ultra';
    //'https://api.vyro.ai/v1/imagine/api/generations';

    // var headers = {
    //   'Authorization':
    //       'Bearer vk-MGQBR00FTRqrwv2gTi4XsfCDfrk2hDIzCwhXT3WEnM2PFFeI'
    // };
    final headers = {
      'Authorization': 'Bearer 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',
      'Content-Type': 'application/json',
      // 'Bearer sk-njGYqiDdU5qpLttEaM8hr5jsfpqpjqcqfaZ0HdNXdIC8eL02',
      //'Accept': 'image/*',
    };

    Map<String, dynamic> payload = {
      'prompt': prompt,
      'parameters': {
        'style_id': 'cyberpunk',
        'aspect_ratio': '16:9',
        'cfg': '7',
        'seed': '42',
        'high_res_results': 'true',
      }
    };

    // Map<String, dynamic> payload = {
    //   'prompt': prompt,
    //   'style_id': 'cyberpunk',
    //   'aspect_ratio': '16:9',
    //   'cfg': '2',
    //   'seed': '42',
    //   'high_res_results': 'true',
    // };

    try {
      // Sending a POST request using http
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);

      // Add each payload field to the request
      payload.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Sending the request and waiting for the response
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Get the app's document directory to save the file
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/image.jpg'; // Save the file here

        // Save the image
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        print('Image saved successfully at $filePath');
        return file; // Return the file if successful
      } else if (response.statusCode == 402) {
        // Payment required
        throw Exception(
            'Error: Payment Required (402). Please check your API subscription or payment details.');
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception(
          'Error: $error'); // Throw an exception in case of an error
    }
  }
}
