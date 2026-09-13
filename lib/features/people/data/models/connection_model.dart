import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/entities/connection_entity.dart';
import '../../domain/entities/connection_status.dart';

class ConnectionModel extends ConnectionEntity {
  const ConnectionModel({
    required super.id,
    required super.fromUid,
    required super.toUid,
    required super.status,
    required super.otherUid,
    required super.otherName,
    required super.otherEmail,
    super.otherDpUrl,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ConnectionModel.fromJson(Map<String, dynamic> json, {String? currentUid}) {
    final fromUid = json['fromUid'] as String;
    final toUid = json['toUid'] as String;

    final fromUser = json['fromUser'] as Map<String, dynamic>?;
    final toUser = json['toUser'] as Map<String, dynamic>?;

    final isOutgoing = fromUid == currentUid;
    final otherUser = isOutgoing ? toUser : fromUser;
    final otherUid = isOutgoing ? toUid : fromUid;

    return ConnectionModel(
      id: json['id'] as String,
      fromUid: fromUid,
      toUid: toUid,
      status: ConnectionStatus.fromString(json['status'] as String? ?? 'PENDING'),
      otherUid: otherUid,
      otherName: otherUser?['name'] as String? ?? 'Contact',
      otherEmail: otherUser?['email'] as String? ?? '',
      otherDpUrl: otherUser?['dpUrl'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
    );
  }

  factory ConnectionModel.fromDrift(CachedConnection row) {
    return ConnectionModel(
      id: row.id,
      fromUid: row.fromUid,
      toUid: row.toUid,
      status: ConnectionStatus.fromString(row.status),
      otherUid: row.otherUid,
      otherName: row.otherName,
      otherEmail: row.otherEmail,
      otherDpUrl: row.otherDpUrl,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  CachedConnectionsCompanion toDrift() {
    return CachedConnectionsCompanion(
      id: Value(id),
      fromUid: Value(fromUid),
      toUid: Value(toUid),
      status: Value(status.toDbString()),
      otherUid: Value(otherUid),
      otherName: Value(otherName),
      otherEmail: Value(otherEmail),
      otherDpUrl: Value(otherDpUrl),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}
