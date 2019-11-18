import 'package:clover/model/user.dart';
import 'package:clover/services/auth_base.dart';


class FakeAuthService implements AuthBase {
  // SAHTE BÖLÜM //

  String userID = " deneme ID";

  @override
  Future<User> currentUser() async {
    return await Future.value(User(userID: userID, email: "kafeuser"));
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  @override
  Future<User> signInAnonymously() async {
    return await Future.delayed(
        Duration(seconds: 2), () => User(userID: userID, email: "kafeuser"));
  }

  @override
  Future<User> signInWithGoogle() async{
    return await Future.delayed(
        Duration(seconds: 2), () => User(userID: "google user ID", email: "kafeuser"));
  }
}
