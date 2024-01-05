//
// Future<Map<String, dynamic>> makeRequestOptions(
//     RequestArgs args, {
//       Blob? data,
//       bool stream = false,
//       Options? options,
//       String? forceTask,
//       InferenceTask? taskHint,
//     }) async {
//   final Map<String, dynamic> argsMap = jsonDecode(jsonEncode(args));
//
//   final String? accessToken = argsMap['accessToken'];
//   String? model = argsMap['model'];
//
//   final Map<String, dynamic> optionsMap = jsonDecode(jsonEncode(options));
//
//   final String? task = forceTask ?? optionsMap['task'];
//   final String? includeCredentials = optionsMap['includeCredentials'];
//   final bool binary = data != null;
//
//   final Map<String, String> headers = {};
//   if (accessToken != null) {
//     headers['Authorization'] = 'Bearer $accessToken';
//   }
//
//   if (model == null && tasks == null && taskHint != null) {
//     final Response res = await fetch('$HF_HUB_URL/api/tasks');
//     if (res.ok) {
//       tasks = await res.json();
//     }
//   }
//
//   if (model == null && tasks != null && taskHint != null) {
//     final Map<String, dynamic>? taskInfo = tasks?[taskHint];
//     if (taskInfo != null) {
//       model = taskInfo['models'][0]['id'];
//     }
//   }
//
//   if (model == null) {
//     throw Exception('No model provided, and no default model found for this task');
//   }
//
//   if (!binary) {
//     headers['Content-Type'] = 'application/json';
//   } else {
//     if (options?.waitForModel == true) {
//       headers['X-Wait-For-Model'] = 'true';
//     }
//     if (options?.useCache == false) {
//       headers['X-Use-Cache'] = 'false';
//     }
//     if (options?.dontLoadModel == true) {
//       headers['X-Load-Model'] = '0';
//     }
//   }
//
//   final String url = isUrl(model)
//       ? model
//       : (task != null
//       ? '$HF_INFERENCE_API_BASE_URL/pipeline/$task/$model'
//       : '$HF_INFERENCE_API_BASE_URL/models/$model');
//
//   RequestCredentials? credentials;
//   if (includeCredentials is String) {
//     credentials = includeCredentials as RequestCredentials;
//   } else if (includeCredentials is bool) {
//     credentials = includeCredentials ? RequestCredentials.include : null;
//   } else if (includeCredentials == null) {
//     credentials = RequestCredentials.sameOrigin;
//   }
//
//   final RequestInit info = RequestInit(
//     headers: headers,
//     method: 'POST',
//     body: binary ? data : jsonEncode({...argsMap, 'options': optionsMap}),
//     credentials: credentials,
//     signal: options?.signal,
//   );
//
//   return {'url': url, 'info': info};
// }
//
// bool isUrl(String? value) {
//   if (value == null) return false;
//   final Uri uri = Uri.tryParse(value)!;
//   return uri.scheme.isNotEmpty && uri.host.isNotEmpty;
// }
//
// Future<T> request<T>(
//     RequestArgs args,
//     Options options, {
//       String? task,
//       InferenceTask? taskHint,
//     }) async {
//   final requestOptions = await makeRequestOptions(args, options);
//   final response = await (options.fetch ?? fetch)(requestOptions.url, requestOptions.info);
//
//   if (options.retryOnError != false && response.status == 503 && options.waitForModel != true) {
//     return request(args, options, task: task, taskHint: taskHint, waitForModel: true);
//   }
//
//   if (!response.ok) {
//     if (response.headers.get("Content-Type")?.startsWith("application/json") == true) {
//       final output = await response.json();
//       if (output["error"] != null) {
//         throw Exception(output["error"]);
//       }
//     }
//     throw Exception("An error occurred while fetching the blob");
//   }
//
//   if (response.headers.get("Content-Type")?.startsWith("application/json") == true) {
//     return response.json();
//   }
//
//   final blob = await response.blob();
//   return blob as T;
// }