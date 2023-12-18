class NMTTranslateTextPayload {
  List<NMTPipelineTasks>? pipelineTasks;
  NMTInputData? inputData;

  NMTTranslateTextPayload({this.pipelineTasks, this.inputData});

  NMTTranslateTextPayload.fromJson(Map<String, dynamic> json) {
    if (json['pipelineTasks'] != null) {
      pipelineTasks = <NMTPipelineTasks>[];
      json['pipelineTasks'].forEach((v) {
        pipelineTasks!.add(new NMTPipelineTasks.fromJson(v));
      });
    }
    inputData = json['inputData'] != null
        ? new NMTInputData.fromJson(json['inputData'])
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

class NMTPipelineTasks {
  String? taskType;
  NMTConfig? config;

  NMTPipelineTasks({this.taskType, this.config});

  NMTPipelineTasks.fromJson(Map<String, dynamic> json) {
    taskType = json['taskType'];
    config =
        json['config'] != null ? new NMTConfig.fromJson(json['config']) : null;
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

class NMTConfig {
  NMTLanguage? language;
  String? serviceId;

  NMTConfig({this.language, this.serviceId});

  NMTConfig.fromJson(Map<String, dynamic> json) {
    language = json['language'] != null
        ? new NMTLanguage.fromJson(json['language'])
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

class NMTLanguage {
  String? sourceLanguage;
  String? targetLanguage;

  NMTLanguage({this.sourceLanguage, this.targetLanguage});

  NMTLanguage.fromJson(Map<String, dynamic> json) {
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

class NMTInputData {
  List<NMTInput>? input;

  NMTInputData({this.input});

  NMTInputData.fromJson(Map<String, dynamic> json) {
    if (json['input'] != null) {
      input = <NMTInput>[];
      json['input'].forEach((v) {
        input!.add(new NMTInput.fromJson(v));
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

class NMTInput {
  String? source;

  NMTInput({this.source});

  NMTInput.fromJson(Map<String, dynamic> json) {
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source'] = this.source;
    return data;
  }
}
