import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/HomeLayout/cubit/cubit.dart';

import '../../HomeLayout/cubit/states.dart';
import '../../components/components.dart';
import '../../models/postModel.dart';
import '../../shared/constants/const.dart';
import '../../shared/styles/icon_broken.dart';
import '../CommentsScreen/Comments.dart';
import '../likesUsers/likesUsers.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'search',
                ),
                textInputAction: TextInputAction.search,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (value) {
                  SocialCubit.get(context).search(text: value);
                },
                onChanged: (value) {},
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => buildPostItem(
                  context,
                  SocialCubit.get(context).searchPosts[index],
                  index),
                itemCount: SocialCubit.get(context).searchPosts.length,
              ),
            )

          ],
        ),
      ),
    );
  },
);
  }
}
  Widget buildPostItem(context, PostModel post,int index) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 20,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      SocialCubit.get(context).openProfile(post.uid!,context);
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(post.image!),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${post.name}',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16,
                            )
                          ],
                        ),
                        Text(
                          post.dateTime!.substring(0, 16),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showBottomSheet(
                          context: context,
                          builder: (context) => Column(
                            children: [
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                      },
                                      child: const Text('Remove'),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          constraints: const BoxConstraints(
                            maxHeight: 50,
                          ));
                    },
                    icon: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.more_horiz,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[400],
                ),
              ),
              Text(
                '${post.text}',
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 6 == 5 ? 2 : null,
                overflow: TextOverflow.visible,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: SizedBox(
                        height: 25,
                        child: MaterialButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          minWidth: 1,
                          child: Text(
                            '#software development',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              color: Colors.blue,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: SizedBox(
                        height: 25,
                        child: MaterialButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          minWidth: 1,
                          child: Text(
                            '#software development',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              color: Colors.blue,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: SizedBox(
                        height: 25,
                        child: MaterialButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          minWidth: 1,
                          child: Text(
                            '#software development',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              color: Colors.blue,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: SizedBox(
                        height: 25,
                        child: MaterialButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          minWidth: 1,
                          child: Text(
                            '#software development',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              color: Colors.blue,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              if (post.postImage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: NetworkImage(post.postImage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        SocialCubit.get(context).usersLikes( index);
                        navigateTo(context: context, screen: const LikeUsers());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              color: Colors.grey[100],
                              size: 18,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${SocialCubit.get(context).posts[index]?.likesLength}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.grey[100]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        SocialCubit.get(context)
                            .getComments(index);
                        navigateTo(
                            context: context,
                            screen: Comments(
                              index: index,
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              color: Colors.grey[100],
                              size: 18,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${post.commentsLength} comment',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.grey[100]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 5.0),
                child: Container(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundImage: NetworkImage(post.image!),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'write comment...',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.grey,fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        SocialCubit.get(context)
                            .getComments(index);
                        navigateTo(
                            context: context,
                            screen: Comments(
                              index: index,
                            ));
                      },
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        SocialCubit.get(context).likePost(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            if(SocialCubit.get(context).postsLikes.length>index)
                              Icon(
                                IconBroken.Heart,
                                size: 20,
                                color: SocialCubit.get(context).postsLikes[post.postId]?[uid]==true
                                    ? Colors.red
                                    : Colors.white,
                              ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Like',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                color: Colors.grey[300],
                              ),
                            )
                          ],
                        ),
                      )),
                  InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Message,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Share',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                color: Colors.grey[300],
                              ),
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ],
          )),
    );
  }

