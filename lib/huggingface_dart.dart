library huggingface_dart;
import 'dart:convert';

import 'package:http/http.dart' as http;



class InferenceAPI {
  final String apiUrl;
  final String apiToken;

  InferenceAPI(this.apiUrl, this.apiToken);

  Future<List<dynamic>> query(String payload) async {
    final Map<String, String> headers = {
      "Authorization": "Bearer $apiToken"
    };
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(({"inputs": payload})),
    );

    print(response);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to query the API");
    }
    }
  }

class HfInference{
  final String apiToken;

  HfInference(this.apiToken);

}


void main() async{
  final String apiUrl = "https://api-inference.huggingface.co/models/gpt2";
  final String apiToken = "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";

  final InferenceAPI inferenceAPI = InferenceAPI(apiUrl, apiToken );

  try {
    List<dynamic> data = await inferenceAPI.query("Can you please let us know more details about your");
    print(data);
  } catch (e) {
    print("Error: $e");
  }
}