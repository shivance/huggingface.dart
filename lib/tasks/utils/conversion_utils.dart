// Utility function to convert dynamic args to specific args type
import 'package:huggingface_dart/models/nlp/fillMask.dart';
import 'package:huggingface_dart/models/options.dart';

T convertToArgs<T>(dynamic args, T Function(Map<String, dynamic>) fn) {
  print(args.runtimeType is Map<String, dynamic>);
  print("T == $T");
  if (args is T) {
    return args;
  } else if (args is Map<String, dynamic>) {
    return fn(args);
  } else {
    throw ArgumentError("Invalid type for 'args'");
  }
}

Map<String, dynamic> getArgs(dynamic args, OptionalArgs? optionalArgs) {
  if (args is BaseArgs) {
    Map<String, dynamic> queryParams = args.toJson();

    if (optionalArgs != null) {
      Map<String, dynamic> optionalJson = optionalArgs.toJson();
      queryParams.addAll(optionalJson);
    }

    return queryParams;
  } else {
    throw ArgumentError("Invalid type for 'args'");
  }
}
