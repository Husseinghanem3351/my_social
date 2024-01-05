
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/HomeLayout/cubit/cubit.dart';
import 'package:my_social_app/HomeLayout/cubit/states.dart';
import 'package:my_social_app/components/components.dart';
import 'package:my_social_app/modules/Edit_Profile/Edit_Profile.dart';
import 'package:my_social_app/shared/Network/local/cache_helper.dart';
import 'package:my_social_app/shared/constants/const.dart';

import '../../models/UserModel.dart';
import '../../shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
        },
         builder: (context, state) {
        UserModel? user=SocialCubit.get(context).userModel;
        return Padding(
      padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 190,
                child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          height: 140,
                          width: double.infinity,
                          decoration:  BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                              image: DecorationImage(
                                image:  NetworkImage(user!.cover!),
                                fit: BoxFit.cover,)
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 64,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(user.image!),
                        ),
                      ),
                    ]
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                  '${user.name}',
                  style: Theme.of(context).textTheme.displayMedium
              ),
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 10.0),
               child: Text(
                    '${user.bio}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
             ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap:(){},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              Text(
                                '120',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                'Posts',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap:(){},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              Text(
                                '64',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                'photos',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap:(){},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              Text(
                                '10k',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                'Followers',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap:(){},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              Text(
                                '356',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                'Followings',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: (){},
                        child: const Text('Add photos'),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  OutlinedButton(
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    ),
                      onPressed: (){
                      navigateTo(context: context, screen: const EditProfile());
                      },
                      child: const Icon(
                        IconBroken.Edit,
                      ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: (){
                          FirebaseMessaging.instance.subscribeToTopic('friend');
                        }, child: const Text(
                      'subscribe',
                    )),
                  ),
                  SizedBox(width: 20 ,),
                  Expanded(
                    child: OutlinedButton(
                        onPressed: (){
                          FirebaseMessaging.instance.unsubscribeFromTopic('friend');
                        },
                        child: const Text(
                      'unSubscribe',
                    )),
                  ),
                ],
              ),
              OutlinedButton(
                  onPressed: (){
                    SocialCubit.get(context).signOut(context);
                  },
                  child: const Text('Sign Out')),
            ],
          ),
    );
        },
    );
  }
}
