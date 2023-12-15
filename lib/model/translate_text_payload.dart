class TranslateTextPayload {
  List<PipelineTasks>? pipelineTasks;
  InputData? inputData;

  TranslateTextPayload({this.pipelineTasks, this.inputData});

  TranslateTextPayload.fromJson(Map<String, dynamic> json) {
    if (json['pipelineTasks'] != null) {
      pipelineTasks = <PipelineTasks>[];
      json['pipelineTasks'].forEach((v) {
        pipelineTasks!.add(new PipelineTasks.fromJson(v));
      });
    }
    inputData = json['inputData'] != null
        ? new InputData.fromJson(json['inputData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pipelineTasks != null) {
      data['pipelineTasks'] =
          this.pipelineTasks!.map((v) => v.toJson()).toList();
    }
    if (this.inputData != null) {
      data['inputData'] = this.inputData!.toJson();
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
  String? serviceId;

  Config({this.language, this.serviceId});

  Config.fromJson(Map<String, dynamic> json) {
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
    serviceId = json['serviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.language != null) {
      data['language'] = this.language!.toJson();
    }
    data['serviceId'] = this.serviceId;
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

class InputData {
  List<Input>? input;

  InputData({this.input});

  InputData.fromJson(Map<String, dynamic> json) {
    if (json['input'] != null) {
      input = <Input>[];
      json['input'].forEach((v) {
        input!.add(new Input.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.input != null) {
      data['input'] = this.input!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Input {
  String? source;

  Input({this.source});

  Input.fromJson(Map<String, dynamic> json) {
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source'] = this.source;
    return data;
  }
}
