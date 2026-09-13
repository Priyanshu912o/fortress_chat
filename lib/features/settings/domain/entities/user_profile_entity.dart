import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;

  const UserProfileEntity({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [uid, email, displayName, photoUrl];
}
