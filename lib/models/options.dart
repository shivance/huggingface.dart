class OptionalArgs{
  bool useCache;
  bool waitForModel;

  OptionalArgs({
    this.useCache = true,
    this.waitForModel = false,
  });

  Map<String, dynamic> toJson() => {
    'use_cache': useCache,
    'wait_for_model': waitForModel
  };

  factory OptionalArgs.fromJson(Map<String, dynamic> json) {
    return OptionalArgs(
      useCache: json['use_cache'] ?? true,
      waitForModel: json['wait_for_model'] ?? false,
    );
  }

  @override
  String toString(){
    return 'Options: {use_cache: $useCache, wait_for_model: $waitForModel}';
  }
}