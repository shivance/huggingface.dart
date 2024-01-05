import 'package:huggingface_dart/huggingface_dart.dart';

import 'models/base_args.dart';

class TranslationArgs extends BaseArgs {
  dynamic inputs;

  TranslationArgs({
    String? accessToken,
    String? model,
    required this.inputs
  }): super(accessToken: accessToken, model: model);
}

class TranslationOutputValue {
  String translation_text;

  TranslationOutputValue(this.translation_text);
}

extension TranslationExtension on HfInference{
  void translation(TranslationArgs args){

  }
}