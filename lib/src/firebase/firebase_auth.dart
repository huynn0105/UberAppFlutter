import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirAuth {
  final FirebaseAuth _firebaseAuth;

  FirAuth({FirebaseAuth firebaseAuth}) :
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> signUp(String email, String pass, String name, String phone) async{
    return await this._firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass)
        .then((user){
          _createUser(user.user.uid, name, phone, email);

        }).catchError((onError) =>print("Lỗi - ${onError.toString()}"));
  }

  _createUser(String userId, String name, String phone, String email){
    var user = Map<String, String>();
    user["name"] = name;
    user["phone"] = phone;
    user["email"] = email;
    var ref = FirebaseDatabase.instance.reference().child("users");

    ref.child(userId).set(user).then((user) => print("Thêm thành công")).catchError((onError) => print("Thất bại - ${onError.toString()}"));
  }

  Future<void> signIn(String email, String pass) async{
    return await this._firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);
  }

  Future<void> signOut() async{
    return await _firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async{
    return _firebaseAuth.currentUser != null;
  }

  Future<User> getUser() async{
    return _firebaseAuth.currentUser;
  }
}