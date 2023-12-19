class VoiceTranslationPayload {
  List<VoicePipelineTasks>? pipelineTasks;
  InputData? inputData;

  VoiceTranslationPayload({this.pipelineTasks, this.inputData});

  VoiceTranslationPayload.fromJson(Map<String, dynamic> json) {
    if (json['pipelineTasks'] != null) {
      pipelineTasks = <VoicePipelineTasks>[];
      json['pipelineTasks'].forEach((v) {
        pipelineTasks!.add(new VoicePipelineTasks.fromJson(v));
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

class VoicePipelineTasks {
  String? taskType;
  VoiceConfig? config;

  VoicePipelineTasks({this.taskType, this.config});

  VoicePipelineTasks.fromJson(Map<String, dynamic> json) {
    taskType = json['taskType'];
    config =
        json['config'] != null ? new VoiceConfig.fromJson(json['config']) : null;
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

class VoiceConfig {
  VoiceLanguage? language;
  String? serviceId;
  String? audioFormat;
  int? samplingRate;
  String? gender;

  VoiceConfig(
      {this.language,
      this.serviceId,
      this.audioFormat,
      this.samplingRate,
      this.gender});

  VoiceConfig.fromJson(Map<String, dynamic> json) {
    language = json['language'] != null
        ? new VoiceLanguage.fromJson(json['language'])
        : null;
    serviceId = json['serviceId'];
    audioFormat = json['audioFormat'];
    samplingRate = json['samplingRate'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.language != null) {
      data['language'] = this.language!.toJson();
    }
    data['serviceId'] = this.serviceId;
    data['audioFormat'] = this.audioFormat;
    data['samplingRate'] = this.samplingRate;
    data['gender'] = this.gender;
    return data;
  }
}

class VoiceLanguage {
  String? sourceLanguage;
  String? targetLanguage;

  VoiceLanguage({this.sourceLanguage, this.targetLanguage});

  VoiceLanguage.fromJson(Map<String, dynamic> json) {
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
  List<Audio>? audio;

  InputData({this.audio});

  InputData.fromJson(Map<String, dynamic> json) {
    if (json['audio'] != null) {
      audio = <Audio>[];
      json['audio'].forEach((v) {
        audio!.add(new Audio.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.audio != null) {
      data['audio'] = this.audio!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Audio {
  String? audioContent;

  Audio({this.audioContent});

  Audio.fromJson(Map<String, dynamic> json) {
    audioContent = json['audioContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audioContent'] = this.audioContent;
    return data;
  }
}
