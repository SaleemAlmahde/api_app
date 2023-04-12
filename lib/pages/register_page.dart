import 'package:api_app/bloc/cubits/auth_cubit.dart';
import 'package:api_app/bloc/states/auth_states.dart';
import 'package:api_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AuthCubit authCubit = AuthCubit.get(context);
        return Form(
          key: formKey,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Register"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  TextFormField(
                    controller: authCubit.registerUserNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "this field is required";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        label: Text("User name"), border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: authCubit.registerEmailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "this field is required";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        label: Text("e-mail"), border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: authCubit.registerPasswordController,
                    decoration: const InputDecoration(
                        label: Text("Password"), border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller:
                        authCubit.registerPasswordConfirmationController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "this field is required";
                      }
                      if (value != authCubit.registerPasswordController.text) {
                        return "the password confirmation do not match";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        label: Text("Password confirmation"),
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await authCubit.register();
                        }
                      },
                      child: const Text("Register")),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                              (route) => false,
                            );
                          },
                          child: const Text(
                            " login",
                            style: TextStyle(color: Colors.blue),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
