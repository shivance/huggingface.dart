import 'dart:ffi';
import 'dart:html';

class BaseArgs{
  String? accessToken;
  String? model;

  BaseArgs({this.accessToken, this.model});
}

class Options{
  bool retry_on_error;
  bool use_cache;
  bool dont_load_model;
  bool use_gpu;
  bool wait_for_model;
  Function? fetch;
  dynamic includeCredentials;

  Options({
    this.retry_on_error = true,
    this.use_cache = true,
    this.dont_load_model = false,
    this.use_gpu = false,
    this.wait_for_model = false,
    this.fetch,
    this.includeCredentials = "same-origin"
  });
}