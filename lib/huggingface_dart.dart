library huggingface_dart;

import 'dart:core';
import 'package:huggingface_dart/tasks/nlp.dart';

class HfInference {
  final String? accessToken;
  final NLPTasks nlpTasks;

  HfInference(this.accessToken) : nlpTasks = NLPTasks(accessToken);

  // NLP APIs

  Future<List<dynamic>> translate(
      {required List<dynamic> inputs,
      required String model,
      dynamic options}) async {
    return await nlpTasks.translate(
        inputs: inputs, model: model, options: options);
  }

  Future<List<dynamic>> summarize(
      {required List<dynamic> inputs,
      dynamic parameters,
      required String model,
      dynamic options}) async {
    return await nlpTasks.summarize(
        inputs: inputs, model: model, options: options);
  }

  Future<dynamic> questionAnswering(
      {required dynamic inputs, required String model, dynamic options}) async {
    return await nlpTasks.questionAnswering(
        inputs: inputs, model: model, options: options);
  }

  Future<List<dynamic>> fillMask(
      {required List<dynamic> inputs,
      required String model,
      dynamic options}) async {
    return await nlpTasks.fillMask(
        inputs: inputs, model: model, options: options);
  }

  Future<List<dynamic>> tokenClassification(
      {required List<dynamic> inputs,
      required String model,
      dynamic options}) async {
    return await nlpTasks.tokenClassification(
        inputs: inputs, model: model, options: options);
  }

  Future<List<dynamic>> textGeneration(
      {required List<dynamic> inputs,
      required String model,
      dynamic options}) async {
    return await nlpTasks.textGeneration(
        inputs: inputs, model: model, options: options);
  }

  Future<List<dynamic>> zeroShotClassification(
      {required List<dynamic> inputs,
      required dynamic parameters,
      required String model,
      dynamic options}) async {
    return await nlpTasks.zeroShotClassification(
        inputs: inputs, parameters: parameters, model: model, options: options);
  }

  Future<dynamic> tableQuestionAnswering(
      {required List<dynamic> inputs,
      required String model,
      dynamic options}) async {
    return await nlpTasks.tableQuestionAnswering(
        inputs: inputs, model: model, options: options);
  }

  Future<List<dynamic>> sentenceSimilarity(
      {required dynamic inputs, required String model, dynamic options}) async {
    return await nlpTasks.sentenceSimilarity(
        inputs: inputs, model: model, options: options);
  }

  Future<List<dynamic>> textClassification(
      {required dynamic inputs, required String model, dynamic options}) async {
    return await nlpTasks.textClassification(
        inputs: inputs, model: model, options: options);
  }

  Future<dynamic> conversational(
      {required dynamic inputs, required String model, dynamic options}) async {
    return await nlpTasks.conversational(
        inputs: inputs, model: model, options: options);
  }
}
