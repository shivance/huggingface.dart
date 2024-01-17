import 'package:meta/meta.dart';
import 'dart:convert';

abstract class BaseArgs {
  Map<String, dynamic> toJson();
}

FillMaskArgs fillMaskArgsFromJson(String str) =>
    FillMaskArgs.fromJson(json.decode(str));

String fillMaskArgsToJson(FillMaskArgs data) => json.encode(data.toJson());

class FillMaskArgs extends BaseArgs {
  List<dynamic> inputs;

  FillMaskArgs({
    required this.inputs,
  });

  factory FillMaskArgs.fromList(List<dynamic> inputs) {
    return FillMaskArgs(inputs: inputs);
  }

  FillMaskArgs copyWith({
    List<dynamic>? inputs,
  }) =>
      FillMaskArgs(
        inputs: inputs ?? this.inputs,
      );

  factory FillMaskArgs.fromJson(Map<String, dynamic> json) => FillMaskArgs(
        inputs: List<dynamic>.from(json["inputs"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "inputs": List<dynamic>.from(inputs.map((x) => x)),
      };
}

// To parse this JSON data, do
//
//     final fillMaskOutput = fillMaskOutputFromJson(jsonString);

List<FillMaskOutput> fillMaskOutputFromJson(List<dynamic> list) {
  return list.map((jsonObject) => FillMaskOutput.fromJson(jsonObject)).toList();
}

String fillMaskOutputToJson(List<FillMaskOutput> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FillMaskOutputItem {
  String sequence;
  double score;
  int token;
  String tokenStr;

  FillMaskOutputItem({
    required this.sequence,
    required this.score,
    required this.token,
    required this.tokenStr,
  });

  FillMaskOutputItem copyWith({
    String? sequence,
    double? score,
    int? token,
    String? tokenStr,
  }) =>
      FillMaskOutputItem(
        sequence: sequence ?? this.sequence,
        score: score ?? this.score,
        token: token ?? this.token,
        tokenStr: tokenStr ?? this.tokenStr,
      );

  factory FillMaskOutputItem.fromJson(Map<String, dynamic> json) =>
      FillMaskOutputItem(
        sequence: json["sequence"],
        score: json["score"]?.toDouble(),
        token: json["token"],
        tokenStr: json["token_str"],
      );

  Map<String, dynamic> toJson() => {
        "sequence": sequence,
        "score": score,
        "token": token,
        "token_str": tokenStr,
      };
}

class FillMaskOutput {
  List<FillMaskOutputItem> outputs;

  FillMaskOutput({required this.outputs});

  FillMaskOutput copyWith({
    List<FillMaskOutputItem>? outputs,
  }) =>
      FillMaskOutput(
        outputs: outputs ?? this.outputs,
      );

  factory FillMaskOutput.fromJson(Map<String, dynamic> json) {
    return FillMaskOutput(
      outputs: (json['outputs'] as List<dynamic>)
          .map((itemJson) => FillMaskOutputItem.fromJson(itemJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'outputs': outputs.map((item) => item.toJson()).toList(),
    };
  }
}
