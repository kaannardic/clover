import 'dart:io';

import 'package:clover/locator.dart';
import 'package:clover/model/duyuru.dart';
import 'package:clover/model/user.dart';
import 'package:clover/services/auth_base.dart';
import 'package:clover/services/fake_auth_service.dart';
import 'package:clover/services/firebase_auth_service.dart';
import 'package:clover/services/firebase_storage_service.dart';
import 'package:clover/services/firestore_db_service.dart';


enum AppMode { DEBUG, RELEASE }

class UserRepository implements AuthBase {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FakeAuthService _fakeAuthService = locator<FakeAuthService>();
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  FirebaseStorageService _firebaseStorageService =
  locator<FirebaseStorageService>();


  AppMode appMode = AppMode.RELEASE;
  List<User> tumKullaniciListesi = [];
  Map<String, String> kullaniciToken = Map<String, String>();


  @override
  Future<User> currentUser() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.currentUser();
    } else {
      User _user = await _firebaseAuthService.currentUser();
      if (_user != null)
        return await _firestoreDBService.readUser(_user.userID);
      else
        return null;
    }
  }

  @override
  Future<User> signInAnonymously() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signInAnonymously();
    } else {
      return await _firebaseAuthService.signInAnonymously();
    }
  }

  @override
  Future<bool> signOut() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signOut();
    } else {
      return await _firebaseAuthService.signOut();
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signInWithGoogle();
    } else {
      User _user = await _firebaseAuthService.signInWithGoogle();
      if (_user != null) {
        bool _sonuc = await _firestoreDBService.saveUser(_user);
        if (_sonuc) {
          return await _firestoreDBService.readUser(_user.userID);
        } else {
          await _firebaseAuthService.signOut();
          return null;
        }
      }
      else
        return null;
    }
  }


  Future<bool> updateUserName(String userID, String yeniUserName) async {
    if (appMode == AppMode.DEBUG) {
      return false;
    } else {
      return await _firestoreDBService.updateUserName(userID, yeniUserName);
    }
  }

  Future<String> uploadFile(String userID, String fileType,
      File profilFoto) async {
    if (appMode == AppMode.DEBUG) {
      return "dosya indirme linki";
    } else {
      var profilFotoURL = await _firebaseStorageService.uploadFile(
          userID, fileType, profilFoto);
      await _firestoreDBService.updateProfilFoto(userID, profilFotoURL);
      return profilFotoURL;
    }
  }

  Future<bool> updateBiyografi(String userID, String yeniBiyografi) async {
    if (appMode == AppMode.DEBUG) {
      return false;
    } else {
      return await _firestoreDBService.updateBiyografi(userID, yeniBiyografi);
    }
  }

  Future<bool> saveDuyuru(Duyuru kaydedilecekDuyuru) async {
    if (appMode == AppMode.DEBUG) {
      return true;
    } else {
      return _firestoreDBService.saveDuyuru(kaydedilecekDuyuru);
    }
  }




  Future<List<Duyuru>> getDuyuruWithPagination(
      String currentUserID,
      Duyuru enSonGetirilenDuyuru,
      int getirilecekElemanSayisi) async {
    if (appMode == AppMode.DEBUG) {
      return [];
    } else {
      return await _firestoreDBService.getDuyuruWithPagination(currentUserID,
          enSonGetirilenDuyuru, getirilecekElemanSayisi);
    }
  }


  Stream<List<Duyuru>> getDuyuru(
      String currentUserID) {
    if (appMode == AppMode.DEBUG) {
      return Stream.empty();
    } else {
      return _firestoreDBService.getDuyuru(currentUserID);
    }
  }




}

