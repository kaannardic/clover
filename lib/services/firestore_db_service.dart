import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clover/model/user.dart';
import 'package:clover/services/database_base.dart';


class FirestoreDBService implements DBBase {
  final Firestore _firebaseDB = Firestore.instance;

  @override
  Future<bool> saveUser(User user) async {
    DocumentSnapshot _okunanUser =
    await Firestore.instance.document("users/${user.userID}").get();

    if (_okunanUser.data == null) {
      await _firebaseDB
          .collection("users")
          .document(user.userID)
          .setData(user.toMap());
      return true;
    } else {
      return true;
    }
  }

  @override
  Future<User> readUser(String userID) async {
    DocumentSnapshot _okunanUser =
    await _firebaseDB.collection("users").document(userID).get();
    Map<String, dynamic> _okunanUserBilgileriMap = _okunanUser.data;
    // 241
    User _okunanUserNesnesi = User.fromMap(_okunanUserBilgileriMap);
    print(("okunan user nesnesi:" + _okunanUserNesnesi.toString()));
    return _okunanUserNesnesi;
  }

  @override
  Future<bool> updateUserName(String userID, String yeniUserName) async {
    var users = await _firebaseDB
        .collection("users")
        .where("userName", isEqualTo: yeniUserName)
        .getDocuments();

    if (users.documents.length >= 1) {
      return false;
    } else {
      await _firebaseDB
          .collection("users")
          .document(userID)
          .updateData({'userName': yeniUserName});
      return true;
    }
  }

  @override
  Future<bool> updateProfilFoto(String userID, String profilFotoURL) async {
    await _firebaseDB
        .collection("users")
        .document(userID)
        .updateData({'profilURL': profilFotoURL});
    return true;
  }

  Future<bool> updateBiyografi(String userID, String yeniBiyografi) async {
    var users = await _firebaseDB
        .collection("users")
        .where("biyografi", isEqualTo: yeniBiyografi)
        .getDocuments();

    if (users.documents.length >= 1) {
      return false;
    } else {
      await _firebaseDB
          .collection("users")
          .document(userID)
          .updateData({'biyografi': yeniBiyografi});
      return true;
    }
  }

//////////////////////////////////////////////////////////////////////////////////////













}