
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/components/components.dart';
import 'package:my_social_app/shared/styles/icon_broken.dart';

import '../../HomeLayout/cubit/cubit.dart';
import '../../HomeLayout/cubit/states.dart';
import '../../models/UserModel.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {


    var nameController=TextEditingController();
    var bioController=TextEditingController();
    var phoneController=TextEditingController();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var formKey=GlobalKey<FormState>();
        UserModel? user =SocialCubit.get(context).userModel;
        var profileImage=SocialCubit.get(context).profileImage;
        var coverImage=SocialCubit.get(context).coverImage;
        nameController.text=user!.name!;
        bioController.text=user.bio!;
        phoneController.text=user.phone!;
        return Scaffold(
          appBar: defaultAppBar(
              actions: [
                TextButton(
                  onPressed: () {
                  if(formKey.currentState!.validate())  {
                  SocialCubit.get(context).updateUser(
                    context,
                    name: nameController.text,
                    bio: bioController.text,
                    phone: phoneController.text,
                  );
                }
              },
                  child: const Text('Save'),
                ),
                const SizedBox(width: 10,),
              ],
              context: context,
              title: 'Edit Profile'
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                   if(state is LoadingUpdateUserState)
                      const LinearProgressIndicator(),
                    SizedBox(
                      height: 190,
                      child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.topEnd,
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
                                          image: coverImage!=null
                                              ?FileImage(coverImage) as ImageProvider<Object>
                                              : NetworkImage(user.cover!),
                                          fit: BoxFit.cover,)
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 20,
                                    child: IconButton(
                                        onPressed: (){
                                      SocialCubit.get(context).getCoverImage(context);
                                    },
                                        icon: const Icon(IconBroken.Camera))
                                ),
                              ],
                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 64,
                                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage:profileImage!=null
                                        ?FileImage(profileImage) as ImageProvider<Object>
                                        : NetworkImage(user.image!),
                                  ),
                                ),
                                CircleAvatar(
                                  child: IconButton(
                                      onPressed: (){
                                        SocialCubit.get(context).getProfileImage(context);
                                      },
                                      icon: const Icon(IconBroken.Camera),
                                  ),
                                )
                              ],
                            ),
                          ]
                      ),
                    ),

                    const SizedBox(height: 20,),
                    defaultTextBox(
                      textBoxController: nameController,
                      labelText: 'Name',
                      validate: (value){
                        if(value!.isEmpty){
                          return 'the Name must be not empty';
                        }
                        return null;
                      },
                      prefIcon: const Icon(IconBroken.User),
                      inputType: TextInputType.name,
                      border: const OutlineInputBorder(),
                    ),
                    const SizedBox(height:10),
                    defaultTextBox(
                      textBoxController: bioController,
                      labelText: 'Bio',
                      validate: (value){
                        if(value!.isEmpty){
                          return 'the Bio must be not empty';
                        }
                        return null;
                      },
                      prefIcon: const Icon(IconBroken.Info_Circle),
                      inputType: TextInputType.name,
                      border: const OutlineInputBorder(),
                    ),
                    const SizedBox(height:10),
                    defaultTextBox(
                      textBoxController: phoneController,
                      labelText: 'Phone',
                      validate: (value){
                        if(value!.isEmpty){
                          return 'the phone must be not empty';
                        }
                        return null;
                      },
                      prefIcon: const Icon(Icons.phone),
                      inputType: TextInputType.phone,
                      border: const OutlineInputBorder(),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
