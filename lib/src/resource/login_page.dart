
import 'package:UberApp/src/bloc/auth_bloc.dart';
import 'package:UberApp/src/bloc/login_bloc.dart';
import 'package:UberApp/src/bloc/register_bloc.dart';
import 'package:UberApp/src/events/auth_event.dart';
import 'package:UberApp/src/events/login_event.dart';
import 'package:UberApp/src/firebase/firebase_auth.dart';
import 'package:UberApp/src/resource/register_page.dart';
import 'package:UberApp/src/states/auth_state.dart';
import 'package:UberApp/src/states/login_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'dialog/loading_dialog.dart';
import 'package:meta/meta.dart';

class LoginPage extends StatefulWidget {
  final FirAuth _firAuth;

  LoginPage({Key key, @required FirAuth firAuth}):
      assert(firAuth != null),
      _firAuth = firAuth,
      super(key: key);

  @override
  State<StatefulWidget> createState() =>  _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  ProgressDialog pr;
  LoginBloc _loginBloc;
  FirAuth get _firAuth => widget._firAuth;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(()=> _loginBloc.add(LoginEventEmailChanged(email: _emailController.text)));
    _passwordController.addListener(()=> _loginBloc.add(LoginEventPasswordChanged(password: _passwordController.text)));

  }

  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState loginState) =>
      loginState.isValidEmailAndPassword & isPopulated && !loginState.isSubmitting;

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,type: ProgressDialogType.Normal);
    pr.style(message: 'Please wait...');
    return Scaffold(
        body: BlocBuilder<LoginBloc,LoginState>(
            builder: (context,loginState){
              if(loginState.isFailure){
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  pr.hide();
                });
              }
              else if(loginState.isSubmitting) {
                print('Logging in');
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  pr.show();
                });

              }else if(loginState.isSuccess){
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  pr.hide();
                });
                BlocProvider.of<AuthBloc>(context).add(AuthEventLoggedIn());
              }
              return Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  constraints: BoxConstraints.expand(),
                  child: Form(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 80.0),
                            child: Image.asset('assets/images/ic_car_green.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40, bottom: 10),
                            child: Text(
                              "Welcome Back!",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                          Text("Login to continue using iCab", style: TextStyle(fontSize: 20)),
                          Padding(
                            padding: const EdgeInsets.only(top: 100.0, bottom: 20.0),
                            child: TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(fontSize: 18, color: Colors.black),
                              decoration: InputDecoration(
                                  errorText: loginState.isValidEmail ? null : "email invalid",
                                  labelText: "Email",
                                  prefixIcon: Icon(Icons.email),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide(color: Color(0xffCED02)))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextField(
                              controller: _passwordController,
                              style: TextStyle(fontSize: 18, color: Colors.black),
                              decoration: InputDecoration(
                                  errorText: loginState.isValidPassword ? null : "password invalid",
                                  labelText: "Password",
                                  prefixIcon: Icon(Icons.lock),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide(color: Color(0xffCED02)))),
                            ),
                          ),
                          Container(
                              alignment: Alignment.centerRight,
                              child: Text("Forgot password?",style: TextStyle(fontSize: 16,color: Colors.black54),)
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: SizedBox(
                              height: 52.0,
                              width: double.infinity,
                              child: RaisedButton(
                                onPressed: (){
                                  _onLogin();
                                },

                                child: Text("Login",style: TextStyle(fontSize: 20,color: Colors.white),),
                                color: Colors.blue,
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
                                  text: "New user?",
                                  style: TextStyle(fontSize: 16,color: Colors.black45),
                                  children: [
                                    TextSpan(
                                        text: " Sign up for a new account",
                                        style: TextStyle(fontSize: 16,color: Colors.blueAccent,fontWeight: FontWeight.bold),
                                        recognizer: TapGestureRecognizer()..onTap = (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                            return RegisterPage(firAuth: _firAuth,);
                                          }));
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
          ),

    );
  }

  void _onLogin(){
    _loginBloc.add(LoginEventPressed(
      email: _emailController.text,
      password: _passwordController.text
    ));
  }
}
