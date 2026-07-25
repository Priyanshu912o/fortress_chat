import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final bool isEmailVerified;
  final String name;
  final String email;

  const UserEntity({required this.name, required this.email, required this.uid, required this.isEmailVerified,});

  @override
  List<Object?> get props => [uid,isEmailVerified,name,email,];}