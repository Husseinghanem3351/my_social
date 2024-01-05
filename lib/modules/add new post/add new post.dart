import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/HomeLayout/cubit/cubit.dart';
import 'package:my_social_app/components/components.dart';
import 'package:my_social_app/models/UserModel.dart';

import '../../HomeLayout/cubit/states.dart';
import '../../shared/styles/icon_broken.dart';

class AddNewPost extends StatelessWidget {
  const AddNewPost({super.key});

  @override
  Widget build(BuildContext context) {
    var postController=TextEditingController();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        UserModel? user=SocialCubit.get(context).userModel;
        var cubit=SocialCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: 'Create Post',
              actions: [
                TextButton(
                  onPressed: () {
                    if(postController.text.isNotEmpty || cubit.postImage!=null) {
                      cubit.createPost(
                      context,
                      text:postController.text,
                    );
                    }
                  },
                  child:  const Text(
                      'Post',
                    style: TextStyle(
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
              ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(state is PostLoadingState)
                const LinearProgressIndicator(),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(user!.image!),
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name!,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: 5,),
                        Text(
                            'public',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
                 Expanded(
                  child:TextFormField(
                    decoration: InputDecoration(
                      hintText: 'what is on your mind',
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      border: InputBorder.none,
                    ),
                    controller: postController,
                  ),
                ),
                if(cubit.postImage!=null)
                 Expanded(
                    child:Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Image(
                            image: FileImage(
                              cubit.postImage!,
                            ),
                          fit: BoxFit.cover,
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: (){
                            SocialCubit.get(context).removePostImage();
                          },
                          icon: const Icon(Icons.close),
                          style: const ButtonStyle(
                            iconColor: MaterialStatePropertyAll(Colors.black)
                          ),
                        ),
                      ],
                    )
                ),
                Row(
                  children: [
                    Expanded(
                        child:TextButton(
                          onPressed: (){
                            cubit.getPostImage(context);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(width: 5,),
                              Text(
                                'add photos',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ),
                    Expanded(
                      child:TextButton(
                        onPressed: (){},
                        child: const Text(
                          '# Tags',
                          style: TextStyle(
                            fontSize: 12
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}


