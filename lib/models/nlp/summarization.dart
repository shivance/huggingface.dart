class SummarizationTaskParameters {
  int? maxLength;
  double? maxTime;
  int? minLength;
  double? repetitionPenalty;
  double? temperature;
  int? topK;
  double? topP;

  SummarizationTaskParameters({
    this.maxLength,
    this.maxTime,
    this.minLength,
    this.repetitionPenalty,
    this.temperature,
    this.topK,
    this.topP,
  });

  factory SummarizationTaskParameters.fromJson(Map<String, dynamic> json) {
    return SummarizationTaskParameters(
      maxLength: json['max_length'],
      maxTime: json['max_time'],
      minLength: json['min_length'],
      repetitionPenalty: json['repetition_penalty'],
      temperature: json['temperature'],
      topK: json['top_k'],
      topP: json['top_p'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'max_length': maxLength,
      'max_time': maxTime,
      'min_length': minLength,
      'repetition_penalty': repetitionPenalty,
      'temperature': temperature,
      'top_k': topK,
      'top_p': topP,
    };
  }

  @override
  String toString() {
    return 'SummarizationTaskParameters{'
        'max_length: $maxLength, '
        'max_time: $maxTime, '
        'min_length: $minLength, '
        'repetition_penalty: $repetitionPenalty, '
        'temperature: $temperature, '
        'top_k: $topK, '
        'top_p: $topP}';
  }
}

class SummarizationArgs {
  String inputs;
  SummarizationTaskParameters? parameters;

  SummarizationArgs({required this.inputs, this.parameters});

  factory SummarizationArgs.fromJson(Map<String, dynamic> json) {
    return SummarizationArgs(
      inputs: json['inputs'],
      parameters: json['parameters'] != null
          ? SummarizationTaskParameters.fromJson(json['parameters'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'inputs': inputs,
      'parameters': parameters?.toJson(),
    };
  }

  @override
  String toString() {
    return 'SummarizationArgs{inputs: $inputs, parameters: $parameters}';
  }
}

class SummarizationOutput {
  List<dynamic> summaryText;

  SummarizationOutput(this.summaryText);

  factory SummarizationOutput.fromJson(Map<String, dynamic> json) {
    return SummarizationOutput(json['summary_text']);
  }

  Map<String, dynamic> toJson() {
    return {
      'summary_text': summaryText,
    };
  }

  @override
  String toString() {
    return 'SummarizationOutput{summaryText: $summaryText}';
  }
}
