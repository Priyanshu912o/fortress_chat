import 'package:equatable/equatable.dart';

class ContactProfileEntity extends Equatable {
  final String uid;
  final String email;
  final String name;
  final String? dpUrl;
  final bool isOnline;
  final DateTime? lastSeen;

  const ContactProfileEntity({
    required this.uid,
    required this.email,
    required this.name,
    this.dpUrl,
    this.isOnline = false,
    this.lastSeen,
  });

  @override
  List<Object?> get props => [uid, email, name, dpUrl, isOnline, lastSeen];
}
