import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:migraine_aid/src/shared/userFunctions.dart';
import 'package:migraine_aid/src/shared/welcome.dart';

class AuthenticationWidget extends StatelessWidget {
  final Widget child;

  const AuthenticationWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state == AuthenticationState.authenticated) {
          return child;
        }
        return const WelcomePage();
      },
    );
  }
}