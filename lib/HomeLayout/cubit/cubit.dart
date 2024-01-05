import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_social_app/HomeLayout/cubit/states.dart';
import 'package:my_social_app/components/components.dart';
import 'package:my_social_app/models/MessageModel.dart';
import 'package:my_social_app/models/UserModel.dart';
import 'package:my_social_app/models/postModel.dart';
import 'package:my_social_app/modules/Login/login.dart';
import 'package:my_social_app/modules/chats/chatsScreen.dart';
import 'package:my_social_app/modules/settings/settingsScreen.dart';
import 'package:my_social_app/modules/users/usersScreen.dart';

import '../../models/commentModel.dart';
import '../../modules/feeds/feedsScreen.dart';
import '../../modules/profile/profile.dart';
import '../../shared/Network/local/cache_helper.dart';
import '../../shared/constants/const.dart';

class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  int? showMessageId;

  UserModel? userModel;

  void showMessage(int id){
    if(showMessageId!=id){
      showMessageId=id;
    }
    else{
      showMessageId=null;
    }
    emit(ShowMessageState());
  }

  void getUser(context, ) {
    emit(SocialGetUserLoadingState());
    if (uid != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((value) {
        userModel = UserModel.fromJson(value.data());
        emit(SocialGetUserSuccessState());
      }).catchError((error) {
        emit(SocialGetUserErrorState());
        showToast( msg: error.toString(), color: Colors.red);
      });
    }
  }

  int currentIndex = 0;

  bool isShowSnackBar = false;

  List<Widget> screen = [
    const FeedsScreen(),
    const ChatsScreen(),
    const Placeholder(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    '',
    'Users',
    'Settings',
  ];

  void changeBottomNavBar(int index, context) {
    if (index == 2) {
      emit(AddNewPostState(context));
    } else {
      currentIndex = index;
      emit(ChangeBottomNavBarState());
    }
  }

  File? profileImage;

  ImagePicker picker = ImagePicker();

  Future<void> getProfileImage(context) async {
    await picker
        .pickImage(
      source: ImageSource.gallery,
    )
        .then((value) {
      if (value != null) {
        profileImage = File(value.path);
        emit(ProfileImagePickerSuccessState());
      }
    }).catchError((error) {
      emit(ProfileImagePickerErrorState());
    });
  }

  File? coverImage;

  Future<void> getCoverImage(context) async {
    await picker
        .pickImage(
      source: ImageSource.gallery,
    )
        .then((value) {
      if (value != null) {
        coverImage = File(value.path);
        emit(CoverImagePickerSuccessState());
      }
    }).catchError((error) {
      emit(CoverImagePickerErrorState());
    });
  }

  String? profileImageUrl;

  Future<void> uploadProfileImage(context) async {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) async {
      await value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        FirebaseFirestore.instance
            .collection('users')
            .doc(userModel!.uid)
            .update({
          'image': profileImageUrl,
        }).then((value) {
          getUser(context);
          profileImage = null;
        });
        emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
        showToast( msg: error.toString(), color: Colors.red);
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
      showToast( msg: error.toString());
    });
  }

  String? coverImageUrl;

  Future<void> uploadCoverImage(context) async {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) async {
      await value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        FirebaseFirestore.instance
            .collection('users')
            .doc(userModel!.uid)
            .update({
          'cover': coverImageUrl,
        }).then((value) {
          getUser(context);
          coverImage = null;
        });
      }).catchError((error) {
        showToast( msg: error.toString());
      });
    }).catchError((error) {
      showToast( msg: error.toString());
    });
  }

  void updateUser(
    context, {
    required String name,
    required String bio,
    required String phone,
  }) async {
    emit(LoadingUpdateUserState());
    if (profileImage != null) {
      uploadProfileImage(context);
    }
    if (coverImage != null) {
      uploadCoverImage(context);
    }
    FirebaseFirestore.instance.collection('users').doc(userModel!.uid).update({
      'name': name,
      'bio': bio,
      'phone': phone,
    }).then((value) {
      getUser(context);
      showToast(
           msg: 'updated successfully', color: Colors.green);
    }).catchError((error) {
      showToast( msg: error.toString(), color: Colors.red);
      emit(SocialUserUpdateErrorState());
    });
  }

  PostModel? postModel;

  String? postImageUrl;

  File? postImage;

  Future<void> getPostImage(context) async {
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        postImage = File(value.path);
      }
      emit(GetImagePostSuccess());
    }).catchError((error) {
      showToast( msg: error.toString());
    });
  }

  Future<void> uploadPostWithImage(context,
      {required String? text, required File? image}) async {
    try {
      final uploadTask = FirebaseStorage.instance
          .ref()
          .child('posts/${Uri.file(image!.path).pathSegments.last}')
          .putFile(image);

      final uploadSnapshot = await uploadTask;

      if (uploadSnapshot.state == TaskState.success) {
        postImageUrl = await uploadSnapshot.ref.getDownloadURL();

        postModel = PostModel(
          name: userModel!.name!,
          uid: uid,
          image: userModel!.image,
          dateTime: DateTime.now().toString(),
          text: text,
          postImage: postImageUrl,
          commentsLength: 0,
            likesLength:0,
        );

        await FirebaseFirestore.instance
            .collection('posts')
            .add(postModel!.toJson())
            .then((value) {
        });
      } else {
        showToast(
            msg: 'upload task filed', color: Colors.red);
        emit(PostErrorState());
      }
    } catch (error) {
      showToast(msg: error.toString(), color: Colors.red);
      emit(PostErrorState());
    }
  }

  Future<void> createPost(context, {String? text}) async {
    emit(PostLoadingState());
    try {
      if (postImage != null) {
        await uploadPostWithImage(context, text: text, image: postImage);
      } else {
        postModel = PostModel(
          name: userModel!.name!,
          uid: uid,
          image: userModel!.image,
          dateTime: DateTime.now().toString(),
          text: text,
          commentsLength: 0,
            likesLength:0,
        );
        await FirebaseFirestore.instance
            .collection('posts')
            .add(postModel!.toJson())
            .then((value)  async {

          // FirebaseFirestore.instance.collection('posts').doc(value.id).collection('likes').doc(uid).set(
          //   {
          //     'like':false,
          //   }
          // );
        });
      }
      // posts.insert(0, postModel!);
      //
      // postsLikes.insert(0, {});
      //
      // comments.insert(0, 0);

      Navigator.pop(context);

      currentIndex = 0;

      emit(PostSuccessState());
    } catch (error) {
      emit(PostErrorState());

      showToast( msg: error.toString());
    }
  }

  List<PostModel?> posts = [];
  Map<String,Map<String, bool?>> postsLikes = {};
  List<int> commentsLength=[];

  Future<void> getPosts(context) async {
    posts=[];
    postsLikes={};
    emit(GetPostsLoadingState());
    //if the first time the fun execute it will add posts, but if not the first time it will update the posts.
    FirebaseFirestore.instance.collection('posts').orderBy('dateTime').snapshots().listen((value) async {
      int i = 0;
      if(posts.isEmpty) {
        for (var post in value.docs) {
          posts.add(PostModel.fromJson(post.data()));
          if(posts[i]?.postId==null){
            posts[i]?.postId=post.id;
            await FirebaseFirestore.instance.collection('posts').doc(post.id).update({
              'postId':post.id,
            });
          }
          await post.reference.collection('likes').get().then((value) {
            postsLikes.addAll({post.id:{}});
            posts[i]?.likesLength=value.docs.length;
            for (var like in value.docs) {
              postsLikes[post.id]?.addAll({like.id: like.data()['like']});
            }
          }).catchError((error) {
            print('the error is $error');
          });
          i++;
        }
      }
      else{
        for(var post in value.docChanges){
          bool isNew=true;
          for(int j=0;j<posts.length;j++){
            if(post.doc.id==posts[j]!.postId){
              print(j);
              isNew=false;
              posts[j]=PostModel.fromJson(post.doc.data());
              await post.doc.reference.collection('likes').get().then((value){
                postsLikes.addAll({post.doc.id:{}});
                posts[j]?.likesLength=value.docs.length;
                for(var like in value.docs){
                  postsLikes[post.doc.id]?.addAll({like.id:like.data()['like']});
                }
              }).catchError((error){
                showToast(msg: error.toString(),color: Colors.red,textColor: Colors.white);
                emit(GetPostsErrorState());
              });
            }
          }
          if(isNew){
            posts.insert(0, PostModel.fromJson(post.doc.data()));
            posts[0]?.postId=post.doc.id;
            await FirebaseFirestore.instance.collection('posts').doc(post.doc.id).update({
              'postId':post.doc.id,
            });
          }
        }
      }
      emit(GetPostsSuccessState());
    });
  }

  //
  // void updatePosts(int index){
  //   posts[index]
  // }
  
  Future<void> likePost(int index) async {
    try{
    if(postsLikes[posts[index]?.postId]?[uid]==null) {
      postsLikes[posts[index]?.postId]?[uid!]=true;
      posts[index]?.likesLength++;
      emit(LikePostSuccessState());
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(posts[index]?.postId)
          .collection('likes')
          .doc(uid)
          .set({'like': true});
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(posts[index]?.postId)
          .update({
        'likesLength': posts[index]?.likesLength,
      });
      print('likes length ${posts[index]!.likesLength}');
    }
    else{
      postsLikes[posts[index]?.postId]?.remove(uid);
      posts[index]?.likesLength--;
      emit(LikePostSuccessState());
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(posts[index]?.postId)
          .collection('likes')
          .doc(uid)
          .delete();
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(posts[index]?.postId)
          .update({
        'likesLength': posts[index]?.likesLength,
      });
    }}
    catch(error){
      if(postsLikes[ posts[index]?.postId]?[uid]==null){
        postsLikes[ posts[index]?.postId]?.addAll({uid!:true});
        posts[index]!.likesLength--;
      }
      else{
        postsLikes[ posts[index]?.postId]?.remove(uid);
        posts[index]!.likesLength++;
      }
      showToast(msg: error.toString(),color: Colors.red);
      emit(LikePostErrorState());
    }

  }

  void removePostImage() {
    postImage = null;
    postImageUrl = '';
    emit(RemoveImagePostSuccessState());
  }

  Future<void> writeComment(String comment, int index, String id) async {
   await FirebaseFirestore.instance
        .collection('posts')
        .doc(id)
        .collection('comments')
        .add({
      '${userModel!.uid}': comment,
      'dateTime': DateTime.now().toString(),
    }).then((value)  {
      //comments[index] += 1;
      FirebaseFirestore.instance.collection('posts').doc(id).update({'commentsLength':posts[index]!.commentsLength+1});
      // commentsPost.insert(0, CommentModel(comment: comment, name: userModel!.name, image: userModel!.image));
      emit(CommentSuccessState());
    }).catchError((error) {
      emit(CommentErrorState());
    });
  }

  List<CommentModel> commentsPost = [];

  void cancelComments(context,String id) async {
    await commentsRef.cancel();
    Navigator.pop(context);
  }

  var commentsRef;
  void getComments(int index) async {
    commentsPost.clear();
    commentsRef=FirebaseFirestore.instance
        .collection('posts')
        .doc(posts[index]?.postId)
        .collection('comments').snapshots().listen((event) async {
      for (var element in event.docChanges) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(element.doc.data()!.keys.last)
            .get()
            .then((value) {

          commentsPost.insert(0,CommentModel(
              comment: element.doc.data()!.values.last,
              name: value.data()!['name'],
              image: value.data()!['image'],
              uid: element.doc.data()!.keys.last),
          );
        });
        if (commentsPost.length == 5) {
          emit(GetCommentSuccessState());
        }
      }
      emit(GetCommentSuccessState());
    });

    emit(GetCommentLoadingState());
      commentsRef;
  }

  List<UserModel> users = [];

  void getUsers(context) {
    users = [];
    emit(GetUsersLoadingState());
    FirebaseFirestore.instance.collection('users').snapshots().listen((value) {
      for (var element in value.docs) {
        if (element.data()['uid'] != userModel!.uid) {
          users.add(UserModel.fromJson(element.data()));
        }
      }
      emit(GetUsersSuccessState());
    });
  }
  void sendMessage({
    required String text,
    required String receiverUid,
  }) {

     var timestamp=Timestamp.now();
    MessageModel messageModelSender = MessageModel(
        receiverUid: receiverUid,
        senderUid: userModel!.uid,
        text: text,
        dateTime: timestamp,);

     MessageModel messageModelReceiver = MessageModel(
       receiverUid: receiverUid,
       senderUid: userModel!.uid,
       text: text,);

    saveReceiverMessage(messageModelReceiver);

    saveSenderMessage(messageModelSender);
  }

  void saveSenderMessage(MessageModel message) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(message.receiverUid)
        .collection('messages')
        .add(message.toJson())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      saveSenderMessage(message);
    });
  }

  void saveReceiverMessage(MessageModel message) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(message.receiverUid)
        .collection('chats')
        .doc(userModel!.uid)
        .collection('messages')
        .add(message.toJson())
        .then((value) {})
        .catchError((error) {
      saveReceiverMessage(message);
    });
  }

  List<MessageModel> messages = [];

  void getMessages(String receiverUid) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid!)
        .collection('chats')
        .doc(receiverUid)
        .collection('messages')
        .orderBy('dateTime',descending: true)
        .snapshots()
        .listen((event) async {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
        if(messages.last.dateTime==null){
          messages.last.dateTime=Timestamp.now();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userModel!.uid!)
              .collection('chats')
              .doc(receiverUid)
              .collection('messages').doc(element.id).update({'dateTime':Timestamp.now()});
        }
      }
      emit(GetChatSuccessState());
    });
  }

  void signOut(context){
    CacheHelper.removeData('token');
    pushAndReplacement(context: context, screen: const Login());
    emit(SocialSignOutState());
  }

  List<UserModel> likesUsers=[];
  Future<void> usersLikes(int index)async{
    likesUsers=[];
    if(posts[index]?.likesLength!=0){
      emit(GetLikesLoadingState());
      postsLikes[posts[index]?.postId]?.forEach((key, value) async {
          print(key);
          await FirebaseFirestore.instance
              .collection('users')
              .doc(key)
              .get()
              .then((value) {
            likesUsers.add(UserModel.fromJson(value.data()));
            emit(GetLikesSuccessState());
          });
      });
    }
  }

  UserModel? userProfile;
  void openProfile(String userUid,context) async {
    emit(GetProfileUserLoadingState());
   await FirebaseFirestore.instance.collection('users')
        .doc(userUid).get().then((value) {
          userProfile=UserModel.fromJson(value.data());
          print(userProfile!.uid);
    });
    emit(GetProfileUserSuccessState());
   navigateTo(context: context, screen:  Profile(user: userProfile!,));
  }

  List<PostModel> searchPosts=[];
  void search({required String text}){
    emit(SearchPostsLoadingState());
    for(var element in posts){
      if(element!.text!.contains(text)){
        searchPosts.add(element);
      }
    }
    emit(SearchPostsSuccessState());
  }

  }
