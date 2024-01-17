import 'package:meta/meta.dart';
import 'dart:convert';

class TranslationArgs {
  List<String> inputs;

  TranslationArgs({
    required this.inputs,
  });

  TranslationArgs copyWith({
    List<String>? inputs,
  }) =>
      TranslationArgs(
        inputs: inputs ?? this.inputs,
      );

  factory TranslationArgs.fromRawJson(String str) =>
      TranslationArgs.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TranslationArgs.fromJson(Map<String, dynamic> json) =>
      TranslationArgs(
        inputs: List<String>.from(json["inputs"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "inputs": List<dynamic>.from(inputs.map((x) => x)),
      };
}

class TranslationOutput {
  List<dynamic> translationText;

  TranslationOutput(this.translationText);

  Map<String, dynamic> toJson() => {
        'translationText': translationText,
      };

  TranslationOutput.fromJson(Map<String, dynamic> json)
      : translationText = List<dynamic>.from(json['translation_text'] ?? []);

  @override
  String toString() {
    return 'TranslationOutput{translationText: $translationText}';
  }
}
