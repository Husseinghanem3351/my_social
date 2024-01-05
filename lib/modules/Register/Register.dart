import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/modules/Register/cubit/cubit.dart';

import '../../components/components.dart';
import 'cubit/states.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey=GlobalKey<FormState>();
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          // TODO: implement listener
          if(state is SuccessCreateUserState){
            showToast(msg: 'Register successfully',color: Colors.green);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Form(
                    key:formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Register now to communicate with friends',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        defaultTextBox(
                          validate: (value){
                            if(value!.isEmpty) return 'name is required';
                            return null;
                          },
                          textBoxController: nameController,
                          labelText: 'name',
                          prefIcon: const Icon(Icons.person),
                          border: const OutlineInputBorder(),
                          inputType: TextInputType.name,
                          inputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 10,),
                        defaultTextBox(
                          validate: (value){
                            if(value!.isEmpty) return 'email is required';
                            return null;
                          },
                          inputType: TextInputType.emailAddress,
                          textBoxController: emailController,
                          labelText: 'email',
                          prefIcon: const Icon(Icons.person),
                          border: const OutlineInputBorder(),
                          inputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 10,),
                        defaultTextBox(
                          validate: (value){
                            if(value!.isEmpty) return 'phone is required';
                            return null;
                          },
                          inputType: TextInputType.phone,
                          textBoxController: phoneController,
                          labelText: 'phone',
                          prefIcon: const Icon(Icons.person),
                          border: const OutlineInputBorder(),
                          inputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 10,),
                        defaultTextBox(
                          validate: (value){
                            if(value!.isEmpty) return 'password is required';
                            return null;
                          },
                          inputType: TextInputType.visiblePassword,
                          textBoxController: passwordController,
                          labelText: 'password',
                          prefIcon: const Icon(Icons.lock),
                          sufIcon: IconButton(onPressed: (){RegisterCubit.get(context).changeIconPass();}, icon: Icon(RegisterCubit.get(context).passIcon)),
                          textVisibility:!RegisterCubit.get(context).isPass,
                          border: const OutlineInputBorder(),
                        ),
                        const SizedBox(height: 10,),
                        Center(
                          child: ConditionalBuilder(
                            fallback:(context) => const CircularProgressIndicator() ,
                            condition: state is! LoadingRegisterState,
                            builder: (context) => Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black54,
                                  border: Border.all(
                                    color: Colors.purple,
                                  )
                              ),
                              child: TextButton(
                                onPressed: () {
                                  if(formKey.currentState!.validate()){
                                    RegisterCubit.get(context).registerUser(
                                      context: context,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone:phoneController.text,
                                    );
                                  }
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
