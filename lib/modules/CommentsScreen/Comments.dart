import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/HomeLayout/cubit/cubit.dart';
import 'package:my_social_app/HomeLayout/cubit/states.dart';
import 'package:my_social_app/models/commentModel.dart';

class Comments extends StatelessWidget {
  const Comments({required this.index, super.key});
 final int index;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state)  {
        var cubit=SocialCubit.get(context);
        var commentController=TextEditingController();
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_sharp),
              onPressed: () {
                cubit.cancelComments(context, cubit.posts[index]!.postId!);
              },
            ),
          ),
          // body: StreamBuilder(
          //   builder: (context, snapshot) {
          //     if(snapshot.connectionState==ConnectionState.waiting)
          //       {
          //        return  const Center(child: CircularProgressIndicator());
          //       }
          //     return Padding(
          //             padding: const EdgeInsets.all(15.0),
          //             child: Column(
          //               children: [
          //                 Expanded(
          //                   child: ConditionalBuilder(
          //                     fallback:(context) => const Center(
          //                       child: Text('write the first comment'),
          //                     ),
          //                     condition: cubit.posts[index].commentsLength!=0,
          //                     builder: (context) =>  ListView.separated(
          //                       reverse: true,
          //                       physics: const BouncingScrollPhysics(),
          //                       separatorBuilder: (context, index) => Padding(
          //                         padding: const EdgeInsets.all(8.0),
          //                         child: Container(
          //                           color: Colors.grey[700],
          //                           height: 1,
          //                         ),
          //                       ),
          //                       itemBuilder: (context, index) => buildComment(context,cubit.commentsPost[index]),
          //                       itemCount: snapshot.data!.docs.length,
          //                     ),
          //                   ),
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsets.only(top: 6.0),
          //                   child: TextFormField(
          //                     controller: commentController,
          //                     decoration: InputDecoration(
          //                         label: const Text('write comment ...'),
          //                         labelStyle: const TextStyle(
          //                             color: Colors.grey
          //                         ),
          //                         border: const OutlineInputBorder(),
          //                         suffixIcon: IconButton(
          //                             onPressed: () {
          //                               cubit.commentsPost.clear();
          //                               cubit.writeComment ( commentController.text , index , id ) ;
          //                             },
          //                             icon: const Icon(Icons.arrow_forward_ios)
          //                         )
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ));
          //   } ,
          //   stream: FirebaseFirestore.instance.collection('chats').snapshots(),
          //
          // ),
          body: ConditionalBuilder(
            fallback: (context) => const Center(child: CircularProgressIndicator(),),
            builder: (context) => Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Expanded(
                    child: ConditionalBuilder(
                      fallback:(context) => const Center(
                        child: Text('write the first comment'),
                      ),
                      condition: true,
                      builder: (context) =>  ListView.separated(
                        reverse: true,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.grey[700],
                            height: 1,
                          ),
                        ),
                        itemBuilder: (context, index) => buildComment(context,cubit.commentsPost[index]),
                        itemCount: cubit.commentsPost.length,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: TextFormField(
                      controller: commentController,
                      decoration: InputDecoration(
                          label: const Text('write comment ...'),
                          labelStyle: const TextStyle(
                              color: Colors.grey
                          ),
                          border: const OutlineInputBorder(),
                          suffixIcon:  IconButton(
                              onPressed: () {
                                if(commentController.text.isNotEmpty) {
                                  cubit.writeComment ( commentController.text , index , cubit.posts[index]!.postId!) ;
                                }
                              },
                              icon: const Icon(Icons.arrow_forward_ios)
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
            condition: state is !GetCommentLoadingState,
          ),
        );
      },
    );
  }

  Widget buildComment(context,CommentModel commentModel)=>Row(
    children: [
       GestureDetector(
         onTap: () {
           SocialCubit.get(context).openProfile(commentModel.uid!, context);
         },
         child: CircleAvatar(
          backgroundImage: NetworkImage(
              commentModel.image!),
      ),
       ),
      const SizedBox(width: 20,),
      Expanded(
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Colors.grey[800],
          child:  Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${commentModel.name}',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 5,),
                Text(
                  '${commentModel.comment}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white70,
                    fontSize: 15
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );


}
