class CommentModel{
  String? name;
  String? comment;
  String? image;
  String? uid;

  CommentModel({
    required this.comment,
    required this.name,
    required this.image,
    required this.uid,
  });

  CommentModel.fromJson(Map<String,dynamic> json){
    comment=json['comment'];
    name=json['name'];
    image=json['image'];
    uid=json['uid'];
  }

  Map<String,dynamic> toJson(){
    return  {
     'name':name,
     'comment':comment,
     'image':image,
    };
  }
}

