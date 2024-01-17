class Inputs {
  String context;
  String question;

  Inputs({required this.context, required this.question});

  Map<String, dynamic> toJson() {
    return {"context": context, "question": question};
  }

  factory Inputs.fromJson(Map<String, dynamic> json) {
    return Inputs(context: json['context'], question: json['question']);
  }
}

class QuestionAnsweringArgs {
  Inputs inputs;

  QuestionAnsweringArgs({required this.inputs});

  Map<String, dynamic> toJson() {
    return {'inputs': inputs.toJson()};
  }

  factory QuestionAnsweringArgs.fromJson(Map<String, dynamic> json) {
    return QuestionAnsweringArgs(inputs: Inputs.fromJson(json['inputs']));
  }
}

class QuestionAnsweringOutput {
  String answer;
  int start;
  int end;
  double score;

  QuestionAnsweringOutput(
      {required this.answer,
      required this.start,
      required this.end,
      required this.score});

  factory QuestionAnsweringOutput.fromJson(Map<String, dynamic> json) {
    return QuestionAnsweringOutput(
        answer: json['answer'],
        start: json['start'],
        end: json['end'],
        score: json['score']);
  }
}
