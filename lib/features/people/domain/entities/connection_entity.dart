import 'package:equatable/equatable.dart';
import 'connection_status.dart';

class ConnectionEntity extends Equatable {
  final String id;
  final String fromUid;
  final String toUid;
  final ConnectionStatus status;
  final String otherUid;
  final String otherName;
  final String otherEmail;
  final String? otherDpUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ConnectionEntity({
    required this.id,
    required this.fromUid,
    required this.toUid,
    required this.status,
    required this.otherUid,
    required this.otherName,
    required this.otherEmail,
    this.otherDpUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        fromUid,
        toUid,
        status,
        otherUid,
        otherName,
        otherEmail,
        otherDpUrl,
        createdAt,
        updatedAt,
      ];
}
