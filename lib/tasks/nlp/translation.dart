import 'dart:convert';

import 'package:huggingface_dart/models/options.dart';
import 'package:huggingface_dart/models/translation.dart';
import 'package:huggingface_dart/tasks/utils/http_service.dart';

class TranslationService {
  final HTTPService httpService;

  TranslationService(String? accessToken)
      : httpService = HTTPService(accessToken);

  Future<TranslationOutput> translate(
      {required TranslationArgs args,
      required String model,
      OptionalArgs? optionalArgs}) async {
    Map<String, dynamic> queryParams = args.toJson();

    if (optionalArgs != null) {
      Map<String, dynamic> optionalJson = optionalArgs.toJson();
      queryParams.addAll(optionalJson);
    }

    final response =
        await httpService.makeRequest(queryParams, model, maxRetries: 10);
    print("Response = ${response.body}");

    if (response.statusCode == 200) {
      dynamic decodedResponse = json.decode(response.body);

      if (decodedResponse is List) {
        return TranslationOutput.fromJson({
          'translation_text': decodedResponse,
        });
      } else {
        throw Exception("Unexpected response format");
      }
    } else {
      throw Exception("Failed to query the translation API");
    }
  }
}
