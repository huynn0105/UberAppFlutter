import 'package:UberApp/src/bloc/auth_bloc.dart';
import 'package:UberApp/src/bloc/login_bloc.dart';
import 'package:UberApp/src/bloc/register_bloc.dart';
import 'package:UberApp/src/events/auth_event.dart';
import 'package:UberApp/src/firebase/firebase_auth.dart';
import 'package:UberApp/src/resource/home_page.dart';
import 'package:UberApp/src/resource/login_page.dart';
import 'package:UberApp/src/resource/splash_page.dart';
import 'package:UberApp/src/states/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  final FirAuth _firAuth = FirAuth();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(firAuth: _firAuth)),
        BlocProvider(
            create:
                (context) => AuthBloc(firAuth: _firAuth)..add(AuthEventStarted())),
        BlocProvider(create: (context) => RegisterBloc(firAuth: _firAuth)),
      ],
      child: MaterialApp(home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          if (authState is AuthStateSuccess) {
            return HomePage();
          } else if (authState is AuthStateFailure) {
            return LoginPage();
          }
          return SplashPage();
        },
      )),
    );
  }
}
