import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<bool> hasUserLogged() async {
  ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
  if (currentUser == null) {
    return false;
  }
  //Checks whether the user's session token is valid
  final ParseResponse? parseResponse =
  await ParseUser.getCurrentUserFromServer(currentUser.sessionToken!);

  if (parseResponse?.success == null || !parseResponse!.success) {
    //Invalid session. Logout
    await currentUser.logout();
    return false;
  } else {
    return true;
  }
}

  Future<ParseUser?> getCurrentUser() async {
      if(await hasUserLogged()) {
        ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
        return currentUser;
  }else {
        return null;
      }


}

deauthenticate(BuildContext context) {
  BlocProvider.of<AuthenticationBloc>(context).add(Deauthenticate());
}

authenticate(BuildContext context) {
  BlocProvider.of<AuthenticationBloc>(context).add(Authenticate());
}

enum AuthenticationState {
  unauthenticated,
  authenticated,
}

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(super.initialState);

  AuthenticationState get initialState => AuthenticationState.unauthenticated;

  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
      ) async* {
    if (event is Authenticate) {
      yield AuthenticationState.authenticated;
    } else if (event is Deauthenticate) {
      yield AuthenticationState.unauthenticated;
    }
  }
}

class AuthenticationEvent {}

class Authenticate extends AuthenticationEvent {}

class Deauthenticate extends AuthenticationEvent {}