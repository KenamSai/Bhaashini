class TTSConfigPayload {
  Language? language;
  String? serviceId;
  String? gender;
  int? samplingRate;

  TTSConfigPayload(
      {this.language, this.serviceId, this.gender, this.samplingRate});

  TTSConfigPayload.fromJson(Map<String, dynamic> json) {
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
    serviceId = json['serviceId'];
    gender = json['gender'];
    samplingRate = json['samplingRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.language != null) {
      data['language'] = this.language!.toJson();
    }
    data['serviceId'] = this.serviceId;
    data['gender'] = this.gender;
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
