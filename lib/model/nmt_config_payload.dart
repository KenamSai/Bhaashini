class NMTConfigPayload {
  Language? language;
  String? serviceId;

  NMTConfigPayload({this.language, this.serviceId});

  NMTConfigPayload.fromJson(Map<String, dynamic> json) {
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
