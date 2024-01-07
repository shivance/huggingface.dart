import 'package:http/http.dart' as http;
import 'dart:convert';

class HTTPService {
  final String? accessToken;
  final String apiUrl = "https://api-inference.huggingface.co/models";

  HTTPService(this.accessToken);

  Future<http.Response> makeRequest(
      Map<String, dynamic> queryParams, String model,
      {int maxRetries = 3}) async {
    int retryCount = 0;
    Exception? lastError;

    while (retryCount < maxRetries) {
      try {
        final Map<String, String> headers = {
          "Authorization": "Bearer $accessToken",
          "Content-Type": "application/json",
        };

        String endpointUrl = "$apiUrl/$model";

        final http.Response response = await http.post(Uri.parse(endpointUrl),
            headers: headers, body: json.encode(queryParams));

        if (response.statusCode == 200) {
          return response;
        } else {
          lastError ??=
              Exception("Received non-200 status code: ${response.statusCode}");
          print(lastError);
        }
      } catch (e) {
        lastError ??= e as Exception;
        print("Error: $e");
      }

      print("Retrying... (${retryCount + 1}/$maxRetries)");
      retryCount++;

      // You can add a delay between retries if needed.
      await Future.delayed(Duration(seconds: 1));
    }

    // If all retries fail, throw the last encountered error.
    throw lastError ??
        Exception("Failed to query the API after $maxRetries retries");
  }
}
