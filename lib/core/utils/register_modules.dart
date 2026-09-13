import 'package:app_links/app_links.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../database/app_database.dart';

@module
abstract class RegisterModules {
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @lazySingleton
  AppLinks get appLinks => AppLinks();

  @lazySingleton
  AppDatabase get appDatabase => AppDatabase();

  @lazySingleton
  Dio get dio => Dio();
}
