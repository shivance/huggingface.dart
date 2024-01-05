import 'dart:convert';
import 'package:http/http.dart' as http;

class InferenceOutputError extends TypeError {
  InferenceOutputError(String message) : super("Invalid inference output: $message. Use the 'request' method with the same parameters to do a custom call with no type checking.") {
    this.name = "InferenceOutputError";
  }
}

class Options {
  bool retryOnError;
  bool useCache;
  bool dontLoadModel;
  bool useGPU;
  bool waitForModel;
  http.Client fetch;
  http.Request request;
  http.Response response;

  Options({
    this.retryOnError = true,
    this.useCache = true,
    this.dontLoadModel = false,
    this.useGPU = false,
    this.waitForModel = false,
    this.fetch,
    this.request,
    this.response,
  });
}

class InferenceTask {
  String value;

  InferenceTask(this.value);
}

class BaseArgs {
  String accessToken;
  String model;

  BaseArgs({this.accessToken, this.model});
}

class RequestArgs extends BaseArgs {
  dynamic data;
  dynamic inputs;
  Map<String, dynamic> parameters;

  RequestArgs({
    String accessToken,
    String model,
    this.data,
    this.inputs,
    this.parameters,
  }) : super(accessToken: accessToken, model: model);
}

class TextGenerationParameters {
  bool doSample;
  int maxNewTokens;

  TextGenerationParameters({this.doSample, this.maxNewTokens});

  Map<String, dynamic> toJson() {
    return {
      'do_sample': doSample,
      'max_new_tokens': maxNewTokens,
    };
  }
}

class TextGenerationArgs extends BaseArgs {
  String inputs;
  TextGenerationParameters parameters;

  TextGenerationArgs({
    String accessToken,
    String model,
    this.inputs,
    this.parameters,
  }) : super(accessToken: accessToken, model: model);

  Map<String, dynamic> toJson() {
    return {
      'inputs': inputs,
      'parameters': parameters?.toJson(),
      ...super.toJson(),
    };
  }
}

class TextGenerationOutput {
  String generatedText;

  TextGenerationOutput({this.generatedText});

  factory TextGenerationOutput.fromJson(Map<String, dynamic> json) {
    return TextGenerationOutput(
      generatedText: json['generated_text'],
    );
  }
}

class TextGenerationAPI {
  final String apiUrl;
  final String apiToken;

  TextGenerationAPI(this.apiUrl, this.apiToken);

  Future<TextGenerationOutput> generateText(String prompt, {TextGenerationParameters parameters}) async {
    final args = TextGenerationArgs(
      accessToken: apiToken,
      model: apiUrl,
      inputs: prompt,
      parameters: parameters,
    );

    final options = Options(retryOnError: true, waitForModel: false);

    try {
      final response = await request<TextGenerationOutput>(args, options: options);
      return response;
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }
}

Future<T> request<T>(RequestArgs args, {Options options}) async {
  final requestOptions = await makeRequestOptions(args, options);
  final response = await (options?.fetch ?? http.Client()).send(requestOptions.request);

  if (options?.retryOnError != false && response.statusCode == 503 && !options?.waitForModel) {
    return request(args, options: Options(
    ...options?.toJson(),
      waitForModel: true,
    ));
  }

  if (!response.statusCode.isOk) {
  final contentType = response.headers['Content-Type'];
  if (contentType?.startsWith('application/json') ?? false) {
  final output = json.decode(await utf8.decodeStream(response.stream));
  if (output['error'] != null) {
  throw Exception(output['error']);
  }
  }
  throw Exception("An error occurred while fetching the blob");
  }

  if (response.headers['Content-Type']?.startsWith('application/json') ?? false) {
  return json.decode(await utf8.decodeStream(response.stream));
  }

  final blob = await response.stream.toBytes();
  return blob as T;
}

Future<Map<String, dynamic>> makeRequestOptions(RequestArgs args, Options options) async {
  // Implement your logic here to create and return the request options.
  // This may include setting headers, encoding, etc.
  // For simplicity, I've kept it as a placeholder.

  // In a real-world scenario, you would set appropriate headers, encode the data, etc.
  final request = http.Request('POST', Uri.parse(args.model));
  request.headers.addAll({'Content-Type': 'application/json'});
  request.body = jsonEncode(args.toJson());

  return Options(
    request: request,
  );
}

void main() async {
  final apiUrl = "https://api-inference.huggingface.co/models/gpt2";
  final apiToken = "your_api_token"; // Replace with your actual API token

  final textGenerationAPI = TextGenerationAPI(apiUrl, apiToken);

  try {
    final parameters = TextGenerationParameters(doSample: true, maxNewTokens: 50);
    final generatedText = await textGenerationAPI.generateText("Can you please let us know more details about your", parameters: parameters);
    print(generatedText.generatedText);
  } catch (e) {
    print("Error: $e");
  }
}
