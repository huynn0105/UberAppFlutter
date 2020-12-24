import 'package:UberApp/src/bloc/auth_bloc.dart';
import 'package:UberApp/src/bloc/login_bloc.dart';
import 'package:UberApp/src/bloc/register_bloc.dart';
import 'package:UberApp/src/events/auth_event.dart';
import 'package:UberApp/src/events/register_event.dart';
import 'package:UberApp/src/firebase/firebase_auth.dart';
import 'package:UberApp/src/resource/home_page.dart';
import 'package:UberApp/src/states/auth_state.dart';
import 'package:UberApp/src/states/register_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';

class RegisterPage extends StatefulWidget {
  final FirAuth _firAuth;


  RegisterPage({Key key, @required FirAuth firAuth}):
        assert(firAuth != null),
        _firAuth = firAuth,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterPageState();


}

class _RegisterPageState extends State<RegisterPage> {
  FirAuth get _firAuth => widget._firAuth;
  ProgressDialog pr;
  RegisterBloc _registerBloc;
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(()=>
        _registerBloc.add(RegisterEventEmailChanged(email: _emailController.text)));

    _nameController.addListener(() =>
        _registerBloc.add(RegisterEventNameChanged(name: _nameController.text)));

    _passController.addListener(() =>
        _registerBloc.add(RegisterEventPasswordChanged(password: _passController.text)));

    _phoneController.addListener(() =>
        _registerBloc.add(RegisterEventPhoneChanged(phone: _phoneController.text)));
  }

  bool get isPopulated =>
      _emailController.text.isNotEmpty
      && _nameController.text.isNotEmpty
      && _passController.text.isNotEmpty
      && _phoneController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState registerState) =>
      registerState.isValid && isPopulated && !registerState.isSubmitting;




  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context);
    pr.style(message: 'Please wait...');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xff3277D8)),
        elevation: 0,
      ),
      body: BlocBuilder<RegisterBloc,RegisterState>(
        builder: (context,registerState){
          if(registerState.isFailure) {
            print('Registration Failed');
            SchedulerBinding.instance.addPostFrameCallback((_) {
              pr.hide();
            });
          }
          else if(registerState.isSubmitting){
            SchedulerBinding.instance.addPostFrameCallback((_) {
              pr.show();
            });
          }
          else if(registerState.isSuccess){
            SchedulerBinding.instance.addPostFrameCallback((_) {
              pr.hide();
            });
            BlocProvider.of<AuthBloc>(context).add(AuthEventLoggedIn());

          }
          return Container(
              color: Colors.white,
              padding: EdgeInsets.only(right: 30.0,left: 30.0),
              constraints: BoxConstraints.expand(),
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/ic_car_red.png'),
                      Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 10),
                        child: Text(
                          "Welcome Abroad!",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ),
                      Text("SignUp with iCab in simple steps", style: TextStyle(fontSize: 18, color:Colors.black54)),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
                        child: TextField(
                          controller: _nameController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              errorText: registerState.isValidName ? null : "Invalid Name",
                              labelText: "Name",
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(color: Color(0xffCED02)))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextField(
                          controller: _phoneController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Phone Number",
                              errorText: registerState.isValidPhone ? null : "Invalid Phone Number",
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(color: Color(0xffCED02)))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 18, color: Colors.black),

                          decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(Icons.email),
                              errorText: registerState.isValidEmail ? null : "Invalid Email",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(color: Color(0xffCED02)))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextField(
                          controller: _passController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              errorText: registerState.isValidPassword ? null : "Invalid Password",
                              labelText: "Password",
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(color: Color(0xffCED02)))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: SizedBox(
                          height: 52.0,
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed:() => isRegisterButtonEnabled(registerState) ?
                            _onRegister() : null,
                            child: Text("Register",style: TextStyle(fontSize: 20,color: Colors.white),),
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0,bottom: 10.0),
                        child: RichText(
                          text: TextSpan(
                              text: "Already a User?",
                              style: TextStyle(fontSize: 16,color: Colors.black45),
                              children: [
                                TextSpan(
                                    text: " Login now",
                                    style: TextStyle(fontSize: 16,color: Colors.blueAccent,fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()..onTap = (){
                                      Navigator.of(context).pop();
                                    }
                                )
                              ]
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
          );
        },
      )
      );
  }
  void _onRegister(){
    _registerBloc.add(RegisterEventPressed(
        email: _emailController.text,
        name: _nameController.text,
        pass: _passController.text,
        phone: _phoneController.text));
  }
}
