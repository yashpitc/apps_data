import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  QuestionModel({
      this.flashcardAnswer, 
      this.createdAt, 
      this.sId, 
      this.isAll, 
      this.isEasy, 
      this.isNormal, 
      this.question, 
      this.questionType, 
      this.isHard, 
      this.isImage,
      this.startTime,
      this.id,
      this.timestamp,});

  QuestionModel.fromJson(dynamic json) {
    flashcardAnswer = json['flashcard_answer'];
    createdAt = json['createdAt'];
    sId = json['s_id'];
    isAll = json['is_all'];
    isEasy = json['is_easy'];
    isNormal = json['is_normal'];
    question = json['question'];
    questionType = json['question_type'];
    isHard = json['is_hard'];
    isImage = json['is_image'];
    startTime = json['start_time'];
    id = json['id'];
    timestamp = json['timestamp'];
  }
  String? flashcardAnswer;
  String? createdAt;
  String? sId;
  bool? isAll;
  bool? isEasy;
  bool? isNormal;
  String? question;
  String? questionType;
  bool? isHard;
  bool? isImage;
  String? startTime;
  String? id;
  Timestamp? timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['flashcard_answer'] = flashcardAnswer;
    map['createdAt'] = createdAt;
    map['s_id'] = sId;
    map['is_all'] = isAll;
    map['is_easy'] = isEasy;
    map['is_normal'] = isNormal;
    map['question'] = question;
    map['question_type'] = questionType;
    map['is_hard'] = isHard;
    map['is_image'] = isImage;
    map['start_time'] = startTime;
    map['id'] = id;
    map['timestamp'] = timestamp;
    return map;
  }

}