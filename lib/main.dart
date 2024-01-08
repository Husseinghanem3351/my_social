import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/HomeLayout/HomeLayout.dart';
import 'package:my_social_app/components/components.dart';
import 'package:my_social_app/shared/Network/local/cache_helper.dart';
import 'package:my_social_app/shared/bloc_observer.dart';
import 'package:my_social_app/shared/constants/const.dart';
import 'package:my_social_app/shared/styles/themes.dart';
import 'HomeLayout/cubit/cubit.dart';
import 'modules/Login/login.dart';
import 'modules/search/search.dart';

GlobalKey? key = GlobalKey();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  showToast(msg: message.data.toString(), color: Colors.green);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: 'apiKey',
        appId: 'appId',
        messagingSenderId: 'messagingSenderId',
        projectId: 'projectId'),
  );
  //var token = await FirebaseMessaging.instance.getToken();
  // FirebaseMessaging.onMessage.listen((event) {
  //   print('on message');
  //   print(event.data);
  //   print(event.notification?.title);
  //   print(event.notification?.body);
  //   showToast(msg: 'on message',color: Colors.green);
  // });
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   showToast(msg: 'on message opened app',color: Colors.green);
  //   print('on message opened app');
  // });
  //FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  //print(token);
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  uid = await CacheHelper.getData(key: 'token');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Widget startWidget = uid != null ? const HomeLayout() : const Login();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SocialCubit()
              ..getUser(context)
              ..getPosts(context))
      ],
      child: MaterialApp(
        key: key,
        debugShowCheckedModeBanner: false,
        title: 'Login',
        theme: darkTheme,
        home: startWidget,
      ),
    );
  }
}
