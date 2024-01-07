import 'package:huggingface_dart/models/options.dart';
import 'package:huggingface_dart/models/translation.dart';
import 'package:huggingface_dart/tasks/nlp/translation.dart';

class NLPService {
  final String? accessToken;
  final TranslationService translationService;

  NLPService(this.accessToken)
      : translationService = TranslationService(accessToken);

  Future<TranslationOutput> translate(
      {required TranslationArgs args,
      required String model,
      OptionalArgs? optionalArgs}) async {
    return await translationService.translate(args: args, model: model);
  }
}
