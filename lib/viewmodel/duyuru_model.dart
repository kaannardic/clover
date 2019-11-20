
import 'dart:async';

import 'package:clover/locator.dart';
import 'package:clover/model/duyuru.dart';
import 'package:clover/model/user.dart';
import 'package:clover/repository/user_repository.dart';

import 'package:flutter/material.dart';


enum DuyuruViewState { Idle,Loaded, Busy }

class DuyuruModel with ChangeNotifier  {
  List<Duyuru> _tumDuyurular;
  DuyuruViewState _state = DuyuruViewState.Idle;
  static final sayfaBasinaGonderiSayisi = 10;
  UserRepository _userRepository = locator<UserRepository>();
  final User currentUser;
  Duyuru _duyuru;

  Duyuru _enSonGetirilenDuyuru;
  Duyuru _listeyeEklenenIlkDuyuru;
  bool _hasMore = true;
  bool _yeniMesajDinleListener = false;



  bool get hasMoreLoading => _hasMore;

  StreamSubscription _streamSubscription;

  DuyuruModel({this.currentUser}) {
    _tumDuyurular = [];
    getDuyuruWithPagination(false);
  }

  List<Duyuru> get dmesajlarListesi => _tumDuyurular;

  DuyuruViewState get state => _state;

  set state(DuyuruViewState value) {
    _state = value;
    notifyListeners();
  }

  @override
  dispose() {
    print("Chatviewmodel dispose edildi");
    _streamSubscription.cancel();
    super.dispose();
  }








  Future<bool> saveDuyuru(Duyuru kaydedilecekDuyuru) async {
    return await _userRepository.saveDuyuru(kaydedilecekDuyuru);
  }


  void getDuyuruWithPagination(bool yeniDuyurularGetiriliyor) async {
    if (_tumDuyurular.length > 0) {
      _enSonGetirilenDuyuru = _tumDuyurular.last;
    }

    if (!yeniDuyurularGetiriliyor) state = DuyuruViewState.Busy;

    var getirilenDuyurular = await _userRepository.getDuyuruWithPagination(
        currentUser.userID,
       // sohbetEdilenUser.userID,
        _enSonGetirilenDuyuru,
        sayfaBasinaGonderiSayisi);

    if (getirilenDuyurular.length < sayfaBasinaGonderiSayisi) {
      _hasMore = false;
    }



    _tumDuyurular.addAll(getirilenDuyurular);
    if (_tumDuyurular.length > 0) {
      _listeyeEklenenIlkDuyuru = _tumDuyurular.first;
      // print("Listeye eklenen ilk mesaj :" + _listeyeEklenenIlkMesaj.mesaj);
    }

    state = DuyuruViewState.Loaded;

    if (_yeniMesajDinleListener == false) {
      _yeniMesajDinleListener = true;
      //print("Listener yok o yüzden atanacak");
      yeniDuyuruListenerAta();
    }
  }

  void yeniDuyuruListenerAta() {
    print("Yeni mesajlar için listener atandı");
    _streamSubscription = _userRepository
        .getDuyuru(currentUser.userID)
        .listen((anlikData) {
      if (anlikData.isNotEmpty) {
        print("listener tetiklendi ve son getirilen veri:" +
            anlikData[0].toString());

        if (anlikData[0].createdAt != null) {
          if (_listeyeEklenenIlkDuyuru == null) {
            _tumDuyurular.insert(0, anlikData[0]);
          } else if (_listeyeEklenenIlkDuyuru.createdAt.millisecondsSinceEpoch !=
              anlikData[0].createdAt.millisecondsSinceEpoch)
            _tumDuyurular.insert(0, anlikData[0]);
        }

        state = DuyuruViewState.Loaded;
      }
    });
  }



  Future<void> dahaFazlaMesajGetir() async {
    print("Daha fazla mesaj getir tetiklendi - viewmodeldeyiz -");
    if (_hasMore)
      getDuyuruWithPagination(true);
    else
      print("Daha fazla eleman yok o yüzden çagrılmayacak");
    await Future.delayed(Duration(seconds: 2));
  }









}