import 'dart:async';

import 'package:clover/locator.dart';
import 'package:clover/model/duyuru.dart';

import 'package:clover/repository/user_repository.dart';

import 'package:flutter/material.dart';

enum DuyuruViewState { Idle, Loaded, Busy }

class DuyuruModel with ChangeNotifier {

  DuyuruViewState _state = DuyuruViewState.Idle;

  List<Duyuru> _tumDuyurular;
  UserRepository _userRepository = locator<UserRepository>();
  List<Duyuru> get duyurularListesi => _tumDuyurular;

  DuyuruViewState get state => _state;

  set state(DuyuruViewState value) {
    _state = value;
    notifyListeners();
  }



  Future<bool> saveDuyuru(Duyuru kaydedilecekDuyuru) async {

    return await _userRepository.saveDuyuru(kaydedilecekDuyuru);
  }

  Future<List<Duyuru>> getDuyuru() async {

    var tumDuyuruListesi = await _userRepository.getDuyuru();

    return tumDuyuruListesi;

  }
/*

var tumDuyuruListesi = await _userRepository.getDuyuru();
    return tumDuyuruListesi;
    */

}
