import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? receiverUid;
  String? senderUid;
  String? text;
  Timestamp? dateTime;

  MessageModel({
    required this.receiverUid,
    required this.senderUid,
    required this.text,
     this.dateTime,
  });

  MessageModel.fromJson(Map<String,dynamic> json){
    receiverUid=json['receiverUid'];
    senderUid=json['senderUid'];
    text=json['text'];
    dateTime=json['dateTime'];
  }

  Map<String,dynamic> toJson(){
    return {
      'receiverUid':receiverUid,
      'senderUid':senderUid,
      'text':text,
      'dateTime':dateTime,
    };
  }

}

