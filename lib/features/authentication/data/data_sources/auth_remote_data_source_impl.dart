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
      await userCredential.user!.updateDisplayName(name);
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
  Future<Unit> sendResetPasswordEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
          url: 'https://priyanshu912o.github.io/Fortress_site/reset-password',
          handleCodeInApp: true,
          androidPackageName: 'com.example.fortress_chat',
          androidInstallApp: true,
          androidMinimumVersion: '1',
          iOSBundleId: 'com.example.fortress_chat',
        ),
      );
      return unit;
    } on FirebaseAuthException catch (e) {
      throw mapFromFirebaseAuthExceptionToAppExceptions(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> verifyEmail() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
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

  @override
  Future<Unit> resetPasword(String newPassword, String oobCode) async {
    try {
      await _auth.confirmPasswordReset(code: oobCode, newPassword: newPassword);
      return unit;
    } on FirebaseAuthException catch (e) {
      throw mapFromFirebaseAuthExceptionToAppExceptions(e);
    }
  }
}
