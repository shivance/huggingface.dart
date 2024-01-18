import 'dart:convert';

import 'package:huggingface_dart/tasks/utils/http.dart';

class NLPTasks {
  final String? accessToken;
  final HTTPService httpService;

  NLPTasks(this.accessToken) : httpService = HTTPService(accessToken);

  Future<List<dynamic>> translate(
      {required List<dynamic> inputs,
      required String model,
      dynamic options}) async {
    Map<String, dynamic> queryParams = {
      'inputs': inputs,
    };
    if (options != null) {
      queryParams.addAll(options);
    }
    final response = await httpService.makeRequest(queryParams, model);
    handleHttpError(response);

    dynamic decodedResponse = json.decode(response.body);
    return decodedResponse;
  }

  Future<List<dynamic>> summarize(
      {required List<dynamic> inputs,
      dynamic parameters,
      required String model,
      dynamic options}) async {
    Map<String, dynamic> queryParams = {
      'inputs': inputs,
    };
    if (options != null) {
      queryParams.addAll(options);
    }
    final response = await httpService.makeRequest(queryParams, model);
    handleHttpError(response);

    dynamic decodedResponse = json.decode(response.body);
    return decodedResponse;
  }

  Future<dynamic> questionAnswering(
      {required dynamic inputs, required String model, dynamic options}) async {
    Map<String, dynamic> queryParams = {
      'inputs': inputs,
    };
    if (options != null) {
      queryParams.addAll(options);
    }
    final response = await httpService.makeRequest(queryParams, model);
    handleHttpError(response);

    dynamic decodedResponse = json.decode(response.body);
    return decodedResponse;
  }

  Future<List<dynamic>> fillMask(
      {required List<dynamic> inputs,
      required String model,
      dynamic options}) async {
    Map<String, dynamic> queryParams = {
      'inputs': inputs,
    };
    if (options != null) {
      queryParams.addAll(options);
    }
    final response = await httpService.makeRequest(queryParams, model);
    handleHttpError(response);

    dynamic decodedResponse = json.decode(response.body);
    return decodedResponse;
  }

  Future<List<dynamic>> tokenClassification(
      {required List<dynamic> inputs,
      required String model,
      dynamic options}) async {
    Map<String, dynamic> queryParams = {
      'inputs': inputs,
    };
    if (options != null) {
      queryParams.addAll(options);
    }

    final response = await httpService.makeRequest(queryParams, model);
    handleHttpError(response);

    dynamic decodedResponse = json.decode(response.body);
    return decodedResponse;
  }

  Future<List<dynamic>> textGeneration(
      {required List<dynamic> inputs,
      required String model,
      dynamic options}) async {
    Map<String, dynamic> queryParams = {
      'inputs': inputs,
    };
    if (options != null) {
      queryParams.addAll(options);
    }
    final response = await httpService.makeRequest(queryParams, model);
    handleHttpError(response);

    dynamic decodedResponse = json.decode(response.body);
    return decodedResponse;
  }

  Future<List<dynamic>> zeroShotClassification(
      {required List<dynamic> inputs,
      required dynamic parameters,
      required String model,
      dynamic options}) async {
    Map<String, dynamic> queryParams = {
      'inputs': inputs,
      'parameters': parameters
    };
    if (options != null) {
      queryParams.addAll(options);
    }

    final response = await httpService.makeRequest(queryParams, model);
    handleHttpError(response);

    dynamic decodedResponse = json.decode(response.body);
    return decodedResponse;
  }

  Future<dynamic> tableQuestionAnswering(
      {required List<dynamic> inputs,
      required String model,
      dynamic options}) async {
    Map<String, dynamic> queryParams = {
      'inputs': inputs,
    };

    if (options != null) {
      queryParams.addAll(options);
    }

    final response = await httpService.makeRequest(queryParams, model);
    handleHttpError(response);

    dynamic decodedResponse = json.decode(response.body);
    return decodedResponse;
  }

  Future<List<dynamic>> sentenceSimilarity(
      {required dynamic inputs, required String model, dynamic options}) async {
    Map<String, dynamic> queryParams = {
      'inputs': inputs,
    };
    if (options != null) {
      queryParams.addAll(options);
    }

    final response = await httpService.makeRequest(queryParams, model);
    handleHttpError(response);

    dynamic decodedResponse = json.decode(response.body);
    return decodedResponse;
  }

  Future<List<dynamic>> textClassification(
      {required dynamic inputs, required String model, dynamic options}) async {
    Map<String, dynamic> queryParams = {
      'inputs': inputs,
    };
    if (options != null) {
      queryParams.addAll(options);
    }

    final response = await httpService.makeRequest(queryParams, model);
    handleHttpError(response);

    dynamic decodedResponse = json.decode(response.body);
    return decodedResponse;
  }

  Future<dynamic> conversational(
      {required dynamic inputs, required String model, dynamic options}) async {
    Map<String, dynamic> queryParams = {
      'inputs': inputs,
    };
    if (options != null) {
      queryParams.addAll(options);
    }

    final response = await httpService.makeRequest(queryParams, model);
    handleHttpError(response);

    dynamic decodedResponse = json.decode(response.body);
    return decodedResponse;
  }
}
