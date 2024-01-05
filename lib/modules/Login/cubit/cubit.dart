import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/HomeLayout/HomeLayout.dart';
import 'package:my_social_app/components/components.dart';
import 'package:my_social_app/modules/Login/cubit/states.dart';
import 'package:my_social_app/shared/Network/local/cache_helper.dart';

import '../../../shared/constants/const.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit():super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPass=false;
  IconData passIcon= Icons.visibility;

  void changeIconPass(){
    isPass=!isPass;
    passIcon= isPass? Icons.visibility_off:Icons.visibility;
    emit(ChangeIconPass());
  }

  void userLogin({required String email, required String password,required context}){
    emit(LoadingLoginState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
      emit(SuccessLoginState());
      CacheHelper.putData(value: value.user?.uid, key: 'token');
      uid=value.user!.uid;
      showToast( msg: 'signed in successfully',color: Colors.green);
      pushAndReplacement(context: context, screen: const HomeLayout());
    }).catchError((error){
      emit(ErrorLoginState());
      showToast( msg: error.toString(),color: Colors.red,textColor: Colors.white);
    });

  }
}