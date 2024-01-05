import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_social_app/components/components.dart';

import '../../HomeLayout/cubit/cubit.dart';
import '../../HomeLayout/cubit/states.dart';
import '../../models/MessageModel.dart';
import '../../models/UserModel.dart';

class ChatDetail extends StatelessWidget {
  const ChatDetail({required this.user, super.key});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    var cubit = SocialCubit.get(context);
    cubit.getMessages(user.uid!);

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user.image!),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text('${user.name}'),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    reverse: true,
                      itemBuilder: (context, index) {
                        if (cubit.messages[index].senderUid == cubit.userModel!.uid!) {
                          return sendMessage(cubit.messages[index],context,index);
                        }
                        return receiveMessage(cubit.messages[index],context,index);
                      },
                      separatorBuilder: (context, index) =>
                      const SizedBox(
                        height: 10,
                      ),
                      itemCount: cubit.messages.length),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: const Border.fromBorderSide(
                        BorderSide(color: Colors.blueGrey)),
                  ),
                  child: TextFormField(
                    controller: controller,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'type message',
                      suffixIcon: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          SocialCubit.get(context).sendMessage(
                            text: controller.text,
                            receiverUid: user.uid!,
                          );
                          controller.clear();
                        },
                        icon: const Icon(Icons.chevron_right_sharp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget sendMessage(MessageModel message,context,index) {
    final f = DateFormat('yyyy-MM-dd hh:mm');
    return Align(
        alignment: AlignmentDirectional.topStart,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                SocialCubit.get(context).showMessage(index);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration:  BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: Colors.grey.withOpacity(.4),
                ),
                child: Text(message.text.toString()),
              ),
            ),
            if(SocialCubit.get(context).showMessageId==index)
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(f.format(message.dateTime!.toDate()),style: const TextStyle(fontSize: 12),),
            )
          ],
        ),
      );
  }

  Widget receiveMessage(MessageModel message,context,index) {
    final f = DateFormat('yyyy-MM-dd hh:mm');
    return Align(
        alignment: AlignmentDirectional.topEnd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: (){
                SocialCubit.get(context).showMessage(index);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration:  BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  color: Colors.purple.withOpacity(.45),
                ),
                child: Text(message.text.toString()),
              ),
            ),
            if(SocialCubit.get(context).showMessageId==index)
            Padding(
              padding: const EdgeInsets.only( top: 3.0),
              child: Text(f.format(message.dateTime!.toDate()),style: const TextStyle(fontSize: 12),),
            )
          ],
        ),
      );
  }
}
