import 'package:clover/model/duyuru.dart';
import 'package:clover/model/user.dart';

abstract class DBBase {
  Future<bool> saveUser(User user);

  Future<User> readUser(String userID);

  Future<bool> updateUserName(String userID, String yeniUserName);

  Future<bool> updateProfilFoto(String userID, String profilFotoURL);

  Future<bool> saveDuyuru(Duyuru kaydedilecekDuyuru);
  Future<List<Duyuru>> getDuyuru();
}
