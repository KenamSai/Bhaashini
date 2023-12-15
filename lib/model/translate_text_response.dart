class TranslateTextResponse {
  List<PipelineResponse>? pipelineResponse;

  TranslateTextResponse({this.pipelineResponse});

  TranslateTextResponse.fromJson(Map<String, dynamic> json) {
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
  String? config;
  List<Output>? output;
  String? audio;

  PipelineResponse({this.taskType, this.config, this.output, this.audio});

  PipelineResponse.fromJson(Map<String, dynamic> json) {
    taskType = json['taskType'];
    config = json['config'];
    if (json['output'] != null) {
      output = <Output>[];
      json['output'].forEach((v) {
        output!.add(new Output.fromJson(v));
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
