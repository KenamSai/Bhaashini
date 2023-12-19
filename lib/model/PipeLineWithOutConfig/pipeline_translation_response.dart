class PipeLineTranslationResponse {
  List<Languages>? languages;
  List<PipelineResponseConfig>? pipelineResponseConfig;
  String? feedbackUrl;
  PipelineInferenceAPIEndPoint? pipelineInferenceAPIEndPoint;
  PipelineInferenceAPIEndPoint? pipelineInferenceSocketEndPoint;

  PipeLineTranslationResponse(
      {this.languages,
      this.pipelineResponseConfig,
      this.feedbackUrl,
      this.pipelineInferenceAPIEndPoint,
      this.pipelineInferenceSocketEndPoint});

  PipeLineTranslationResponse.fromJson(Map<String, dynamic> json) {
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(new Languages.fromJson(v));
      });
    }
    if (json['pipelineResponseConfig'] != null) {
      pipelineResponseConfig = <PipelineResponseConfig>[];
      json['pipelineResponseConfig'].forEach((v) {
        pipelineResponseConfig!.add(new PipelineResponseConfig.fromJson(v));
      });
    }
    feedbackUrl = json['feedbackUrl'];
    pipelineInferenceAPIEndPoint = json['pipelineInferenceAPIEndPoint'] != null
        ? new PipelineInferenceAPIEndPoint.fromJson(
            json['pipelineInferenceAPIEndPoint'])
        : null;
    pipelineInferenceSocketEndPoint =
        json['pipelineInferenceSocketEndPoint'] != null
            ? new PipelineInferenceAPIEndPoint.fromJson(
                json['pipelineInferenceSocketEndPoint'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.languages != null) {
      data['languages'] = this.languages!.map((v) => v.toJson()).toList();
    }
    if (this.pipelineResponseConfig != null) {
      data['pipelineResponseConfig'] =
          this.pipelineResponseConfig!.map((v) => v.toJson()).toList();
    }
    data['feedbackUrl'] = this.feedbackUrl;
    if (this.pipelineInferenceAPIEndPoint != null) {
      data['pipelineInferenceAPIEndPoint'] =
          this.pipelineInferenceAPIEndPoint!.toJson();
    }
    if (this.pipelineInferenceSocketEndPoint != null) {
      data['pipelineInferenceSocketEndPoint'] =
          this.pipelineInferenceSocketEndPoint!.toJson();
    }
    return data;
  }
}

class Languages {
  String? sourceLanguage;
  List<String>? targetLanguageList;

  Languages({this.sourceLanguage, this.targetLanguageList});

  Languages.fromJson(Map<String, dynamic> json) {
    sourceLanguage = json['sourceLanguage'];
    targetLanguageList = json['targetLanguageList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sourceLanguage'] = this.sourceLanguage;
    data['targetLanguageList'] = this.targetLanguageList;
    return data;
  }
}

class PipelineResponseConfig {
  String? taskType;
  List<Config>? config;

  PipelineResponseConfig({this.taskType, this.config});

  PipelineResponseConfig.fromJson(Map<String, dynamic> json) {
    taskType = json['taskType'];
    if (json['config'] != null) {
      config = <Config>[];
      json['config'].forEach((v) {
        config!.add(new Config.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskType'] = this.taskType;
    if (this.config != null) {
      data['config'] = this.config!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Config {
  String? serviceId;
  String? modelId;
  Language? language;

  Config({this.serviceId, this.modelId, this.language});

  Config.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    modelId = json['modelId'];
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceId'] = this.serviceId;
    data['modelId'] = this.modelId;
    if (this.language != null) {
      data['language'] = this.language!.toJson();
    }
    return data;
  }
}

class Language {
  String? sourceLanguage;
  String? sourceScriptCode;
  String? targetLanguage;
  String? targetScriptCode;

  Language(
      {this.sourceLanguage,
      this.sourceScriptCode,
      this.targetLanguage,
      this.targetScriptCode});

  Language.fromJson(Map<String, dynamic> json) {
    sourceLanguage = json['sourceLanguage'];
    sourceScriptCode = json['sourceScriptCode'];
    targetLanguage = json['targetLanguage'];
    targetScriptCode = json['targetScriptCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sourceLanguage'] = this.sourceLanguage;
    data['sourceScriptCode'] = this.sourceScriptCode;
    data['targetLanguage'] = this.targetLanguage;
    data['targetScriptCode'] = this.targetScriptCode;
    return data;
  }
}

class PipelineInferenceAPIEndPoint {
  String? callbackUrl;
  InferenceApiKey? inferenceApiKey;
  bool? isMultilingualEnabled;
  bool? isSyncApi;

  PipelineInferenceAPIEndPoint(
      {this.callbackUrl,
      this.inferenceApiKey,
      this.isMultilingualEnabled,
      this.isSyncApi});

  PipelineInferenceAPIEndPoint.fromJson(Map<String, dynamic> json) {
    callbackUrl = json['callbackUrl'];
    inferenceApiKey = json['inferenceApiKey'] != null
        ? new InferenceApiKey.fromJson(json['inferenceApiKey'])
        : null;
    isMultilingualEnabled = json['isMultilingualEnabled'];
    isSyncApi = json['isSyncApi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['callbackUrl'] = this.callbackUrl;
    if (this.inferenceApiKey != null) {
      data['inferenceApiKey'] = this.inferenceApiKey!.toJson();
    }
    data['isMultilingualEnabled'] = this.isMultilingualEnabled;
    data['isSyncApi'] = this.isSyncApi;
    return data;
  }
}

class InferenceApiKey {
  String? name;
  String? value;

  InferenceApiKey({this.name, this.value});

  InferenceApiKey.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}
