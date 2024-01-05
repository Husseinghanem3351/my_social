import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_social_app/modules/Login/cubit/states.dart';
import 'package:my_social_app/modules/Register/Register.dart';

import '../../components/components.dart';
import 'cubit/cubit.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey=GlobalKey<FormState>();
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    return BlocProvider(
      create: (context) =>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state) {} ,
        builder: (context, state) =>Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Login now to communicate with friends',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      defaultTextBox(
                        inputType: TextInputType.emailAddress,
                        textBoxController: emailController,
                        labelText: 'email',
                        border: const OutlineInputBorder(),
                        prefIcon: const Icon(Icons.email),
                        validate: (value){
                          if(value!.isEmpty) return 'email is required';
                          return null;
                        },
                        inputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultTextBox(
                        inputType: TextInputType.visiblePassword,
                        validate: (value) {
                          if(value!.isEmpty) return 'password is required';
                          return null;
                        },
                        textBoxController: passwordController,
                        border: const OutlineInputBorder(),
                        labelText: 'password',
                        prefIcon: const Icon(Icons.lock),
                        textVisibility: !LoginCubit.get(context).isPass,
                        sufIcon: IconButton(onPressed: (){
                          LoginCubit.get(context).changeIconPass();
                        }, icon: Icon(LoginCubit.get(context).passIcon))
                      ),
                      const SizedBox(height: 10,),
                      Center(
                        child: ConditionalBuilder(
                          builder: (context)=>Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color:Colors.black54,
                                border: Border.all(
                                  color: Colors.purple,
                                )
                            ),
                            child: TextButton(
                              onPressed: (){
                                if(formKey.currentState!.validate()){
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text ,
                                    context: context);}
                              },
                              child: const Text(
                                'Login',
                                style:TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                          condition: state is !LoadingLoginState,
                          fallback: (context) => const CircularProgressIndicator(),
                        ),
                      ),
                      Row(
                        children: [
                          const Text('you don\'t have a account'),
                          TextButton(onPressed: (){
                            navigateTo(context: context, screen: const Register());
                          }, child: const Text('Register')),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
