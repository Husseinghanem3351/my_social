import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/HomeLayout/cubit/cubit.dart';
import 'package:my_social_app/components/components.dart';
import 'package:my_social_app/modules/chats/chatDetail.dart';
import 'package:my_social_app/shared/constants/const.dart';

import '../../HomeLayout/cubit/states.dart';
import '../../models/UserModel.dart';

class ChatsScreen extends StatelessWidget {

  const ChatsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    SocialCubit.get(context).getUsers(context);
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ConditionalBuilder(
          builder: (context) =>
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) =>
                              buildChatItem(SocialCubit
                                  .get(context)
                                  .users[index], context),
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
                              .users
                              .length),
                    )
                  ],
                ),
              ),
          condition: state is! GetUsersLoadingState,
          fallback: (context) =>
          const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildChatItem(UserModel user, context) =>
    InkWell(
      onTap: () {
        SocialCubit.get(context).messages=[];
         return navigateTo(
            context: context,
            screen: ChatDetail(user: user,),
          );},
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
                  radius: 7,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 20,
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
                // Row(
                //   children: [
                //     const Expanded(
                //         child: Text(
                //           'hello I am hussein ghanem hello I am hussein ghanem .',
                //           maxLines: 2,
                //           overflow: TextOverflow.ellipsis,
                //         )),
                //     Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 5),
                //       child: Container(
                //         height: 5,
                //         width: 5,
                //         decoration: const BoxDecoration(
                //           color: Colors.black,
                //           shape: BoxShape.circle,
                //         ),
                //       ),
                //     ),
                //     const Text('12:17 am'),
                //   ],
                // )
              ],
            ),
          )
        ],
      ),
    );