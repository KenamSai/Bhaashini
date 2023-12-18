class NMTTranslateTextResponse {
  List<NMTPipelineResponse>? pipelineResponse;

  NMTTranslateTextResponse({this.pipelineResponse});

  NMTTranslateTextResponse.fromJson(Map<String, dynamic> json) {
    if (json['pipelineResponse'] != null) {
      pipelineResponse = <NMTPipelineResponse>[];
      json['pipelineResponse'].forEach((v) {
        pipelineResponse!.add(new NMTPipelineResponse.fromJson(v));
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

class NMTPipelineResponse {
  String? taskType;
  String? config;
  List<NMTOutput>? output;
  String? audio;

  NMTPipelineResponse({this.taskType, this.config, this.output, this.audio});

  NMTPipelineResponse.fromJson(Map<String, dynamic> json) {
    taskType = json['taskType'];
    config = json['config'];
    if (json['output'] != null) {
      output = <NMTOutput>[];
      json['output'].forEach((v) {
        output!.add(new NMTOutput.fromJson(v));
      });
    }
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskType'] = this.taskType;
    data['config'] = this.config;
    if (this.output != null) {
      data['output'] = this.output!.map((v) => v.toJson()).toList();
    }
    data['audio'] = this.audio;
    return data;
  }
}

class NMTOutput {
  String? source;
  String? target;

  NMTOutput({this.source, this.target});

  NMTOutput.fromJson(Map<String, dynamic> json) {
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
