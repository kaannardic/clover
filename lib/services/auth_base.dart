


import 'package:clover/model/user.dart';

abstract class AuthBase{


  Future<User> currentUser();
  Future<User> signInAnonymously();
  Future<bool> signOut();
  Future<User> signInWithGoogle();


}