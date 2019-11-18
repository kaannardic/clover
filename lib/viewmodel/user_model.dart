import 'dart:io';

import 'package:clover/locator.dart';
import 'package:clover/model/user.dart';
import 'package:clover/repository/user_repository.dart';
import 'package:clover/services/auth_base.dart';
import 'package:flutter/material.dart';


enum ViewState { Idle, Busy }

class UserModel with ChangeNotifier implements AuthBase {
  ViewState _state = ViewState.Idle;
  UserRepository _userRepository = locator<UserRepository>();
  User _user;
  String emailHataMesaji;
  String sifreHataMesaji;

  User get user => _user;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel() {
    currentUser();
  }

  @override
  Future<User> currentUser() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.currentUser();
      if(_user != null)
        return _user;
      else return null;
    } catch (e) {
      debugPrint("Viewmodelde current user hata " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      debugPrint("Viewmodelde current user hata " + e.toString());
      return false;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> signInAnonymously() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInAnonymously();
      return _user;
    } catch (e) {
      debugPrint("Viewmodelde current user hata " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInWithGoogle();
      if(_user != null)
        return _user;
      else return null;
    } catch (e) {
      debugPrint("Viewmodelde current user hata " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  Future<bool> updateUserName(String userID, String yeniUserName) async {
    var sonuc = await _userRepository.updateUserName(userID, yeniUserName);

    if (sonuc) {
      _user.userName = yeniUserName;
    }
    return sonuc;
  }

  Future<String> uploadFile(
      String userID, String fileType, File profilFoto) async {
    var indirmeLinki =
    await _userRepository.uploadFile(userID, fileType, profilFoto);
    return indirmeLinki;
  }

  Future<bool> updateBiyografi(String userID, String yeniBiyografi) async {
    var sonuc = await _userRepository.updateBiyografi(userID, yeniBiyografi);

    if (sonuc) {
      _user.biyografi = yeniBiyografi;
    }
    return sonuc;
  }

/*Stream<List<Duyuru>> getAllDuyuru(String duyuruAtanUserID) {
     return _userRepository.getAllDuyuru(duyuruAtanUserID);

  }*/


}
