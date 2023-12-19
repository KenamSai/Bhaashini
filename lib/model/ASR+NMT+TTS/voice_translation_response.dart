class VoiceTranslationResponse {
  List<PipelineResponse>? pipelineResponse;

  VoiceTranslationResponse({this.pipelineResponse});

  VoiceTranslationResponse.fromJson(Map<String, dynamic> json) {
    if (json['pipelineResponse'] != null) {
      pipelineResponse = <PipelineResponse>[];
      json['pipelineResponse'].forEach((v) {
        pipelineResponse!.add(new PipelineResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pipelineResponse != null) {
      data['pipelineResponse'] =
          this.pipelineResponse!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PipelineResponse {
  String? taskType;
  Config? config;
  List<Output>? output;
  List<AudioResponse>? audio;

  PipelineResponse({this.taskType, this.config, this.output, this.audio});

  PipelineResponse.fromJson(Map<String, dynamic> json) {
    taskType = json['taskType'];
    config =
        json['config'] != null ? new Config.fromJson(json['config']) : null;
    if (json['output'] != null) {
      output = <Output>[];
      json['output'].forEach((v) {
        output!.add(new Output.fromJson(v));
      });
    }
    if (json['audio'] != null) {
      audio = <AudioResponse>[];
      json['audio'].forEach((v) {
        audio!.add(new AudioResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskType'] = this.taskType;
    if (this.config != null) {
      data['config'] = this.config!.toJson();
    }
    if (this.output != null) {
      data['output'] = this.output!.map((v) => v.toJson()).toList();
    }
    if (this.audio != null) {
      data['audio'] = this.audio!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Config {
  String? audioFormat;
  Language? language;
  String? encoding;
  int? samplingRate;

  Config({this.audioFormat, this.language, this.encoding, this.samplingRate});

  Config.fromJson(Map<String, dynamic> json) {
    audioFormat = json['audioFormat'];
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
    encoding = json['encoding'];
    samplingRate = json['samplingRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audioFormat'] = this.audioFormat;
    if (this.language != null) {
      data['language'] = this.language!.toJson();
    }
    data['encoding'] = this.encoding;
    data['samplingRate'] = this.samplingRate;
    return data;
  }
}

class Language {
  String? sourceLanguage;
  String? sourceScriptCode;

  Language({this.sourceLanguage, this.sourceScriptCode});

  Language.fromJson(Map<String, dynamic> json) {
    sourceLanguage = json['sourceLanguage'];
    sourceScriptCode = json['sourceScriptCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sourceLanguage'] = this.sourceLanguage;
    data['sourceScriptCode'] = this.sourceScriptCode;
    return data;
  }
}

class Output {
  String? source;
  String? target;

  Output({this.source, this.target});

  Output.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    target = json['target'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source'] = this.source;
    data['target'] = this.target;
    return data;
  }
}

class AudioResponse {
  String? audioContent;
  String? audioUri;

  AudioResponse({this.audioContent, this.audioUri});

  AudioResponse.fromJson(Map<String, dynamic> json) {
    audioContent = json['audioContent'];
    audioUri = json['audioUri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audioContent'] = this.audioContent;
    data['audioUri'] = this.audioUri;
    return data;
  }
}
