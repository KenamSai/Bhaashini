class PipeLineWithConfigPayLoad {
  List<PipelineTasks>? pipelineTasks;
  PipelineRequestConfig? pipelineRequestConfig;

  PipeLineWithConfigPayLoad({this.pipelineTasks, this.pipelineRequestConfig});

  PipeLineWithConfigPayLoad.fromJson(Map<String, dynamic> json) {
    if (json['pipelineTasks'] != null) {
      pipelineTasks = <PipelineTasks>[];
      json['pipelineTasks'].forEach((v) {
        pipelineTasks!.add(new PipelineTasks.fromJson(v));
      });
    }
    pipelineRequestConfig = json['pipelineRequestConfig'] != null
        ? new PipelineRequestConfig.fromJson(json['pipelineRequestConfig'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pipelineTasks != null) {
      data['pipelineTasks'] =
          this.pipelineTasks!.map((v) => v.toJson()).toList();
    }
    if (this.pipelineRequestConfig != null) {
      data['pipelineRequestConfig'] = this.pipelineRequestConfig!.toJson();
    }
    return data;
  }
}

class PipelineTasks {
  String? taskType;
  Config? config;

  PipelineTasks({this.taskType, this.config});

  PipelineTasks.fromJson(Map<String, dynamic> json) {
    taskType = json['taskType'];
    config =
        json['config'] != null ? new Config.fromJson(json['config']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskType'] = this.taskType;
    if (this.config != null) {
      data['config'] = this.config!.toJson();
    }
    return data;
  }
}

class Config {
  Language? language;

  Config({this.language});

  Config.fromJson(Map<String, dynamic> json) {
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.language != null) {
      data['language'] = this.language!.toJson();
    }
    return data;
  }
}

class Language {
  String? sourceLanguage;
  String? targetLanguage;

  Language({this.sourceLanguage, this.targetLanguage});

  Language.fromJson(Map<String, dynamic> json) {
    sourceLanguage = json['sourceLanguage'];
    targetLanguage = json['targetLanguage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sourceLanguage'] = this.sourceLanguage;
    data['targetLanguage'] = this.targetLanguage;
    return data;
  }
}

class PipelineRequestConfig {
  String? pipelineId;

  PipelineRequestConfig({this.pipelineId});

  PipelineRequestConfig.fromJson(Map<String, dynamic> json) {
    pipelineId = json['pipelineId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pipelineId'] = this.pipelineId;
    return data;
  }
}
