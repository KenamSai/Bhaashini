class ASRConfigPayload {
  Language? language;
  String? serviceId;
  String? audioFormat;
  int? samplingRate;

  ASRConfigPayload(
      {this.language, this.serviceId, this.audioFormat, this.samplingRate});

  ASRConfigPayload.fromJson(Map<String, dynamic> json) {
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
    serviceId = json['serviceId'];
    audioFormat = json['audioFormat'];
    samplingRate = json['samplingRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.language != null) {
      data['language'] = this.language!.toJson();
    }
    data['serviceId'] = this.serviceId;
    data['audioFormat'] = this.audioFormat;
    data['samplingRate'] = this.samplingRate;
    return data;
  }
}

class Language {
  String? sourceLanguage;

  Language({this.sourceLanguage});

  Language.fromJson(Map<String, dynamic> json) {
    sourceLanguage = json['sourceLanguage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sourceLanguage'] = this.sourceLanguage;
    return data;
  }
}
