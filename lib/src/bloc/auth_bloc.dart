import 'package:UberApp/src/events/auth_event.dart';
import 'package:UberApp/src/firebase/firebase_auth.dart';
import 'package:UberApp/src/states/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
  final FirAuth _firAuth;

  AuthBloc({@required FirAuth firAuth}) :
        assert(firAuth !=null),
        _firAuth = firAuth,
        super(AuthStateInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent authEvent) async* {
   if(authEvent is AuthEventStarted){
     final isSignIn = await _firAuth.isSignedIn();
     if(isSignIn){
       final user = await _firAuth.getUser();
       yield AuthStateSuccess(user: user);
     }
     else{
       yield AuthStateFailure();
     }
   }
   else if(authEvent is AuthEventLoggedIn){
      yield AuthStateSuccess(user: await _firAuth.getUser());
   }
   else if(authEvent is AuthEventLoggedOut){
     _firAuth.signOut();
     yield AuthStateFailure();
   }
  }

}