import 'package:api_app/bloc/cubits/auth_cubit.dart';
import 'package:api_app/bloc/states/auth_states.dart';
import 'package:api_app/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
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
            appBar: AppBar(title: const Text("log in ")),
            body: ListView(children: [
              TextFormField(
                controller: authCubit.loginUserNameController,
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
                controller: authCubit.loginPasswordController,
                decoration: const InputDecoration(
                    label: Text("Password"), border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await authCubit.login();
                    }
                  },
                  child: const Text("Login")),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        " Register",
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              )
            ]),
          ),
        );
      },
    );
  }
}
