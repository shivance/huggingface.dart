library huggingface_dart;

import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart';
import 'package:huggingface_dart/models/options.dart';
import 'package:huggingface_dart/models/translation.dart';

class HfInference {
  final String? accessToken;
  final String apiUrl = "https://api-inference.huggingface.co/models";

  HfInference(this.accessToken);

  Future<Response> queryHF(
      Map<String, dynamic> queryParams, String model) async {
    final Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    String endpointUrl = "$apiUrl/$model";

    final Response response = await post(Uri.parse(endpointUrl),
        headers: headers, body: json.encode(queryParams));

    return response;
  }

  Future<Response> queryHFWithRetries(
      Map<String, dynamic> queryParams, String model,
      {int maxRetries = 5}) async {
    int retryCount = 0;
    Exception? lastError;

    while (retryCount < maxRetries) {
      try {
        Response response = await queryHF(queryParams, model);

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

  Future<TranslationOutput> translate(
      {required TranslationArgs args,
      required String model,
      OptionalArgs? optionalArgs}) async {
    Map<String, dynamic> queryParams = args.toJson();

    if (optionalArgs != null) {
      Map<String, dynamic> optionalJson = optionalArgs.toJson();
      queryParams.addAll(optionalJson);
    }

    final response = await queryHFWithRetries(
      queryParams,
      model,
    );

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
