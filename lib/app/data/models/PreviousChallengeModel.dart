class PreviousChallengeModel {
  PreviousChallengeModel({
      this.startTime, 
      this.question, 
      this.completedTime, 
      this.id, 
      this.type,});

  PreviousChallengeModel.fromJson(dynamic json) {
    startTime = json['start_time'];
    question = json['question'];
    completedTime = json['completed_time'];
    id = json['id'];
    type = json['type'];
  }
  String? startTime;
  String? question;
  String? completedTime;
  String? id;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['start_time'] = startTime;
    map['question'] = question;
    map['completed_time'] = completedTime;
    map['id'] = id;
    map['type'] = type;
    return map;
  }

}