class SubjectModel {
  SubjectModel({
      this.createdAt, 
      this.subjectEnable, 
      this.optionType, 
      this.name, 
      this.totalQuestion, 
      this.index, 
      this.subjectLock,});

  SubjectModel.fromDocumentSnapshot(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    subjectEnable = json['subject_enable'];
    optionType = json['option_type'];
    name = json['name'];
    totalQuestion = json['total_question'];
    index = json['index'];
    subjectLock = json['subject_lock'];
  }
  String? createdAt;
  bool? subjectEnable;
  int? optionType;
  String? name;
  int? totalQuestion;
  int? index;
  bool? subjectLock;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createdAt'] = createdAt;
    map['subject_enable'] = subjectEnable;
    map['option_type'] = optionType;
    map['name'] = name;
    map['total_question'] = totalQuestion;
    map['index'] = index;
    map['subject_lock'] = subjectLock;
    return map;
  }

}