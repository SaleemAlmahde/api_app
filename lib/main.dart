import 'package:api_app/bloc/cubits/app_cubit.dart';
import 'package:api_app/bloc/cubits/auth_cubit.dart';
import 'package:api_app/bloc/states/auth_states.dart';
import 'package:api_app/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => AppCubit()..getEmployees(),
    ),
    BlocProvider(
      create: (context) => AuthCubit(sp)..loadTokenFromSP(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AuthCubit authCubit = AuthCubit.get(context);
        return MaterialApp(
          title: "Api test",
          home: authCubit.token != "" ? const HomePage() : RegisterPage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
