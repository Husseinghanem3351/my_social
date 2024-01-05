class UserModel{
  String? name;
  String? email;
  String? phone;
  String? uid;
  String? image;
  String? bio;
  String? cover;

 UserModel({
  required this.name,
  required this.email,
  required this.phone,
  required this.uid,
   this.image,
   required this.bio,
   this.cover,
 });

 UserModel.fromJson(Map<String,dynamic>? json)
 {
   email=json!['email'];
   name=json['name'];
   phone=json['phone'];
   uid=json['uid'];
   image=json['image'];
   bio=json['bio'];
   cover=json['cover'];
 }

 Map<String,dynamic> toJson(){
   return {
   'email':email,
     'name':name,
     'phone':phone ,
     'uid':uid,
     'image':image,
     'bio':bio,
     'cover':cover,
   };
 }
}