
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/HomeLayout/HomeLayout.dart';
import 'package:my_social_app/components/components.dart';
import 'package:my_social_app/models/UserModel.dart';
import 'package:my_social_app/modules/Register/cubit/states.dart';
import 'package:my_social_app/shared/Network/local/cache_helper.dart';

import '../../../shared/constants/const.dart';
class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit():super(RegisterInitState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isPass=false;
  IconData passIcon= Icons.visibility;

  void changeIconPass(){
    isPass=!isPass;
    passIcon= isPass? Icons.visibility_off:Icons.visibility;
    emit(ChangeIconPass());
  }

  void registerUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String phone,
  }){
    emit(LoadingRegisterState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password).
    then((value) {
      CacheHelper.putData( key: 'token', value: value.user!.uid);
      uid=value.user!.uid;
      createUser(context:context,email: email, name: name, phone: phone, uid: value.user!.uid);
    }).
    catchError((error){
      emit(ErrorRegisterState());
      showToast(
          msg: error.toString(),
          color: Colors.red);
    });
  }

  void createUser({
    required BuildContext context,
    required String email,
    required String name,
    required String phone,
    required String uid,
    String image='https://static.thenounproject.com/png/5034901-200.png',
    String bio='write your bio...',
    String cover='https://static.thenounproject.com/png/37651-200.png',
}){
    UserModel userModel=UserModel(
      name: name,
      email: email,
      phone: phone,
      uid : uid,
      image: image,
      cover: cover,
      bio: bio,
    );
    FirebaseFirestore.instance.collection('users').doc(uid).set(userModel.toJson())
        .then((value) {
          pushAndReplacement(context: context, screen: const HomeLayout());
          emit(SuccessCreateUserState());
    })
        .catchError((error){
          emit(ErrorCreateUserState());
    });
  }
}