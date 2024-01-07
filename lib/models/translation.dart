class TranslationArgs {
  dynamic inputs;

  TranslationArgs({required this.inputs});

  Map<String, dynamic> toJson() {
    if (inputs is String) {
      return {"inputs": inputs};
    } else if (inputs is List<String>) {
      return {"inputs": inputs};
    } else {
      throw ArgumentError(
          "Invalid type for 'inputs'. Expected String or List<String>.");
    }
  }

  @override
  String toString() {
    return 'TranslationArgs{${super.toString()}, inputs: $inputs}';
  }
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
