import 'package:firebase_auth/firebase_auth.dart';
import 'package:fortress_chat/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.name,
    required super.email,
    required super.uid,
    required super.isEmailVerified,
  });

  factory UserModel.fromFirebaseUserCredentitials(
    User? user,
  ) {
    return UserModel(
      name: user?.displayName ?? 'No name',
      email: user?.email ?? 'No email',
      uid: user?.uid ?? 'No uid',
      isEmailVerified: user?.emailVerified ?? false,
    );
  }
}
