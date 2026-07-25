import 'package:firebase_auth/firebase_auth.dart';
import 'package:fortress_chat/core/utils/map_firebase_exception_to_app_exceptions.dart';
import 'package:fortress_chat/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:fortress_chat/features/authentication/data/model/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth _auth;

  AuthRemoteDataSourceImpl({required this._auth});

  @override
  Future<UserModel> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebaseUserCredentitials(userCredential.user);
    } on FirebaseAuthException catch (e) {
      throw mapFromFirebaseAuthExceptionToAppExceptions(e);
    }
  }

  @override
  Future<UserModel> signUp(String name, String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userCredential.user!.updateDisplayName(name);
      return UserModel.fromFirebaseUserCredentitials(userCredential.user);
    } on FirebaseAuthException catch (e) {
      throw mapFromFirebaseAuthExceptionToAppExceptions(e);
    }
  }

  @override
  Future<Unit> signOut() async {
    try {
      await _auth.signOut();
      return unit;
    } on FirebaseAuthException catch (e) {
      throw mapFromFirebaseAuthExceptionToAppExceptions(e);
    }
  }

  Future<Unit> checkEmailVerification() {
    // TODO: implement checkEmailVerification
    throw UnimplementedError();
  }

  @override
  Future<Unit> forgotPassword(String email) async {
    _auth.sendPasswordResetEmail(email: email);
    return unit;
  }

  @override
  Future<Unit> verifyEmail() async {
    try {
      _auth.currentUser!.sendEmailVerification();
      return unit;
    } on FirebaseAuthException catch (e) {
      throw mapFromFirebaseAuthExceptionToAppExceptions(e);
    }
  }

  @override
  Future<bool> checkEailVerification() async {
    return _auth.currentUser!.emailVerified;
  }

  @override
  Stream<UserModel?> get userChanges => _auth.userChanges().map((user) {
    return (user == null)
        ? null
        : UserModel.fromFirebaseUserCredentitials(user);
  });
}
