import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/HomeLayout/cubit/cubit.dart';
import 'package:my_social_app/HomeLayout/cubit/states.dart';
import 'package:my_social_app/components/components.dart';
import 'package:my_social_app/modules/search/search.dart';
import 'package:my_social_app/shared/styles/icon_broken.dart';

import '../shared/constants/const.dart';

class HomeLayout extends StatelessWidget {

  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit=SocialCubit.get(context);
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is GetPostsSuccessState) {
          isGetPostsSuccess=true;
        }
        else if(state is GetPostsLoadingState) {
          isGetPostsSuccess = false;
        }
      },
      builder: (context, state) {

        return Scaffold(
          appBar: AppBar(
            title:  Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: const Icon(IconBroken.Notification)
              ),
              IconButton(
                  onPressed: (){
                    navigateTo(context: context, screen: const Search());
                  },
                  icon: const Icon(IconBroken.Search)
              )
            ],
          ),
          body: ConditionalBuilder(
            fallback: (context) => const Center(child: CircularProgressIndicator()),
            condition: state is! GetUsersLoadingState && isGetPostsSuccess!,
            builder: (context) => cubit.screen[cubit.currentIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat),
                label: 'Chats'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload),
                  label: 'Add'
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Location),
                label: 'Users'
              ),
              BottomNavigationBarItem(
                    icon: Icon(IconBroken.Setting),
                    label: 'Settings'
                  ),
            ],
            onTap: (index){
              cubit.changeBottomNavBar(index,context);
            },
          ),
        );
      },
    );
  }
}
