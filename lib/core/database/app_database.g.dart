// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CachedUsersTable extends CachedUsers
    with TableInfo<$CachedUsersTable, CachedUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedUsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
    'uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dpUrlMeta = const VerificationMeta('dpUrl');
  @override
  late final GeneratedColumn<String> dpUrl = GeneratedColumn<String>(
    'dp_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isOnlineMeta = const VerificationMeta(
    'isOnline',
  );
  @override
  late final GeneratedColumn<bool> isOnline = GeneratedColumn<bool>(
    'is_online',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_online" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastSeenMeta = const VerificationMeta(
    'lastSeen',
  );
  @override
  late final GeneratedColumn<DateTime> lastSeen = GeneratedColumn<DateTime>(
    'last_seen',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    uid,
    email,
    name,
    dpUrl,
    isOnline,
    lastSeen,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_users';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedUser> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
        _uidMeta,
        uid.isAcceptableOrUnknown(data['uid']!, _uidMeta),
      );
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('dp_url')) {
      context.handle(
        _dpUrlMeta,
        dpUrl.isAcceptableOrUnknown(data['dp_url']!, _dpUrlMeta),
      );
    }
    if (data.containsKey('is_online')) {
      context.handle(
        _isOnlineMeta,
        isOnline.isAcceptableOrUnknown(data['is_online']!, _isOnlineMeta),
      );
    }
    if (data.containsKey('last_seen')) {
      context.handle(
        _lastSeenMeta,
        lastSeen.isAcceptableOrUnknown(data['last_seen']!, _lastSeenMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  CachedUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedUser(
      uid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uid'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      dpUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dp_url'],
      ),
      isOnline: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_online'],
      )!,
      lastSeen: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_seen'],
      ),
    );
  }

  @override
  $CachedUsersTable createAlias(String alias) {
    return $CachedUsersTable(attachedDatabase, alias);
  }
}

class CachedUser extends DataClass implements Insertable<CachedUser> {
  final String uid;
  final String email;
  final String name;
  final String? dpUrl;
  final bool isOnline;
  final DateTime? lastSeen;
  const CachedUser({
    required this.uid,
    required this.email,
    required this.name,
    this.dpUrl,
    required this.isOnline,
    this.lastSeen,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    map['email'] = Variable<String>(email);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || dpUrl != null) {
      map['dp_url'] = Variable<String>(dpUrl);
    }
    map['is_online'] = Variable<bool>(isOnline);
    if (!nullToAbsent || lastSeen != null) {
      map['last_seen'] = Variable<DateTime>(lastSeen);
    }
    return map;
  }

  CachedUsersCompanion toCompanion(bool nullToAbsent) {
    return CachedUsersCompanion(
      uid: Value(uid),
      email: Value(email),
      name: Value(name),
      dpUrl: dpUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(dpUrl),
      isOnline: Value(isOnline),
      lastSeen: lastSeen == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSeen),
    );
  }

  factory CachedUser.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedUser(
      uid: serializer.fromJson<String>(json['uid']),
      email: serializer.fromJson<String>(json['email']),
      name: serializer.fromJson<String>(json['name']),
      dpUrl: serializer.fromJson<String?>(json['dpUrl']),
      isOnline: serializer.fromJson<bool>(json['isOnline']),
      lastSeen: serializer.fromJson<DateTime?>(json['lastSeen']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'email': serializer.toJson<String>(email),
      'name': serializer.toJson<String>(name),
      'dpUrl': serializer.toJson<String?>(dpUrl),
      'isOnline': serializer.toJson<bool>(isOnline),
      'lastSeen': serializer.toJson<DateTime?>(lastSeen),
    };
  }

  CachedUser copyWith({
    String? uid,
    String? email,
    String? name,
    Value<String?> dpUrl = const Value.absent(),
    bool? isOnline,
    Value<DateTime?> lastSeen = const Value.absent(),
  }) => CachedUser(
    uid: uid ?? this.uid,
    email: email ?? this.email,
    name: name ?? this.name,
    dpUrl: dpUrl.present ? dpUrl.value : this.dpUrl,
    isOnline: isOnline ?? this.isOnline,
    lastSeen: lastSeen.present ? lastSeen.value : this.lastSeen,
  );
  CachedUser copyWithCompanion(CachedUsersCompanion data) {
    return CachedUser(
      uid: data.uid.present ? data.uid.value : this.uid,
      email: data.email.present ? data.email.value : this.email,
      name: data.name.present ? data.name.value : this.name,
      dpUrl: data.dpUrl.present ? data.dpUrl.value : this.dpUrl,
      isOnline: data.isOnline.present ? data.isOnline.value : this.isOnline,
      lastSeen: data.lastSeen.present ? data.lastSeen.value : this.lastSeen,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedUser(')
          ..write('uid: $uid, ')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('dpUrl: $dpUrl, ')
          ..write('isOnline: $isOnline, ')
          ..write('lastSeen: $lastSeen')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uid, email, name, dpUrl, isOnline, lastSeen);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedUser &&
          other.uid == this.uid &&
          other.email == this.email &&
          other.name == this.name &&
          other.dpUrl == this.dpUrl &&
          other.isOnline == this.isOnline &&
          other.lastSeen == this.lastSeen);
}

class CachedUsersCompanion extends UpdateCompanion<CachedUser> {
  final Value<String> uid;
  final Value<String> email;
  final Value<String> name;
  final Value<String?> dpUrl;
  final Value<bool> isOnline;
  final Value<DateTime?> lastSeen;
  final Value<int> rowid;
  const CachedUsersCompanion({
    this.uid = const Value.absent(),
    this.email = const Value.absent(),
    this.name = const Value.absent(),
    this.dpUrl = const Value.absent(),
    this.isOnline = const Value.absent(),
    this.lastSeen = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedUsersCompanion.insert({
    required String uid,
    required String email,
    required String name,
    this.dpUrl = const Value.absent(),
    this.isOnline = const Value.absent(),
    this.lastSeen = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : uid = Value(uid),
       email = Value(email),
       name = Value(name);
  static Insertable<CachedUser> custom({
    Expression<String>? uid,
    Expression<String>? email,
    Expression<String>? name,
    Expression<String>? dpUrl,
    Expression<bool>? isOnline,
    Expression<DateTime>? lastSeen,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (email != null) 'email': email,
      if (name != null) 'name': name,
      if (dpUrl != null) 'dp_url': dpUrl,
      if (isOnline != null) 'is_online': isOnline,
      if (lastSeen != null) 'last_seen': lastSeen,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedUsersCompanion copyWith({
    Value<String>? uid,
    Value<String>? email,
    Value<String>? name,
    Value<String?>? dpUrl,
    Value<bool>? isOnline,
    Value<DateTime?>? lastSeen,
    Value<int>? rowid,
  }) {
    return CachedUsersCompanion(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      dpUrl: dpUrl ?? this.dpUrl,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dpUrl.present) {
      map['dp_url'] = Variable<String>(dpUrl.value);
    }
    if (isOnline.present) {
      map['is_online'] = Variable<bool>(isOnline.value);
    }
    if (lastSeen.present) {
      map['last_seen'] = Variable<DateTime>(lastSeen.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedUsersCompanion(')
          ..write('uid: $uid, ')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('dpUrl: $dpUrl, ')
          ..write('isOnline: $isOnline, ')
          ..write('lastSeen: $lastSeen, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedConnectionsTable extends CachedConnections
    with TableInfo<$CachedConnectionsTable, CachedConnection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedConnectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fromUidMeta = const VerificationMeta(
    'fromUid',
  );
  @override
  late final GeneratedColumn<String> fromUid = GeneratedColumn<String>(
    'from_uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toUidMeta = const VerificationMeta('toUid');
  @override
  late final GeneratedColumn<String> toUid = GeneratedColumn<String>(
    'to_uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _otherUidMeta = const VerificationMeta(
    'otherUid',
  );
  @override
  late final GeneratedColumn<String> otherUid = GeneratedColumn<String>(
    'other_uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _otherNameMeta = const VerificationMeta(
    'otherName',
  );
  @override
  late final GeneratedColumn<String> otherName = GeneratedColumn<String>(
    'other_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _otherEmailMeta = const VerificationMeta(
    'otherEmail',
  );
  @override
  late final GeneratedColumn<String> otherEmail = GeneratedColumn<String>(
    'other_email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _otherDpUrlMeta = const VerificationMeta(
    'otherDpUrl',
  );
  @override
  late final GeneratedColumn<String> otherDpUrl = GeneratedColumn<String>(
    'other_dp_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_connections';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedConnection> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('from_uid')) {
      context.handle(
        _fromUidMeta,
        fromUid.isAcceptableOrUnknown(data['from_uid']!, _fromUidMeta),
      );
    } else if (isInserting) {
      context.missing(_fromUidMeta);
    }
    if (data.containsKey('to_uid')) {
      context.handle(
        _toUidMeta,
        toUid.isAcceptableOrUnknown(data['to_uid']!, _toUidMeta),
      );
    } else if (isInserting) {
      context.missing(_toUidMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('other_uid')) {
      context.handle(
        _otherUidMeta,
        otherUid.isAcceptableOrUnknown(data['other_uid']!, _otherUidMeta),
      );
    } else if (isInserting) {
      context.missing(_otherUidMeta);
    }
    if (data.containsKey('other_name')) {
      context.handle(
        _otherNameMeta,
        otherName.isAcceptableOrUnknown(data['other_name']!, _otherNameMeta),
      );
    } else if (isInserting) {
      context.missing(_otherNameMeta);
    }
    if (data.containsKey('other_email')) {
      context.handle(
        _otherEmailMeta,
        otherEmail.isAcceptableOrUnknown(data['other_email']!, _otherEmailMeta),
      );
    } else if (isInserting) {
      context.missing(_otherEmailMeta);
    }
    if (data.containsKey('other_dp_url')) {
      context.handle(
        _otherDpUrlMeta,
        otherDpUrl.isAcceptableOrUnknown(
          data['other_dp_url']!,
          _otherDpUrlMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedConnection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedConnection(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fromUid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_uid'],
      )!,
      toUid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_uid'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      otherUid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}other_uid'],
      )!,
      otherName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}other_name'],
      )!,
      otherEmail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}other_email'],
      )!,
      otherDpUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}other_dp_url'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CachedConnectionsTable createAlias(String alias) {
    return $CachedConnectionsTable(attachedDatabase, alias);
  }
}

class CachedConnection extends DataClass
    implements Insertable<CachedConnection> {
  final String id;
  final String fromUid;
  final String toUid;
  final String status;
  final String otherUid;
  final String otherName;
  final String otherEmail;
  final String? otherDpUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CachedConnection({
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
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['from_uid'] = Variable<String>(fromUid);
    map['to_uid'] = Variable<String>(toUid);
    map['status'] = Variable<String>(status);
    map['other_uid'] = Variable<String>(otherUid);
    map['other_name'] = Variable<String>(otherName);
    map['other_email'] = Variable<String>(otherEmail);
    if (!nullToAbsent || otherDpUrl != null) {
      map['other_dp_url'] = Variable<String>(otherDpUrl);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CachedConnectionsCompanion toCompanion(bool nullToAbsent) {
    return CachedConnectionsCompanion(
      id: Value(id),
      fromUid: Value(fromUid),
      toUid: Value(toUid),
      status: Value(status),
      otherUid: Value(otherUid),
      otherName: Value(otherName),
      otherEmail: Value(otherEmail),
      otherDpUrl: otherDpUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(otherDpUrl),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CachedConnection.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedConnection(
      id: serializer.fromJson<String>(json['id']),
      fromUid: serializer.fromJson<String>(json['fromUid']),
      toUid: serializer.fromJson<String>(json['toUid']),
      status: serializer.fromJson<String>(json['status']),
      otherUid: serializer.fromJson<String>(json['otherUid']),
      otherName: serializer.fromJson<String>(json['otherName']),
      otherEmail: serializer.fromJson<String>(json['otherEmail']),
      otherDpUrl: serializer.fromJson<String?>(json['otherDpUrl']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fromUid': serializer.toJson<String>(fromUid),
      'toUid': serializer.toJson<String>(toUid),
      'status': serializer.toJson<String>(status),
      'otherUid': serializer.toJson<String>(otherUid),
      'otherName': serializer.toJson<String>(otherName),
      'otherEmail': serializer.toJson<String>(otherEmail),
      'otherDpUrl': serializer.toJson<String?>(otherDpUrl),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CachedConnection copyWith({
    String? id,
    String? fromUid,
    String? toUid,
    String? status,
    String? otherUid,
    String? otherName,
    String? otherEmail,
    Value<String?> otherDpUrl = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CachedConnection(
    id: id ?? this.id,
    fromUid: fromUid ?? this.fromUid,
    toUid: toUid ?? this.toUid,
    status: status ?? this.status,
    otherUid: otherUid ?? this.otherUid,
    otherName: otherName ?? this.otherName,
    otherEmail: otherEmail ?? this.otherEmail,
    otherDpUrl: otherDpUrl.present ? otherDpUrl.value : this.otherDpUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CachedConnection copyWithCompanion(CachedConnectionsCompanion data) {
    return CachedConnection(
      id: data.id.present ? data.id.value : this.id,
      fromUid: data.fromUid.present ? data.fromUid.value : this.fromUid,
      toUid: data.toUid.present ? data.toUid.value : this.toUid,
      status: data.status.present ? data.status.value : this.status,
      otherUid: data.otherUid.present ? data.otherUid.value : this.otherUid,
      otherName: data.otherName.present ? data.otherName.value : this.otherName,
      otherEmail: data.otherEmail.present
          ? data.otherEmail.value
          : this.otherEmail,
      otherDpUrl: data.otherDpUrl.present
          ? data.otherDpUrl.value
          : this.otherDpUrl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedConnection(')
          ..write('id: $id, ')
          ..write('fromUid: $fromUid, ')
          ..write('toUid: $toUid, ')
          ..write('status: $status, ')
          ..write('otherUid: $otherUid, ')
          ..write('otherName: $otherName, ')
          ..write('otherEmail: $otherEmail, ')
          ..write('otherDpUrl: $otherDpUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedConnection &&
          other.id == this.id &&
          other.fromUid == this.fromUid &&
          other.toUid == this.toUid &&
          other.status == this.status &&
          other.otherUid == this.otherUid &&
          other.otherName == this.otherName &&
          other.otherEmail == this.otherEmail &&
          other.otherDpUrl == this.otherDpUrl &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CachedConnectionsCompanion extends UpdateCompanion<CachedConnection> {
  final Value<String> id;
  final Value<String> fromUid;
  final Value<String> toUid;
  final Value<String> status;
  final Value<String> otherUid;
  final Value<String> otherName;
  final Value<String> otherEmail;
  final Value<String?> otherDpUrl;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CachedConnectionsCompanion({
    this.id = const Value.absent(),
    this.fromUid = const Value.absent(),
    this.toUid = const Value.absent(),
    this.status = const Value.absent(),
    this.otherUid = const Value.absent(),
    this.otherName = const Value.absent(),
    this.otherEmail = const Value.absent(),
    this.otherDpUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedConnectionsCompanion.insert({
    required String id,
    required String fromUid,
    required String toUid,
    required String status,
    required String otherUid,
    required String otherName,
    required String otherEmail,
    this.otherDpUrl = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fromUid = Value(fromUid),
       toUid = Value(toUid),
       status = Value(status),
       otherUid = Value(otherUid),
       otherName = Value(otherName),
       otherEmail = Value(otherEmail),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CachedConnection> custom({
    Expression<String>? id,
    Expression<String>? fromUid,
    Expression<String>? toUid,
    Expression<String>? status,
    Expression<String>? otherUid,
    Expression<String>? otherName,
    Expression<String>? otherEmail,
    Expression<String>? otherDpUrl,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fromUid != null) 'from_uid': fromUid,
      if (toUid != null) 'to_uid': toUid,
      if (status != null) 'status': status,
      if (otherUid != null) 'other_uid': otherUid,
      if (otherName != null) 'other_name': otherName,
      if (otherEmail != null) 'other_email': otherEmail,
      if (otherDpUrl != null) 'other_dp_url': otherDpUrl,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedConnectionsCompanion copyWith({
    Value<String>? id,
    Value<String>? fromUid,
    Value<String>? toUid,
    Value<String>? status,
    Value<String>? otherUid,
    Value<String>? otherName,
    Value<String>? otherEmail,
    Value<String?>? otherDpUrl,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CachedConnectionsCompanion(
      id: id ?? this.id,
      fromUid: fromUid ?? this.fromUid,
      toUid: toUid ?? this.toUid,
      status: status ?? this.status,
      otherUid: otherUid ?? this.otherUid,
      otherName: otherName ?? this.otherName,
      otherEmail: otherEmail ?? this.otherEmail,
      otherDpUrl: otherDpUrl ?? this.otherDpUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fromUid.present) {
      map['from_uid'] = Variable<String>(fromUid.value);
    }
    if (toUid.present) {
      map['to_uid'] = Variable<String>(toUid.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (otherUid.present) {
      map['other_uid'] = Variable<String>(otherUid.value);
    }
    if (otherName.present) {
      map['other_name'] = Variable<String>(otherName.value);
    }
    if (otherEmail.present) {
      map['other_email'] = Variable<String>(otherEmail.value);
    }
    if (otherDpUrl.present) {
      map['other_dp_url'] = Variable<String>(otherDpUrl.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedConnectionsCompanion(')
          ..write('id: $id, ')
          ..write('fromUid: $fromUid, ')
          ..write('toUid: $toUid, ')
          ..write('status: $status, ')
          ..write('otherUid: $otherUid, ')
          ..write('otherName: $otherName, ')
          ..write('otherEmail: $otherEmail, ')
          ..write('otherDpUrl: $otherDpUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedChatRoomsTable extends CachedChatRooms
    with TableInfo<$CachedChatRoomsTable, CachedChatRoom> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedChatRoomsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDirectMeta = const VerificationMeta(
    'isDirect',
  );
  @override
  late final GeneratedColumn<bool> isDirect = GeneratedColumn<bool>(
    'is_direct',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_direct" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _groupNameMeta = const VerificationMeta(
    'groupName',
  );
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
    'group_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _groupDpUrlMeta = const VerificationMeta(
    'groupDpUrl',
  );
  @override
  late final GeneratedColumn<String> groupDpUrl = GeneratedColumn<String>(
    'group_dp_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastMessageBodyMeta = const VerificationMeta(
    'lastMessageBody',
  );
  @override
  late final GeneratedColumn<String> lastMessageBody = GeneratedColumn<String>(
    'last_message_body',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastMessageAtMeta = const VerificationMeta(
    'lastMessageAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastMessageAt =
      GeneratedColumn<DateTime>(
        'last_message_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastSenderIdMeta = const VerificationMeta(
    'lastSenderId',
  );
  @override
  late final GeneratedColumn<String> lastSenderId = GeneratedColumn<String>(
    'last_sender_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unreadCountMeta = const VerificationMeta(
    'unreadCount',
  );
  @override
  late final GeneratedColumn<int> unreadCount = GeneratedColumn<int>(
    'unread_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _participantUidsMeta = const VerificationMeta(
    'participantUids',
  );
  @override
  late final GeneratedColumn<String> participantUids = GeneratedColumn<String>(
    'participant_uids',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _otherUserNameMeta = const VerificationMeta(
    'otherUserName',
  );
  @override
  late final GeneratedColumn<String> otherUserName = GeneratedColumn<String>(
    'other_user_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _otherUserDpUrlMeta = const VerificationMeta(
    'otherUserDpUrl',
  );
  @override
  late final GeneratedColumn<String> otherUserDpUrl = GeneratedColumn<String>(
    'other_user_dp_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    isDirect,
    groupName,
    groupDpUrl,
    lastMessageBody,
    lastMessageAt,
    lastSenderId,
    unreadCount,
    participantUids,
    otherUserName,
    otherUserDpUrl,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_chat_rooms';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedChatRoom> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('is_direct')) {
      context.handle(
        _isDirectMeta,
        isDirect.isAcceptableOrUnknown(data['is_direct']!, _isDirectMeta),
      );
    }
    if (data.containsKey('group_name')) {
      context.handle(
        _groupNameMeta,
        groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta),
      );
    }
    if (data.containsKey('group_dp_url')) {
      context.handle(
        _groupDpUrlMeta,
        groupDpUrl.isAcceptableOrUnknown(
          data['group_dp_url']!,
          _groupDpUrlMeta,
        ),
      );
    }
    if (data.containsKey('last_message_body')) {
      context.handle(
        _lastMessageBodyMeta,
        lastMessageBody.isAcceptableOrUnknown(
          data['last_message_body']!,
          _lastMessageBodyMeta,
        ),
      );
    }
    if (data.containsKey('last_message_at')) {
      context.handle(
        _lastMessageAtMeta,
        lastMessageAt.isAcceptableOrUnknown(
          data['last_message_at']!,
          _lastMessageAtMeta,
        ),
      );
    }
    if (data.containsKey('last_sender_id')) {
      context.handle(
        _lastSenderIdMeta,
        lastSenderId.isAcceptableOrUnknown(
          data['last_sender_id']!,
          _lastSenderIdMeta,
        ),
      );
    }
    if (data.containsKey('unread_count')) {
      context.handle(
        _unreadCountMeta,
        unreadCount.isAcceptableOrUnknown(
          data['unread_count']!,
          _unreadCountMeta,
        ),
      );
    }
    if (data.containsKey('participant_uids')) {
      context.handle(
        _participantUidsMeta,
        participantUids.isAcceptableOrUnknown(
          data['participant_uids']!,
          _participantUidsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_participantUidsMeta);
    }
    if (data.containsKey('other_user_name')) {
      context.handle(
        _otherUserNameMeta,
        otherUserName.isAcceptableOrUnknown(
          data['other_user_name']!,
          _otherUserNameMeta,
        ),
      );
    }
    if (data.containsKey('other_user_dp_url')) {
      context.handle(
        _otherUserDpUrlMeta,
        otherUserDpUrl.isAcceptableOrUnknown(
          data['other_user_dp_url']!,
          _otherUserDpUrlMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedChatRoom map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedChatRoom(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      isDirect: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_direct'],
      )!,
      groupName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_name'],
      ),
      groupDpUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_dp_url'],
      ),
      lastMessageBody: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message_body'],
      ),
      lastMessageAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_message_at'],
      ),
      lastSenderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_sender_id'],
      ),
      unreadCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unread_count'],
      )!,
      participantUids: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}participant_uids'],
      )!,
      otherUserName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}other_user_name'],
      ),
      otherUserDpUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}other_user_dp_url'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CachedChatRoomsTable createAlias(String alias) {
    return $CachedChatRoomsTable(attachedDatabase, alias);
  }
}

class CachedChatRoom extends DataClass implements Insertable<CachedChatRoom> {
  final String id;
  final bool isDirect;
  final String? groupName;
  final String? groupDpUrl;
  final String? lastMessageBody;
  final DateTime? lastMessageAt;
  final String? lastSenderId;
  final int unreadCount;
  final String participantUids;
  final String? otherUserName;
  final String? otherUserDpUrl;
  final DateTime createdAt;
  const CachedChatRoom({
    required this.id,
    required this.isDirect,
    this.groupName,
    this.groupDpUrl,
    this.lastMessageBody,
    this.lastMessageAt,
    this.lastSenderId,
    required this.unreadCount,
    required this.participantUids,
    this.otherUserName,
    this.otherUserDpUrl,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['is_direct'] = Variable<bool>(isDirect);
    if (!nullToAbsent || groupName != null) {
      map['group_name'] = Variable<String>(groupName);
    }
    if (!nullToAbsent || groupDpUrl != null) {
      map['group_dp_url'] = Variable<String>(groupDpUrl);
    }
    if (!nullToAbsent || lastMessageBody != null) {
      map['last_message_body'] = Variable<String>(lastMessageBody);
    }
    if (!nullToAbsent || lastMessageAt != null) {
      map['last_message_at'] = Variable<DateTime>(lastMessageAt);
    }
    if (!nullToAbsent || lastSenderId != null) {
      map['last_sender_id'] = Variable<String>(lastSenderId);
    }
    map['unread_count'] = Variable<int>(unreadCount);
    map['participant_uids'] = Variable<String>(participantUids);
    if (!nullToAbsent || otherUserName != null) {
      map['other_user_name'] = Variable<String>(otherUserName);
    }
    if (!nullToAbsent || otherUserDpUrl != null) {
      map['other_user_dp_url'] = Variable<String>(otherUserDpUrl);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CachedChatRoomsCompanion toCompanion(bool nullToAbsent) {
    return CachedChatRoomsCompanion(
      id: Value(id),
      isDirect: Value(isDirect),
      groupName: groupName == null && nullToAbsent
          ? const Value.absent()
          : Value(groupName),
      groupDpUrl: groupDpUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(groupDpUrl),
      lastMessageBody: lastMessageBody == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageBody),
      lastMessageAt: lastMessageAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageAt),
      lastSenderId: lastSenderId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSenderId),
      unreadCount: Value(unreadCount),
      participantUids: Value(participantUids),
      otherUserName: otherUserName == null && nullToAbsent
          ? const Value.absent()
          : Value(otherUserName),
      otherUserDpUrl: otherUserDpUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(otherUserDpUrl),
      createdAt: Value(createdAt),
    );
  }

  factory CachedChatRoom.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedChatRoom(
      id: serializer.fromJson<String>(json['id']),
      isDirect: serializer.fromJson<bool>(json['isDirect']),
      groupName: serializer.fromJson<String?>(json['groupName']),
      groupDpUrl: serializer.fromJson<String?>(json['groupDpUrl']),
      lastMessageBody: serializer.fromJson<String?>(json['lastMessageBody']),
      lastMessageAt: serializer.fromJson<DateTime?>(json['lastMessageAt']),
      lastSenderId: serializer.fromJson<String?>(json['lastSenderId']),
      unreadCount: serializer.fromJson<int>(json['unreadCount']),
      participantUids: serializer.fromJson<String>(json['participantUids']),
      otherUserName: serializer.fromJson<String?>(json['otherUserName']),
      otherUserDpUrl: serializer.fromJson<String?>(json['otherUserDpUrl']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'isDirect': serializer.toJson<bool>(isDirect),
      'groupName': serializer.toJson<String?>(groupName),
      'groupDpUrl': serializer.toJson<String?>(groupDpUrl),
      'lastMessageBody': serializer.toJson<String?>(lastMessageBody),
      'lastMessageAt': serializer.toJson<DateTime?>(lastMessageAt),
      'lastSenderId': serializer.toJson<String?>(lastSenderId),
      'unreadCount': serializer.toJson<int>(unreadCount),
      'participantUids': serializer.toJson<String>(participantUids),
      'otherUserName': serializer.toJson<String?>(otherUserName),
      'otherUserDpUrl': serializer.toJson<String?>(otherUserDpUrl),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CachedChatRoom copyWith({
    String? id,
    bool? isDirect,
    Value<String?> groupName = const Value.absent(),
    Value<String?> groupDpUrl = const Value.absent(),
    Value<String?> lastMessageBody = const Value.absent(),
    Value<DateTime?> lastMessageAt = const Value.absent(),
    Value<String?> lastSenderId = const Value.absent(),
    int? unreadCount,
    String? participantUids,
    Value<String?> otherUserName = const Value.absent(),
    Value<String?> otherUserDpUrl = const Value.absent(),
    DateTime? createdAt,
  }) => CachedChatRoom(
    id: id ?? this.id,
    isDirect: isDirect ?? this.isDirect,
    groupName: groupName.present ? groupName.value : this.groupName,
    groupDpUrl: groupDpUrl.present ? groupDpUrl.value : this.groupDpUrl,
    lastMessageBody: lastMessageBody.present
        ? lastMessageBody.value
        : this.lastMessageBody,
    lastMessageAt: lastMessageAt.present
        ? lastMessageAt.value
        : this.lastMessageAt,
    lastSenderId: lastSenderId.present ? lastSenderId.value : this.lastSenderId,
    unreadCount: unreadCount ?? this.unreadCount,
    participantUids: participantUids ?? this.participantUids,
    otherUserName: otherUserName.present
        ? otherUserName.value
        : this.otherUserName,
    otherUserDpUrl: otherUserDpUrl.present
        ? otherUserDpUrl.value
        : this.otherUserDpUrl,
    createdAt: createdAt ?? this.createdAt,
  );
  CachedChatRoom copyWithCompanion(CachedChatRoomsCompanion data) {
    return CachedChatRoom(
      id: data.id.present ? data.id.value : this.id,
      isDirect: data.isDirect.present ? data.isDirect.value : this.isDirect,
      groupName: data.groupName.present ? data.groupName.value : this.groupName,
      groupDpUrl: data.groupDpUrl.present
          ? data.groupDpUrl.value
          : this.groupDpUrl,
      lastMessageBody: data.lastMessageBody.present
          ? data.lastMessageBody.value
          : this.lastMessageBody,
      lastMessageAt: data.lastMessageAt.present
          ? data.lastMessageAt.value
          : this.lastMessageAt,
      lastSenderId: data.lastSenderId.present
          ? data.lastSenderId.value
          : this.lastSenderId,
      unreadCount: data.unreadCount.present
          ? data.unreadCount.value
          : this.unreadCount,
      participantUids: data.participantUids.present
          ? data.participantUids.value
          : this.participantUids,
      otherUserName: data.otherUserName.present
          ? data.otherUserName.value
          : this.otherUserName,
      otherUserDpUrl: data.otherUserDpUrl.present
          ? data.otherUserDpUrl.value
          : this.otherUserDpUrl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedChatRoom(')
          ..write('id: $id, ')
          ..write('isDirect: $isDirect, ')
          ..write('groupName: $groupName, ')
          ..write('groupDpUrl: $groupDpUrl, ')
          ..write('lastMessageBody: $lastMessageBody, ')
          ..write('lastMessageAt: $lastMessageAt, ')
          ..write('lastSenderId: $lastSenderId, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('participantUids: $participantUids, ')
          ..write('otherUserName: $otherUserName, ')
          ..write('otherUserDpUrl: $otherUserDpUrl, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    isDirect,
    groupName,
    groupDpUrl,
    lastMessageBody,
    lastMessageAt,
    lastSenderId,
    unreadCount,
    participantUids,
    otherUserName,
    otherUserDpUrl,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedChatRoom &&
          other.id == this.id &&
          other.isDirect == this.isDirect &&
          other.groupName == this.groupName &&
          other.groupDpUrl == this.groupDpUrl &&
          other.lastMessageBody == this.lastMessageBody &&
          other.lastMessageAt == this.lastMessageAt &&
          other.lastSenderId == this.lastSenderId &&
          other.unreadCount == this.unreadCount &&
          other.participantUids == this.participantUids &&
          other.otherUserName == this.otherUserName &&
          other.otherUserDpUrl == this.otherUserDpUrl &&
          other.createdAt == this.createdAt);
}

class CachedChatRoomsCompanion extends UpdateCompanion<CachedChatRoom> {
  final Value<String> id;
  final Value<bool> isDirect;
  final Value<String?> groupName;
  final Value<String?> groupDpUrl;
  final Value<String?> lastMessageBody;
  final Value<DateTime?> lastMessageAt;
  final Value<String?> lastSenderId;
  final Value<int> unreadCount;
  final Value<String> participantUids;
  final Value<String?> otherUserName;
  final Value<String?> otherUserDpUrl;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CachedChatRoomsCompanion({
    this.id = const Value.absent(),
    this.isDirect = const Value.absent(),
    this.groupName = const Value.absent(),
    this.groupDpUrl = const Value.absent(),
    this.lastMessageBody = const Value.absent(),
    this.lastMessageAt = const Value.absent(),
    this.lastSenderId = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.participantUids = const Value.absent(),
    this.otherUserName = const Value.absent(),
    this.otherUserDpUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedChatRoomsCompanion.insert({
    required String id,
    this.isDirect = const Value.absent(),
    this.groupName = const Value.absent(),
    this.groupDpUrl = const Value.absent(),
    this.lastMessageBody = const Value.absent(),
    this.lastMessageAt = const Value.absent(),
    this.lastSenderId = const Value.absent(),
    this.unreadCount = const Value.absent(),
    required String participantUids,
    this.otherUserName = const Value.absent(),
    this.otherUserDpUrl = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       participantUids = Value(participantUids),
       createdAt = Value(createdAt);
  static Insertable<CachedChatRoom> custom({
    Expression<String>? id,
    Expression<bool>? isDirect,
    Expression<String>? groupName,
    Expression<String>? groupDpUrl,
    Expression<String>? lastMessageBody,
    Expression<DateTime>? lastMessageAt,
    Expression<String>? lastSenderId,
    Expression<int>? unreadCount,
    Expression<String>? participantUids,
    Expression<String>? otherUserName,
    Expression<String>? otherUserDpUrl,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isDirect != null) 'is_direct': isDirect,
      if (groupName != null) 'group_name': groupName,
      if (groupDpUrl != null) 'group_dp_url': groupDpUrl,
      if (lastMessageBody != null) 'last_message_body': lastMessageBody,
      if (lastMessageAt != null) 'last_message_at': lastMessageAt,
      if (lastSenderId != null) 'last_sender_id': lastSenderId,
      if (unreadCount != null) 'unread_count': unreadCount,
      if (participantUids != null) 'participant_uids': participantUids,
      if (otherUserName != null) 'other_user_name': otherUserName,
      if (otherUserDpUrl != null) 'other_user_dp_url': otherUserDpUrl,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedChatRoomsCompanion copyWith({
    Value<String>? id,
    Value<bool>? isDirect,
    Value<String?>? groupName,
    Value<String?>? groupDpUrl,
    Value<String?>? lastMessageBody,
    Value<DateTime?>? lastMessageAt,
    Value<String?>? lastSenderId,
    Value<int>? unreadCount,
    Value<String>? participantUids,
    Value<String?>? otherUserName,
    Value<String?>? otherUserDpUrl,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return CachedChatRoomsCompanion(
      id: id ?? this.id,
      isDirect: isDirect ?? this.isDirect,
      groupName: groupName ?? this.groupName,
      groupDpUrl: groupDpUrl ?? this.groupDpUrl,
      lastMessageBody: lastMessageBody ?? this.lastMessageBody,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      lastSenderId: lastSenderId ?? this.lastSenderId,
      unreadCount: unreadCount ?? this.unreadCount,
      participantUids: participantUids ?? this.participantUids,
      otherUserName: otherUserName ?? this.otherUserName,
      otherUserDpUrl: otherUserDpUrl ?? this.otherUserDpUrl,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (isDirect.present) {
      map['is_direct'] = Variable<bool>(isDirect.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (groupDpUrl.present) {
      map['group_dp_url'] = Variable<String>(groupDpUrl.value);
    }
    if (lastMessageBody.present) {
      map['last_message_body'] = Variable<String>(lastMessageBody.value);
    }
    if (lastMessageAt.present) {
      map['last_message_at'] = Variable<DateTime>(lastMessageAt.value);
    }
    if (lastSenderId.present) {
      map['last_sender_id'] = Variable<String>(lastSenderId.value);
    }
    if (unreadCount.present) {
      map['unread_count'] = Variable<int>(unreadCount.value);
    }
    if (participantUids.present) {
      map['participant_uids'] = Variable<String>(participantUids.value);
    }
    if (otherUserName.present) {
      map['other_user_name'] = Variable<String>(otherUserName.value);
    }
    if (otherUserDpUrl.present) {
      map['other_user_dp_url'] = Variable<String>(otherUserDpUrl.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedChatRoomsCompanion(')
          ..write('id: $id, ')
          ..write('isDirect: $isDirect, ')
          ..write('groupName: $groupName, ')
          ..write('groupDpUrl: $groupDpUrl, ')
          ..write('lastMessageBody: $lastMessageBody, ')
          ..write('lastMessageAt: $lastMessageAt, ')
          ..write('lastSenderId: $lastSenderId, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('participantUids: $participantUids, ')
          ..write('otherUserName: $otherUserName, ')
          ..write('otherUserDpUrl: $otherUserDpUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedMessagesTable extends CachedMessages
    with TableInfo<$CachedMessagesTable, CachedMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientMessageIdMeta = const VerificationMeta(
    'clientMessageId',
  );
  @override
  late final GeneratedColumn<String> clientMessageId = GeneratedColumn<String>(
    'client_message_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverMessageIdMeta = const VerificationMeta(
    'serverMessageId',
  );
  @override
  late final GeneratedColumn<String> serverMessageId = GeneratedColumn<String>(
    'server_message_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chatRoomIdMeta = const VerificationMeta(
    'chatRoomId',
  );
  @override
  late final GeneratedColumn<String> chatRoomId = GeneratedColumn<String>(
    'chat_room_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderIdMeta = const VerificationMeta(
    'senderId',
  );
  @override
  late final GeneratedColumn<String> senderId = GeneratedColumn<String>(
    'sender_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderNameMeta = const VerificationMeta(
    'senderName',
  );
  @override
  late final GeneratedColumn<String> senderName = GeneratedColumn<String>(
    'sender_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sentAtMeta = const VerificationMeta('sentAt');
  @override
  late final GeneratedColumn<DateTime> sentAt = GeneratedColumn<DateTime>(
    'sent_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('sent'),
  );
  static const VerificationMeta _isMeMeta = const VerificationMeta('isMe');
  @override
  late final GeneratedColumn<bool> isMe = GeneratedColumn<bool>(
    'is_me',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_me" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientMessageId,
    serverMessageId,
    chatRoomId,
    senderId,
    senderName,
    body,
    sentAt,
    status,
    isMe,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedMessage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('client_message_id')) {
      context.handle(
        _clientMessageIdMeta,
        clientMessageId.isAcceptableOrUnknown(
          data['client_message_id']!,
          _clientMessageIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_clientMessageIdMeta);
    }
    if (data.containsKey('server_message_id')) {
      context.handle(
        _serverMessageIdMeta,
        serverMessageId.isAcceptableOrUnknown(
          data['server_message_id']!,
          _serverMessageIdMeta,
        ),
      );
    }
    if (data.containsKey('chat_room_id')) {
      context.handle(
        _chatRoomIdMeta,
        chatRoomId.isAcceptableOrUnknown(
          data['chat_room_id']!,
          _chatRoomIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_chatRoomIdMeta);
    }
    if (data.containsKey('sender_id')) {
      context.handle(
        _senderIdMeta,
        senderId.isAcceptableOrUnknown(data['sender_id']!, _senderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_senderIdMeta);
    }
    if (data.containsKey('sender_name')) {
      context.handle(
        _senderNameMeta,
        senderName.isAcceptableOrUnknown(data['sender_name']!, _senderNameMeta),
      );
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('sent_at')) {
      context.handle(
        _sentAtMeta,
        sentAt.isAcceptableOrUnknown(data['sent_at']!, _sentAtMeta),
      );
    } else if (isInserting) {
      context.missing(_sentAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('is_me')) {
      context.handle(
        _isMeMeta,
        isMe.isAcceptableOrUnknown(data['is_me']!, _isMeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedMessage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      clientMessageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_message_id'],
      )!,
      serverMessageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_message_id'],
      ),
      chatRoomId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chat_room_id'],
      )!,
      senderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_id'],
      )!,
      senderName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_name'],
      ),
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      sentAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sent_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      isMe: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_me'],
      )!,
    );
  }

  @override
  $CachedMessagesTable createAlias(String alias) {
    return $CachedMessagesTable(attachedDatabase, alias);
  }
}

class CachedMessage extends DataClass implements Insertable<CachedMessage> {
  final String id;
  final String clientMessageId;
  final String? serverMessageId;
  final String chatRoomId;
  final String senderId;
  final String? senderName;
  final String body;
  final DateTime sentAt;
  final String status;
  final bool isMe;
  const CachedMessage({
    required this.id,
    required this.clientMessageId,
    this.serverMessageId,
    required this.chatRoomId,
    required this.senderId,
    this.senderName,
    required this.body,
    required this.sentAt,
    required this.status,
    required this.isMe,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['client_message_id'] = Variable<String>(clientMessageId);
    if (!nullToAbsent || serverMessageId != null) {
      map['server_message_id'] = Variable<String>(serverMessageId);
    }
    map['chat_room_id'] = Variable<String>(chatRoomId);
    map['sender_id'] = Variable<String>(senderId);
    if (!nullToAbsent || senderName != null) {
      map['sender_name'] = Variable<String>(senderName);
    }
    map['body'] = Variable<String>(body);
    map['sent_at'] = Variable<DateTime>(sentAt);
    map['status'] = Variable<String>(status);
    map['is_me'] = Variable<bool>(isMe);
    return map;
  }

  CachedMessagesCompanion toCompanion(bool nullToAbsent) {
    return CachedMessagesCompanion(
      id: Value(id),
      clientMessageId: Value(clientMessageId),
      serverMessageId: serverMessageId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverMessageId),
      chatRoomId: Value(chatRoomId),
      senderId: Value(senderId),
      senderName: senderName == null && nullToAbsent
          ? const Value.absent()
          : Value(senderName),
      body: Value(body),
      sentAt: Value(sentAt),
      status: Value(status),
      isMe: Value(isMe),
    );
  }

  factory CachedMessage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedMessage(
      id: serializer.fromJson<String>(json['id']),
      clientMessageId: serializer.fromJson<String>(json['clientMessageId']),
      serverMessageId: serializer.fromJson<String?>(json['serverMessageId']),
      chatRoomId: serializer.fromJson<String>(json['chatRoomId']),
      senderId: serializer.fromJson<String>(json['senderId']),
      senderName: serializer.fromJson<String?>(json['senderName']),
      body: serializer.fromJson<String>(json['body']),
      sentAt: serializer.fromJson<DateTime>(json['sentAt']),
      status: serializer.fromJson<String>(json['status']),
      isMe: serializer.fromJson<bool>(json['isMe']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clientMessageId': serializer.toJson<String>(clientMessageId),
      'serverMessageId': serializer.toJson<String?>(serverMessageId),
      'chatRoomId': serializer.toJson<String>(chatRoomId),
      'senderId': serializer.toJson<String>(senderId),
      'senderName': serializer.toJson<String?>(senderName),
      'body': serializer.toJson<String>(body),
      'sentAt': serializer.toJson<DateTime>(sentAt),
      'status': serializer.toJson<String>(status),
      'isMe': serializer.toJson<bool>(isMe),
    };
  }

  CachedMessage copyWith({
    String? id,
    String? clientMessageId,
    Value<String?> serverMessageId = const Value.absent(),
    String? chatRoomId,
    String? senderId,
    Value<String?> senderName = const Value.absent(),
    String? body,
    DateTime? sentAt,
    String? status,
    bool? isMe,
  }) => CachedMessage(
    id: id ?? this.id,
    clientMessageId: clientMessageId ?? this.clientMessageId,
    serverMessageId: serverMessageId.present
        ? serverMessageId.value
        : this.serverMessageId,
    chatRoomId: chatRoomId ?? this.chatRoomId,
    senderId: senderId ?? this.senderId,
    senderName: senderName.present ? senderName.value : this.senderName,
    body: body ?? this.body,
    sentAt: sentAt ?? this.sentAt,
    status: status ?? this.status,
    isMe: isMe ?? this.isMe,
  );
  CachedMessage copyWithCompanion(CachedMessagesCompanion data) {
    return CachedMessage(
      id: data.id.present ? data.id.value : this.id,
      clientMessageId: data.clientMessageId.present
          ? data.clientMessageId.value
          : this.clientMessageId,
      serverMessageId: data.serverMessageId.present
          ? data.serverMessageId.value
          : this.serverMessageId,
      chatRoomId: data.chatRoomId.present
          ? data.chatRoomId.value
          : this.chatRoomId,
      senderId: data.senderId.present ? data.senderId.value : this.senderId,
      senderName: data.senderName.present
          ? data.senderName.value
          : this.senderName,
      body: data.body.present ? data.body.value : this.body,
      sentAt: data.sentAt.present ? data.sentAt.value : this.sentAt,
      status: data.status.present ? data.status.value : this.status,
      isMe: data.isMe.present ? data.isMe.value : this.isMe,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedMessage(')
          ..write('id: $id, ')
          ..write('clientMessageId: $clientMessageId, ')
          ..write('serverMessageId: $serverMessageId, ')
          ..write('chatRoomId: $chatRoomId, ')
          ..write('senderId: $senderId, ')
          ..write('senderName: $senderName, ')
          ..write('body: $body, ')
          ..write('sentAt: $sentAt, ')
          ..write('status: $status, ')
          ..write('isMe: $isMe')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientMessageId,
    serverMessageId,
    chatRoomId,
    senderId,
    senderName,
    body,
    sentAt,
    status,
    isMe,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedMessage &&
          other.id == this.id &&
          other.clientMessageId == this.clientMessageId &&
          other.serverMessageId == this.serverMessageId &&
          other.chatRoomId == this.chatRoomId &&
          other.senderId == this.senderId &&
          other.senderName == this.senderName &&
          other.body == this.body &&
          other.sentAt == this.sentAt &&
          other.status == this.status &&
          other.isMe == this.isMe);
}

class CachedMessagesCompanion extends UpdateCompanion<CachedMessage> {
  final Value<String> id;
  final Value<String> clientMessageId;
  final Value<String?> serverMessageId;
  final Value<String> chatRoomId;
  final Value<String> senderId;
  final Value<String?> senderName;
  final Value<String> body;
  final Value<DateTime> sentAt;
  final Value<String> status;
  final Value<bool> isMe;
  final Value<int> rowid;
  const CachedMessagesCompanion({
    this.id = const Value.absent(),
    this.clientMessageId = const Value.absent(),
    this.serverMessageId = const Value.absent(),
    this.chatRoomId = const Value.absent(),
    this.senderId = const Value.absent(),
    this.senderName = const Value.absent(),
    this.body = const Value.absent(),
    this.sentAt = const Value.absent(),
    this.status = const Value.absent(),
    this.isMe = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedMessagesCompanion.insert({
    required String id,
    required String clientMessageId,
    this.serverMessageId = const Value.absent(),
    required String chatRoomId,
    required String senderId,
    this.senderName = const Value.absent(),
    required String body,
    required DateTime sentAt,
    this.status = const Value.absent(),
    this.isMe = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       clientMessageId = Value(clientMessageId),
       chatRoomId = Value(chatRoomId),
       senderId = Value(senderId),
       body = Value(body),
       sentAt = Value(sentAt);
  static Insertable<CachedMessage> custom({
    Expression<String>? id,
    Expression<String>? clientMessageId,
    Expression<String>? serverMessageId,
    Expression<String>? chatRoomId,
    Expression<String>? senderId,
    Expression<String>? senderName,
    Expression<String>? body,
    Expression<DateTime>? sentAt,
    Expression<String>? status,
    Expression<bool>? isMe,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientMessageId != null) 'client_message_id': clientMessageId,
      if (serverMessageId != null) 'server_message_id': serverMessageId,
      if (chatRoomId != null) 'chat_room_id': chatRoomId,
      if (senderId != null) 'sender_id': senderId,
      if (senderName != null) 'sender_name': senderName,
      if (body != null) 'body': body,
      if (sentAt != null) 'sent_at': sentAt,
      if (status != null) 'status': status,
      if (isMe != null) 'is_me': isMe,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedMessagesCompanion copyWith({
    Value<String>? id,
    Value<String>? clientMessageId,
    Value<String?>? serverMessageId,
    Value<String>? chatRoomId,
    Value<String>? senderId,
    Value<String?>? senderName,
    Value<String>? body,
    Value<DateTime>? sentAt,
    Value<String>? status,
    Value<bool>? isMe,
    Value<int>? rowid,
  }) {
    return CachedMessagesCompanion(
      id: id ?? this.id,
      clientMessageId: clientMessageId ?? this.clientMessageId,
      serverMessageId: serverMessageId ?? this.serverMessageId,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      body: body ?? this.body,
      sentAt: sentAt ?? this.sentAt,
      status: status ?? this.status,
      isMe: isMe ?? this.isMe,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clientMessageId.present) {
      map['client_message_id'] = Variable<String>(clientMessageId.value);
    }
    if (serverMessageId.present) {
      map['server_message_id'] = Variable<String>(serverMessageId.value);
    }
    if (chatRoomId.present) {
      map['chat_room_id'] = Variable<String>(chatRoomId.value);
    }
    if (senderId.present) {
      map['sender_id'] = Variable<String>(senderId.value);
    }
    if (senderName.present) {
      map['sender_name'] = Variable<String>(senderName.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (sentAt.present) {
      map['sent_at'] = Variable<DateTime>(sentAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (isMe.present) {
      map['is_me'] = Variable<bool>(isMe.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedMessagesCompanion(')
          ..write('id: $id, ')
          ..write('clientMessageId: $clientMessageId, ')
          ..write('serverMessageId: $serverMessageId, ')
          ..write('chatRoomId: $chatRoomId, ')
          ..write('senderId: $senderId, ')
          ..write('senderName: $senderName, ')
          ..write('body: $body, ')
          ..write('sentAt: $sentAt, ')
          ..write('status: $status, ')
          ..write('isMe: $isMe, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PendingMessagesTable extends PendingMessages
    with TableInfo<$PendingMessagesTable, PendingMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _clientMessageIdMeta = const VerificationMeta(
    'clientMessageId',
  );
  @override
  late final GeneratedColumn<String> clientMessageId = GeneratedColumn<String>(
    'client_message_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _chatRoomIdMeta = const VerificationMeta(
    'chatRoomId',
  );
  @override
  late final GeneratedColumn<String> chatRoomId = GeneratedColumn<String>(
    'chat_room_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientMessageId,
    chatRoomId,
    body,
    createdAt,
    status,
    retryCount,
    lastError,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<PendingMessage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_message_id')) {
      context.handle(
        _clientMessageIdMeta,
        clientMessageId.isAcceptableOrUnknown(
          data['client_message_id']!,
          _clientMessageIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_clientMessageIdMeta);
    }
    if (data.containsKey('chat_room_id')) {
      context.handle(
        _chatRoomIdMeta,
        chatRoomId.isAcceptableOrUnknown(
          data['chat_room_id']!,
          _chatRoomIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_chatRoomIdMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PendingMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingMessage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      clientMessageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_message_id'],
      )!,
      chatRoomId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chat_room_id'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
    );
  }

  @override
  $PendingMessagesTable createAlias(String alias) {
    return $PendingMessagesTable(attachedDatabase, alias);
  }
}

class PendingMessage extends DataClass implements Insertable<PendingMessage> {
  final int id;
  final String clientMessageId;
  final String chatRoomId;
  final String body;
  final DateTime createdAt;
  final String status;
  final int retryCount;
  final String? lastError;
  const PendingMessage({
    required this.id,
    required this.clientMessageId,
    required this.chatRoomId,
    required this.body,
    required this.createdAt,
    required this.status,
    required this.retryCount,
    this.lastError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_message_id'] = Variable<String>(clientMessageId);
    map['chat_room_id'] = Variable<String>(chatRoomId);
    map['body'] = Variable<String>(body);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['status'] = Variable<String>(status);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  PendingMessagesCompanion toCompanion(bool nullToAbsent) {
    return PendingMessagesCompanion(
      id: Value(id),
      clientMessageId: Value(clientMessageId),
      chatRoomId: Value(chatRoomId),
      body: Value(body),
      createdAt: Value(createdAt),
      status: Value(status),
      retryCount: Value(retryCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory PendingMessage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingMessage(
      id: serializer.fromJson<int>(json['id']),
      clientMessageId: serializer.fromJson<String>(json['clientMessageId']),
      chatRoomId: serializer.fromJson<String>(json['chatRoomId']),
      body: serializer.fromJson<String>(json['body']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      status: serializer.fromJson<String>(json['status']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientMessageId': serializer.toJson<String>(clientMessageId),
      'chatRoomId': serializer.toJson<String>(chatRoomId),
      'body': serializer.toJson<String>(body),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'status': serializer.toJson<String>(status),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  PendingMessage copyWith({
    int? id,
    String? clientMessageId,
    String? chatRoomId,
    String? body,
    DateTime? createdAt,
    String? status,
    int? retryCount,
    Value<String?> lastError = const Value.absent(),
  }) => PendingMessage(
    id: id ?? this.id,
    clientMessageId: clientMessageId ?? this.clientMessageId,
    chatRoomId: chatRoomId ?? this.chatRoomId,
    body: body ?? this.body,
    createdAt: createdAt ?? this.createdAt,
    status: status ?? this.status,
    retryCount: retryCount ?? this.retryCount,
    lastError: lastError.present ? lastError.value : this.lastError,
  );
  PendingMessage copyWithCompanion(PendingMessagesCompanion data) {
    return PendingMessage(
      id: data.id.present ? data.id.value : this.id,
      clientMessageId: data.clientMessageId.present
          ? data.clientMessageId.value
          : this.clientMessageId,
      chatRoomId: data.chatRoomId.present
          ? data.chatRoomId.value
          : this.chatRoomId,
      body: data.body.present ? data.body.value : this.body,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      status: data.status.present ? data.status.value : this.status,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingMessage(')
          ..write('id: $id, ')
          ..write('clientMessageId: $clientMessageId, ')
          ..write('chatRoomId: $chatRoomId, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientMessageId,
    chatRoomId,
    body,
    createdAt,
    status,
    retryCount,
    lastError,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingMessage &&
          other.id == this.id &&
          other.clientMessageId == this.clientMessageId &&
          other.chatRoomId == this.chatRoomId &&
          other.body == this.body &&
          other.createdAt == this.createdAt &&
          other.status == this.status &&
          other.retryCount == this.retryCount &&
          other.lastError == this.lastError);
}

class PendingMessagesCompanion extends UpdateCompanion<PendingMessage> {
  final Value<int> id;
  final Value<String> clientMessageId;
  final Value<String> chatRoomId;
  final Value<String> body;
  final Value<DateTime> createdAt;
  final Value<String> status;
  final Value<int> retryCount;
  final Value<String?> lastError;
  const PendingMessagesCompanion({
    this.id = const Value.absent(),
    this.clientMessageId = const Value.absent(),
    this.chatRoomId = const Value.absent(),
    this.body = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
  });
  PendingMessagesCompanion.insert({
    this.id = const Value.absent(),
    required String clientMessageId,
    required String chatRoomId,
    required String body,
    required DateTime createdAt,
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
  }) : clientMessageId = Value(clientMessageId),
       chatRoomId = Value(chatRoomId),
       body = Value(body),
       createdAt = Value(createdAt);
  static Insertable<PendingMessage> custom({
    Expression<int>? id,
    Expression<String>? clientMessageId,
    Expression<String>? chatRoomId,
    Expression<String>? body,
    Expression<DateTime>? createdAt,
    Expression<String>? status,
    Expression<int>? retryCount,
    Expression<String>? lastError,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientMessageId != null) 'client_message_id': clientMessageId,
      if (chatRoomId != null) 'chat_room_id': chatRoomId,
      if (body != null) 'body': body,
      if (createdAt != null) 'created_at': createdAt,
      if (status != null) 'status': status,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastError != null) 'last_error': lastError,
    });
  }

  PendingMessagesCompanion copyWith({
    Value<int>? id,
    Value<String>? clientMessageId,
    Value<String>? chatRoomId,
    Value<String>? body,
    Value<DateTime>? createdAt,
    Value<String>? status,
    Value<int>? retryCount,
    Value<String?>? lastError,
  }) {
    return PendingMessagesCompanion(
      id: id ?? this.id,
      clientMessageId: clientMessageId ?? this.clientMessageId,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientMessageId.present) {
      map['client_message_id'] = Variable<String>(clientMessageId.value);
    }
    if (chatRoomId.present) {
      map['chat_room_id'] = Variable<String>(chatRoomId.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingMessagesCompanion(')
          ..write('id: $id, ')
          ..write('clientMessageId: $clientMessageId, ')
          ..write('chatRoomId: $chatRoomId, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CachedUsersTable cachedUsers = $CachedUsersTable(this);
  late final $CachedConnectionsTable cachedConnections =
      $CachedConnectionsTable(this);
  late final $CachedChatRoomsTable cachedChatRooms = $CachedChatRoomsTable(
    this,
  );
  late final $CachedMessagesTable cachedMessages = $CachedMessagesTable(this);
  late final $PendingMessagesTable pendingMessages = $PendingMessagesTable(
    this,
  );
  late final MessageDao messageDao = MessageDao(this as AppDatabase);
  late final ChatRoomDao chatRoomDao = ChatRoomDao(this as AppDatabase);
  late final ConnectionDao connectionDao = ConnectionDao(this as AppDatabase);
  late final UserCacheDao userCacheDao = UserCacheDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cachedUsers,
    cachedConnections,
    cachedChatRooms,
    cachedMessages,
    pendingMessages,
  ];
}

typedef $$CachedUsersTableCreateCompanionBuilder =
    CachedUsersCompanion Function({
      required String uid,
      required String email,
      required String name,
      Value<String?> dpUrl,
      Value<bool> isOnline,
      Value<DateTime?> lastSeen,
      Value<int> rowid,
    });
typedef $$CachedUsersTableUpdateCompanionBuilder =
    CachedUsersCompanion Function({
      Value<String> uid,
      Value<String> email,
      Value<String> name,
      Value<String?> dpUrl,
      Value<bool> isOnline,
      Value<DateTime?> lastSeen,
      Value<int> rowid,
    });

class $$CachedUsersTableFilterComposer
    extends Composer<_$AppDatabase, $CachedUsersTable> {
  $$CachedUsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dpUrl => $composableBuilder(
    column: $table.dpUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOnline => $composableBuilder(
    column: $table.isOnline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSeen => $composableBuilder(
    column: $table.lastSeen,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedUsersTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedUsersTable> {
  $$CachedUsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dpUrl => $composableBuilder(
    column: $table.dpUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOnline => $composableBuilder(
    column: $table.isOnline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSeen => $composableBuilder(
    column: $table.lastSeen,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedUsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedUsersTable> {
  $$CachedUsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get dpUrl =>
      $composableBuilder(column: $table.dpUrl, builder: (column) => column);

  GeneratedColumn<bool> get isOnline =>
      $composableBuilder(column: $table.isOnline, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSeen =>
      $composableBuilder(column: $table.lastSeen, builder: (column) => column);
}

class $$CachedUsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedUsersTable,
          CachedUser,
          $$CachedUsersTableFilterComposer,
          $$CachedUsersTableOrderingComposer,
          $$CachedUsersTableAnnotationComposer,
          $$CachedUsersTableCreateCompanionBuilder,
          $$CachedUsersTableUpdateCompanionBuilder,
          (
            CachedUser,
            BaseReferences<_$AppDatabase, $CachedUsersTable, CachedUser>,
          ),
          CachedUser,
          PrefetchHooks Function()
        > {
  $$CachedUsersTableTableManager(_$AppDatabase db, $CachedUsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedUsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedUsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedUsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> uid = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> dpUrl = const Value.absent(),
                Value<bool> isOnline = const Value.absent(),
                Value<DateTime?> lastSeen = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedUsersCompanion(
                uid: uid,
                email: email,
                name: name,
                dpUrl: dpUrl,
                isOnline: isOnline,
                lastSeen: lastSeen,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uid,
                required String email,
                required String name,
                Value<String?> dpUrl = const Value.absent(),
                Value<bool> isOnline = const Value.absent(),
                Value<DateTime?> lastSeen = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedUsersCompanion.insert(
                uid: uid,
                email: email,
                name: name,
                dpUrl: dpUrl,
                isOnline: isOnline,
                lastSeen: lastSeen,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CachedUsersTable, CachedUser>(table),
                  BaseReferences<_$AppDatabase, $CachedUsersTable, CachedUser>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedUsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedUsersTable,
      CachedUser,
      $$CachedUsersTableFilterComposer,
      $$CachedUsersTableOrderingComposer,
      $$CachedUsersTableAnnotationComposer,
      $$CachedUsersTableCreateCompanionBuilder,
      $$CachedUsersTableUpdateCompanionBuilder,
      (
        CachedUser,
        BaseReferences<_$AppDatabase, $CachedUsersTable, CachedUser>,
      ),
      CachedUser,
      PrefetchHooks Function()
    >;
typedef $$CachedConnectionsTableCreateCompanionBuilder =
    CachedConnectionsCompanion Function({
      required String id,
      required String fromUid,
      required String toUid,
      required String status,
      required String otherUid,
      required String otherName,
      required String otherEmail,
      Value<String?> otherDpUrl,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CachedConnectionsTableUpdateCompanionBuilder =
    CachedConnectionsCompanion Function({
      Value<String> id,
      Value<String> fromUid,
      Value<String> toUid,
      Value<String> status,
      Value<String> otherUid,
      Value<String> otherName,
      Value<String> otherEmail,
      Value<String?> otherDpUrl,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$CachedConnectionsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedConnectionsTable> {
  $$CachedConnectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fromUid => $composableBuilder(
    column: $table.fromUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toUid => $composableBuilder(
    column: $table.toUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get otherUid => $composableBuilder(
    column: $table.otherUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get otherName => $composableBuilder(
    column: $table.otherName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get otherEmail => $composableBuilder(
    column: $table.otherEmail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get otherDpUrl => $composableBuilder(
    column: $table.otherDpUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedConnectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedConnectionsTable> {
  $$CachedConnectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fromUid => $composableBuilder(
    column: $table.fromUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toUid => $composableBuilder(
    column: $table.toUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get otherUid => $composableBuilder(
    column: $table.otherUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get otherName => $composableBuilder(
    column: $table.otherName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get otherEmail => $composableBuilder(
    column: $table.otherEmail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get otherDpUrl => $composableBuilder(
    column: $table.otherDpUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedConnectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedConnectionsTable> {
  $$CachedConnectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fromUid =>
      $composableBuilder(column: $table.fromUid, builder: (column) => column);

  GeneratedColumn<String> get toUid =>
      $composableBuilder(column: $table.toUid, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get otherUid =>
      $composableBuilder(column: $table.otherUid, builder: (column) => column);

  GeneratedColumn<String> get otherName =>
      $composableBuilder(column: $table.otherName, builder: (column) => column);

  GeneratedColumn<String> get otherEmail => $composableBuilder(
    column: $table.otherEmail,
    builder: (column) => column,
  );

  GeneratedColumn<String> get otherDpUrl => $composableBuilder(
    column: $table.otherDpUrl,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CachedConnectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedConnectionsTable,
          CachedConnection,
          $$CachedConnectionsTableFilterComposer,
          $$CachedConnectionsTableOrderingComposer,
          $$CachedConnectionsTableAnnotationComposer,
          $$CachedConnectionsTableCreateCompanionBuilder,
          $$CachedConnectionsTableUpdateCompanionBuilder,
          (
            CachedConnection,
            BaseReferences<
              _$AppDatabase,
              $CachedConnectionsTable,
              CachedConnection
            >,
          ),
          CachedConnection,
          PrefetchHooks Function()
        > {
  $$CachedConnectionsTableTableManager(
    _$AppDatabase db,
    $CachedConnectionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedConnectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedConnectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedConnectionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fromUid = const Value.absent(),
                Value<String> toUid = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> otherUid = const Value.absent(),
                Value<String> otherName = const Value.absent(),
                Value<String> otherEmail = const Value.absent(),
                Value<String?> otherDpUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedConnectionsCompanion(
                id: id,
                fromUid: fromUid,
                toUid: toUid,
                status: status,
                otherUid: otherUid,
                otherName: otherName,
                otherEmail: otherEmail,
                otherDpUrl: otherDpUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String fromUid,
                required String toUid,
                required String status,
                required String otherUid,
                required String otherName,
                required String otherEmail,
                Value<String?> otherDpUrl = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedConnectionsCompanion.insert(
                id: id,
                fromUid: fromUid,
                toUid: toUid,
                status: status,
                otherUid: otherUid,
                otherName: otherName,
                otherEmail: otherEmail,
                otherDpUrl: otherDpUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CachedConnectionsTable, CachedConnection>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CachedConnectionsTable,
                    CachedConnection
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedConnectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedConnectionsTable,
      CachedConnection,
      $$CachedConnectionsTableFilterComposer,
      $$CachedConnectionsTableOrderingComposer,
      $$CachedConnectionsTableAnnotationComposer,
      $$CachedConnectionsTableCreateCompanionBuilder,
      $$CachedConnectionsTableUpdateCompanionBuilder,
      (
        CachedConnection,
        BaseReferences<
          _$AppDatabase,
          $CachedConnectionsTable,
          CachedConnection
        >,
      ),
      CachedConnection,
      PrefetchHooks Function()
    >;
typedef $$CachedChatRoomsTableCreateCompanionBuilder =
    CachedChatRoomsCompanion Function({
      required String id,
      Value<bool> isDirect,
      Value<String?> groupName,
      Value<String?> groupDpUrl,
      Value<String?> lastMessageBody,
      Value<DateTime?> lastMessageAt,
      Value<String?> lastSenderId,
      Value<int> unreadCount,
      required String participantUids,
      Value<String?> otherUserName,
      Value<String?> otherUserDpUrl,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$CachedChatRoomsTableUpdateCompanionBuilder =
    CachedChatRoomsCompanion Function({
      Value<String> id,
      Value<bool> isDirect,
      Value<String?> groupName,
      Value<String?> groupDpUrl,
      Value<String?> lastMessageBody,
      Value<DateTime?> lastMessageAt,
      Value<String?> lastSenderId,
      Value<int> unreadCount,
      Value<String> participantUids,
      Value<String?> otherUserName,
      Value<String?> otherUserDpUrl,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$CachedChatRoomsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedChatRoomsTable> {
  $$CachedChatRoomsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDirect => $composableBuilder(
    column: $table.isDirect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupDpUrl => $composableBuilder(
    column: $table.groupDpUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessageBody => $composableBuilder(
    column: $table.lastMessageBody,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSenderId => $composableBuilder(
    column: $table.lastSenderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get participantUids => $composableBuilder(
    column: $table.participantUids,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get otherUserName => $composableBuilder(
    column: $table.otherUserName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get otherUserDpUrl => $composableBuilder(
    column: $table.otherUserDpUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedChatRoomsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedChatRoomsTable> {
  $$CachedChatRoomsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDirect => $composableBuilder(
    column: $table.isDirect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupDpUrl => $composableBuilder(
    column: $table.groupDpUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessageBody => $composableBuilder(
    column: $table.lastMessageBody,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSenderId => $composableBuilder(
    column: $table.lastSenderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get participantUids => $composableBuilder(
    column: $table.participantUids,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get otherUserName => $composableBuilder(
    column: $table.otherUserName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get otherUserDpUrl => $composableBuilder(
    column: $table.otherUserDpUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedChatRoomsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedChatRoomsTable> {
  $$CachedChatRoomsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isDirect =>
      $composableBuilder(column: $table.isDirect, builder: (column) => column);

  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);

  GeneratedColumn<String> get groupDpUrl => $composableBuilder(
    column: $table.groupDpUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastMessageBody => $composableBuilder(
    column: $table.lastMessageBody,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSenderId => $composableBuilder(
    column: $table.lastSenderId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get participantUids => $composableBuilder(
    column: $table.participantUids,
    builder: (column) => column,
  );

  GeneratedColumn<String> get otherUserName => $composableBuilder(
    column: $table.otherUserName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get otherUserDpUrl => $composableBuilder(
    column: $table.otherUserDpUrl,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CachedChatRoomsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedChatRoomsTable,
          CachedChatRoom,
          $$CachedChatRoomsTableFilterComposer,
          $$CachedChatRoomsTableOrderingComposer,
          $$CachedChatRoomsTableAnnotationComposer,
          $$CachedChatRoomsTableCreateCompanionBuilder,
          $$CachedChatRoomsTableUpdateCompanionBuilder,
          (
            CachedChatRoom,
            BaseReferences<
              _$AppDatabase,
              $CachedChatRoomsTable,
              CachedChatRoom
            >,
          ),
          CachedChatRoom,
          PrefetchHooks Function()
        > {
  $$CachedChatRoomsTableTableManager(
    _$AppDatabase db,
    $CachedChatRoomsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedChatRoomsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedChatRoomsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedChatRoomsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<bool> isDirect = const Value.absent(),
                Value<String?> groupName = const Value.absent(),
                Value<String?> groupDpUrl = const Value.absent(),
                Value<String?> lastMessageBody = const Value.absent(),
                Value<DateTime?> lastMessageAt = const Value.absent(),
                Value<String?> lastSenderId = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<String> participantUids = const Value.absent(),
                Value<String?> otherUserName = const Value.absent(),
                Value<String?> otherUserDpUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedChatRoomsCompanion(
                id: id,
                isDirect: isDirect,
                groupName: groupName,
                groupDpUrl: groupDpUrl,
                lastMessageBody: lastMessageBody,
                lastMessageAt: lastMessageAt,
                lastSenderId: lastSenderId,
                unreadCount: unreadCount,
                participantUids: participantUids,
                otherUserName: otherUserName,
                otherUserDpUrl: otherUserDpUrl,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<bool> isDirect = const Value.absent(),
                Value<String?> groupName = const Value.absent(),
                Value<String?> groupDpUrl = const Value.absent(),
                Value<String?> lastMessageBody = const Value.absent(),
                Value<DateTime?> lastMessageAt = const Value.absent(),
                Value<String?> lastSenderId = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                required String participantUids,
                Value<String?> otherUserName = const Value.absent(),
                Value<String?> otherUserDpUrl = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedChatRoomsCompanion.insert(
                id: id,
                isDirect: isDirect,
                groupName: groupName,
                groupDpUrl: groupDpUrl,
                lastMessageBody: lastMessageBody,
                lastMessageAt: lastMessageAt,
                lastSenderId: lastSenderId,
                unreadCount: unreadCount,
                participantUids: participantUids,
                otherUserName: otherUserName,
                otherUserDpUrl: otherUserDpUrl,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CachedChatRoomsTable, CachedChatRoom>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CachedChatRoomsTable,
                    CachedChatRoom
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedChatRoomsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedChatRoomsTable,
      CachedChatRoom,
      $$CachedChatRoomsTableFilterComposer,
      $$CachedChatRoomsTableOrderingComposer,
      $$CachedChatRoomsTableAnnotationComposer,
      $$CachedChatRoomsTableCreateCompanionBuilder,
      $$CachedChatRoomsTableUpdateCompanionBuilder,
      (
        CachedChatRoom,
        BaseReferences<_$AppDatabase, $CachedChatRoomsTable, CachedChatRoom>,
      ),
      CachedChatRoom,
      PrefetchHooks Function()
    >;
typedef $$CachedMessagesTableCreateCompanionBuilder =
    CachedMessagesCompanion Function({
      required String id,
      required String clientMessageId,
      Value<String?> serverMessageId,
      required String chatRoomId,
      required String senderId,
      Value<String?> senderName,
      required String body,
      required DateTime sentAt,
      Value<String> status,
      Value<bool> isMe,
      Value<int> rowid,
    });
typedef $$CachedMessagesTableUpdateCompanionBuilder =
    CachedMessagesCompanion Function({
      Value<String> id,
      Value<String> clientMessageId,
      Value<String?> serverMessageId,
      Value<String> chatRoomId,
      Value<String> senderId,
      Value<String?> senderName,
      Value<String> body,
      Value<DateTime> sentAt,
      Value<String> status,
      Value<bool> isMe,
      Value<int> rowid,
    });

class $$CachedMessagesTableFilterComposer
    extends Composer<_$AppDatabase, $CachedMessagesTable> {
  $$CachedMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientMessageId => $composableBuilder(
    column: $table.clientMessageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverMessageId => $composableBuilder(
    column: $table.serverMessageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chatRoomId => $composableBuilder(
    column: $table.chatRoomId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderName => $composableBuilder(
    column: $table.senderName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMe => $composableBuilder(
    column: $table.isMe,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedMessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedMessagesTable> {
  $$CachedMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientMessageId => $composableBuilder(
    column: $table.clientMessageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverMessageId => $composableBuilder(
    column: $table.serverMessageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chatRoomId => $composableBuilder(
    column: $table.chatRoomId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderName => $composableBuilder(
    column: $table.senderName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMe => $composableBuilder(
    column: $table.isMe,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedMessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedMessagesTable> {
  $$CachedMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clientMessageId => $composableBuilder(
    column: $table.clientMessageId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serverMessageId => $composableBuilder(
    column: $table.serverMessageId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get chatRoomId => $composableBuilder(
    column: $table.chatRoomId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get senderId =>
      $composableBuilder(column: $table.senderId, builder: (column) => column);

  GeneratedColumn<String> get senderName => $composableBuilder(
    column: $table.senderName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<DateTime> get sentAt =>
      $composableBuilder(column: $table.sentAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get isMe =>
      $composableBuilder(column: $table.isMe, builder: (column) => column);
}

class $$CachedMessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedMessagesTable,
          CachedMessage,
          $$CachedMessagesTableFilterComposer,
          $$CachedMessagesTableOrderingComposer,
          $$CachedMessagesTableAnnotationComposer,
          $$CachedMessagesTableCreateCompanionBuilder,
          $$CachedMessagesTableUpdateCompanionBuilder,
          (
            CachedMessage,
            BaseReferences<_$AppDatabase, $CachedMessagesTable, CachedMessage>,
          ),
          CachedMessage,
          PrefetchHooks Function()
        > {
  $$CachedMessagesTableTableManager(
    _$AppDatabase db,
    $CachedMessagesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> clientMessageId = const Value.absent(),
                Value<String?> serverMessageId = const Value.absent(),
                Value<String> chatRoomId = const Value.absent(),
                Value<String> senderId = const Value.absent(),
                Value<String?> senderName = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<DateTime> sentAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<bool> isMe = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedMessagesCompanion(
                id: id,
                clientMessageId: clientMessageId,
                serverMessageId: serverMessageId,
                chatRoomId: chatRoomId,
                senderId: senderId,
                senderName: senderName,
                body: body,
                sentAt: sentAt,
                status: status,
                isMe: isMe,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String clientMessageId,
                Value<String?> serverMessageId = const Value.absent(),
                required String chatRoomId,
                required String senderId,
                Value<String?> senderName = const Value.absent(),
                required String body,
                required DateTime sentAt,
                Value<String> status = const Value.absent(),
                Value<bool> isMe = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedMessagesCompanion.insert(
                id: id,
                clientMessageId: clientMessageId,
                serverMessageId: serverMessageId,
                chatRoomId: chatRoomId,
                senderId: senderId,
                senderName: senderName,
                body: body,
                sentAt: sentAt,
                status: status,
                isMe: isMe,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CachedMessagesTable, CachedMessage>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CachedMessagesTable,
                    CachedMessage
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedMessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedMessagesTable,
      CachedMessage,
      $$CachedMessagesTableFilterComposer,
      $$CachedMessagesTableOrderingComposer,
      $$CachedMessagesTableAnnotationComposer,
      $$CachedMessagesTableCreateCompanionBuilder,
      $$CachedMessagesTableUpdateCompanionBuilder,
      (
        CachedMessage,
        BaseReferences<_$AppDatabase, $CachedMessagesTable, CachedMessage>,
      ),
      CachedMessage,
      PrefetchHooks Function()
    >;
typedef $$PendingMessagesTableCreateCompanionBuilder =
    PendingMessagesCompanion Function({
      Value<int> id,
      required String clientMessageId,
      required String chatRoomId,
      required String body,
      required DateTime createdAt,
      Value<String> status,
      Value<int> retryCount,
      Value<String?> lastError,
    });
typedef $$PendingMessagesTableUpdateCompanionBuilder =
    PendingMessagesCompanion Function({
      Value<int> id,
      Value<String> clientMessageId,
      Value<String> chatRoomId,
      Value<String> body,
      Value<DateTime> createdAt,
      Value<String> status,
      Value<int> retryCount,
      Value<String?> lastError,
    });

class $$PendingMessagesTableFilterComposer
    extends Composer<_$AppDatabase, $PendingMessagesTable> {
  $$PendingMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientMessageId => $composableBuilder(
    column: $table.clientMessageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chatRoomId => $composableBuilder(
    column: $table.chatRoomId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PendingMessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $PendingMessagesTable> {
  $$PendingMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientMessageId => $composableBuilder(
    column: $table.clientMessageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chatRoomId => $composableBuilder(
    column: $table.chatRoomId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PendingMessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PendingMessagesTable> {
  $$PendingMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clientMessageId => $composableBuilder(
    column: $table.clientMessageId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get chatRoomId => $composableBuilder(
    column: $table.chatRoomId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$PendingMessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PendingMessagesTable,
          PendingMessage,
          $$PendingMessagesTableFilterComposer,
          $$PendingMessagesTableOrderingComposer,
          $$PendingMessagesTableAnnotationComposer,
          $$PendingMessagesTableCreateCompanionBuilder,
          $$PendingMessagesTableUpdateCompanionBuilder,
          (
            PendingMessage,
            BaseReferences<
              _$AppDatabase,
              $PendingMessagesTable,
              PendingMessage
            >,
          ),
          PendingMessage,
          PrefetchHooks Function()
        > {
  $$PendingMessagesTableTableManager(
    _$AppDatabase db,
    $PendingMessagesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PendingMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PendingMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PendingMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> clientMessageId = const Value.absent(),
                Value<String> chatRoomId = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
              }) => PendingMessagesCompanion(
                id: id,
                clientMessageId: clientMessageId,
                chatRoomId: chatRoomId,
                body: body,
                createdAt: createdAt,
                status: status,
                retryCount: retryCount,
                lastError: lastError,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String clientMessageId,
                required String chatRoomId,
                required String body,
                required DateTime createdAt,
                Value<String> status = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
              }) => PendingMessagesCompanion.insert(
                id: id,
                clientMessageId: clientMessageId,
                chatRoomId: chatRoomId,
                body: body,
                createdAt: createdAt,
                status: status,
                retryCount: retryCount,
                lastError: lastError,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PendingMessagesTable, PendingMessage>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PendingMessagesTable,
                    PendingMessage
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PendingMessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PendingMessagesTable,
      PendingMessage,
      $$PendingMessagesTableFilterComposer,
      $$PendingMessagesTableOrderingComposer,
      $$PendingMessagesTableAnnotationComposer,
      $$PendingMessagesTableCreateCompanionBuilder,
      $$PendingMessagesTableUpdateCompanionBuilder,
      (
        PendingMessage,
        BaseReferences<_$AppDatabase, $PendingMessagesTable, PendingMessage>,
      ),
      PendingMessage,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CachedUsersTableTableManager get cachedUsers =>
      $$CachedUsersTableTableManager(_db, _db.cachedUsers);
  $$CachedConnectionsTableTableManager get cachedConnections =>
      $$CachedConnectionsTableTableManager(_db, _db.cachedConnections);
  $$CachedChatRoomsTableTableManager get cachedChatRooms =>
      $$CachedChatRoomsTableTableManager(_db, _db.cachedChatRooms);
  $$CachedMessagesTableTableManager get cachedMessages =>
      $$CachedMessagesTableTableManager(_db, _db.cachedMessages);
  $$PendingMessagesTableTableManager get pendingMessages =>
      $$PendingMessagesTableTableManager(_db, _db.pendingMessages);
}
