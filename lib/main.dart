import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/forget_pass/forget_cubit.dart';
import 'blocs/login_cubit/login_cubit.dart';
import 'blocs/post_cubit/post_cubit.dart';
import 'blocs/sign_up_cubit/sign_up_cubit.dart';
import 'constants/theme/theme.dart';
import 'respository/post_repo/post_repo.dart';
import 'screens/splash_screen/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => SignUpCubit(),
        ),
        BlocProvider(
          create: (context) => ForgetCubit(),
        ),
        BlocProvider(
          create: (context) =>
              PostCubit(postRepository: PostRepository()..getAllPost()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home: SplashScreen(),
      ),
    );
  }
}
