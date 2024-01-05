class PostModel{
  String? postId;
  String? name;
  String? uid;
  String? image;
  String? dateTime;
  String? postImage;
  String? text;
  int commentsLength=0;
  int likesLength=0;

  PostModel({
    required this.name,
    required this.uid,
    required this.image,
    required this.dateTime,
    this.postImage,
    this.text,
    required this.commentsLength,
    required this.likesLength,
  });

  PostModel.fromJson(Map<String,dynamic>? json)
  {
    name=json!['name'];
    uid=json['uid'];
    image=json['image'];
    dateTime=json['dateTime'];
    postImage=json['postImage'];
    text=json['text'];
    commentsLength=json['commentsLength'];
    likesLength=json['likesLength'];
    postId=json['postId'];
  }

  Map<String,dynamic> toJson(){
    return {
      'name':name,
      'uid':uid,
      'image':image,
      'dateTime':dateTime,
      'postImage':postImage,
      'text':text,
      'commentsLength':commentsLength,
      'likesLength':likesLength,
    };
  }
}