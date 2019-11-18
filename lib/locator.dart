
import 'package:clover/repository/user_repository.dart';
import 'package:clover/services/fake_auth_service.dart';
import 'package:clover/services/firebase_auth_service.dart';
import 'package:clover/services/firebase_storage_service.dart';
import 'package:clover/services/firestore_db_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FakeAuthService());
  locator.registerLazySingleton(() => FirestoreDBService());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => FirebaseStorageService());
}
