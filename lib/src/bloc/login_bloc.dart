import 'package:UberApp/src/events/login_event.dart';
import 'package:UberApp/src/firebase/firebase_auth.dart';
import 'package:UberApp/src/states/login_state.dart';
import 'package:UberApp/src/states/register_state.dart';
import 'package:UberApp/src/validators/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  final FirAuth _firAuth;

  LoginBloc({FirAuth firAuth}) :
        assert(firAuth!=null),
        _firAuth = firAuth,
        super(LoginState.initial());

  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(Stream<LoginEvent> loginEvents, TransitionFunction<LoginEvent, LoginState> transitionFunction) {
    final debounceStream = loginEvents.where((loginEvent){
      return (loginEvent is LoginEventEmailChanged ||
          loginEvent is LoginEventPasswordChanged ||
          loginEvent is LoginEventPressed);
    }).debounceTime(Duration(milliseconds: 300));

    final nonDebounceStream = loginEvents.where((loginEvent){
      return (loginEvent is! LoginEventEmailChanged &&
          loginEvent is! LoginEventPasswordChanged && 
          loginEvent is! LoginEventPressed);
    });

    return super.transformEvents(nonDebounceStream.mergeWith([debounceStream]), transitionFunction);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent loginEvent) async* {
    if(loginEvent is LoginEventEmailChanged){
      yield state.cloneAndUpdate(isValidEmail: Validators.isValidEmail(loginEvent.email));
    }
    else if(loginEvent is LoginEventPasswordChanged){
      yield state.cloneAndUpdate(isValidPassword: Validators.isValidPassword(loginEvent.password));
    }
    else if(loginEvent is LoginEventPressed){
      yield LoginState.loading();
      try{
        await _firAuth.signIn(loginEvent.email, loginEvent.password);
        yield LoginState.success();
      }catch(_){
        yield LoginState.failure();
      }
    }
  }
}