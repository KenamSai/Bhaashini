class PipeLinePayLoad {
  List<PipelineTasks>? pipelineTasks;
  PipelineRequestConfig? pipelineRequestConfig;

  PipeLinePayLoad({this.pipelineTasks, this.pipelineRequestConfig});

  PipeLinePayLoad.fromJson(Map<String, dynamic> json) {
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

  PipelineTasks({this.taskType});

  PipelineTasks.fromJson(Map<String, dynamic> json) {
    taskType = json['taskType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskType'] = this.taskType;
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
