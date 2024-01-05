import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/HomeLayout/cubit/cubit.dart';
import 'package:my_social_app/components/components.dart';
import 'package:my_social_app/modules/chats/chatDetail.dart';
import 'package:my_social_app/shared/styles/icon_broken.dart';

import '../../HomeLayout/cubit/states.dart';
import '../../models/UserModel.dart';

class LikeUsers extends StatelessWidget {

  const LikeUsers({super.key});


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_sharp),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
          body: ConditionalBuilder(
            builder: (context) =>
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) =>
                                buildUserItem(SocialCubit
                                    .get(context)
                                    .likesUsers[index], context),
                            separatorBuilder: (context, index) =>
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                            itemCount: SocialCubit
                                .get(context)
                                .likesUsers
                                .length),
                      )
                    ],
                  ),
                ),
            condition: state is! GetLikesLoadingState,
            fallback: (context) =>
            const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}

Widget buildUserItem(UserModel user, context) =>
    InkWell(
      onTap: () {
        SocialCubit.get(context).openProfile(user.uid!, context);
        },
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    user.image!
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: 1,
                  end: 1,
                ),
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.name}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5,
                ),

              ],
            ),
          ),
          const Icon(IconBroken.Heart,color: Colors.red,),
        ],
      ),
    );