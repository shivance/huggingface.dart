library huggingface_dart;

import 'dart:core';
import 'package:huggingface_dart/models/options.dart';
import 'package:huggingface_dart/models/translation.dart';
import 'package:huggingface_dart/tasks/nlp/nlp_service.dart';

class HfInference {
  final String? accessToken;
  final NLPService nlpService;

  HfInference(this.accessToken) : nlpService = NLPService(accessToken);

  // NLP APIs
  Future<TranslationOutput> translate(
      {required TranslationArgs args,
      required String model,
      OptionalArgs? optionalArgs}) async {
    return await nlpService.translate(args: args, model: model);
  }
}
