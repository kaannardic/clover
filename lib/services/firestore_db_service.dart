import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clover/model/duyuru.dart';
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

  Future<bool> saveDuyuru(Duyuru kaydedilecekDuyuru) async {

    var _duyuruID = _firebaseDB.collection("duyurular").document().documentID;
    var _myDocumentID = kaydedilecekDuyuru.userID; /// userID ye göre döküman açacağız

    var _kaydedilecekMesajMapYapisi = kaydedilecekDuyuru.toMap();


    await _firebaseDB
        .collection("duyurular")
        .document(_myDocumentID)
        .collection("mesajlar")
        .document(_duyuruID)
        .setData(_kaydedilecekMesajMapYapisi);

    await _firebaseDB.collection("konusmalar").document(_myDocumentID).setData({
      "duyuru_sahibi": kaydedilecekDuyuru.userID,
      "duyuru_konusu": kaydedilecekDuyuru.konutxt,
      "son_yollanan_mesaj": kaydedilecekDuyuru.mesajDuyuru,
      "konusma_goruldu": false,
      "olusturulma_tarihi": FieldValue.serverTimestamp(),
    });

    return true;
  }





  Future<List<Duyuru>> getDuyuruWithPagination(
      String currentUserID,
      Duyuru enSonGetirilenMesaj,
      int getirilecekElemanSayisi) async {
    QuerySnapshot _querySnapshot;
    List<Duyuru> _tumDuyurular = [];

    if (enSonGetirilenMesaj == null) {
      _querySnapshot = await Firestore.instance
          .collection("duyurular")
          .document()
          .collection("mesajlar")
          .orderBy("createdAt", descending: true)
          .limit(getirilecekElemanSayisi)
          .getDocuments();
    } else {
      _querySnapshot = await Firestore.instance
          .collection("duyurular")
          .document()
          .collection("mesajlar")
          .orderBy("createdAt", descending: true)
          .startAfter([enSonGetirilenMesaj.createdAt])
          .limit(getirilecekElemanSayisi)
          .getDocuments();

      await Future.delayed(Duration(seconds: 1));
    }

    for (DocumentSnapshot snap in _querySnapshot.documents) {
      Duyuru _tekMesaj = Duyuru.fromMap(snap.data);
      _tumDuyurular.add(_tekMesaj);
    }

    return _tumDuyurular;
  }


  @override
  Stream<List<Duyuru>> getDuyuru(
      String currentUserID) {
    var snapShot = _firebaseDB
        .collection("duyurular")
        .document(currentUserID)
        .collection("mesajlar")
        .orderBy("createdAt", descending: true)
        .limit(1)
        .snapshots();
    return snapShot.map((duyuruListesi) => duyuruListesi.documents
        .map((duyuru) => Duyuru.fromMap(duyuru.data))
        .toList());
  }






}