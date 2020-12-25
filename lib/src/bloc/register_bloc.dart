import 'package:UberApp/src/events/register_event.dart';
import 'package:UberApp/src/firebase/firebase_auth.dart';
import 'package:UberApp/src/states/register_state.dart';
import 'package:UberApp/src/validators/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends Bloc<RegisterEvent,RegisterState>{

  final FirAuth _firAuth;

  RegisterBloc({FirAuth firAuth}):
        assert(firAuth != null),
        _firAuth = firAuth,
        super(RegisterState.initial());


  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(Stream<RegisterEvent> registerEvents, transitionFn) {
    final debounceStream = registerEvents.where((registerEvent){
      return (registerEvent is RegisterEventPhoneChanged ||
    registerEvent is RegisterEventPasswordChanged ||
    registerEvent is RegisterEventNameChanged ||
    registerEvent is RegisterEventEmailChanged ||
    registerEvent is RegisterEventPressed);
    }).debounceTime(Duration(milliseconds: 300));
    final nonDebounceStream = registerEvents.where((registerEvent){
      return (registerEvent is! RegisterEventPhoneChanged &&
          registerEvent is! RegisterEventPasswordChanged &&
          registerEvent is! RegisterEventNameChanged &&
          registerEvent is! RegisterEventEmailChanged &&
          registerEvent is! RegisterEventPressed);
    });
    return super.transformEvents(nonDebounceStream.mergeWith([debounceStream]), transitionFn);
  }

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent registerEvent) async* {

      if(registerEvent is RegisterEventEmailChanged){
        yield state.cloneAndUpdate(
          isValidEmail: Validators.isValidEmail(registerEvent.email),
        );
      }
      else if(registerEvent is RegisterEventNameChanged){
        yield state.cloneAndUpdate(
          isValidName: Validators.isValidName(registerEvent.name),
        );
      }
      else if(registerEvent is RegisterEventPhoneChanged){
        yield state.cloneAndUpdate(
          isValidPhone: Validators.isValidPhone(registerEvent.phone),
        );
      }
      else if(registerEvent is RegisterEventPasswordChanged){
        yield state.cloneAndUpdate(
          isValidPassword: Validators.isValidPassword(registerEvent.password),
        );
      }
      else if(registerEvent is RegisterEventPressed){
        yield RegisterState.loading();
        try{
          await _firAuth.signUp(registerEvent.email, registerEvent.pass, registerEvent.name, registerEvent.phone);
          yield RegisterState.success();
        }catch(_){
          yield RegisterState.failure();
        }
      }
  }


}


