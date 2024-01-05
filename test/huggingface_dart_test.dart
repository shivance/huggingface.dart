import 'package:flutter_test/flutter_test.dart';

import 'package:huggingface_dart/huggingface_dart.dart';

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