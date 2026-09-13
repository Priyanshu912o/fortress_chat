import '../../domain/entities/contact_profile_entity.dart';

class ContactProfileModel extends ContactProfileEntity {
  const ContactProfileModel({
    required super.uid,
    required super.email,
    required super.name,
    super.dpUrl,
    super.isOnline = false,
    super.lastSeen,
  });

  factory ContactProfileModel.fromJson(Map<String, dynamic> json) {
    return ContactProfileModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] as String? ?? 'User',
      dpUrl: json['dpUrl'] as String?,
      isOnline: json['isOnline'] as bool? ?? false,
      lastSeen: json['lastSeen'] != null
          ? DateTime.tryParse(json['lastSeen'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'dpUrl': dpUrl,
      'isOnline': isOnline,
      'lastSeen': lastSeen?.toIso8601String(),
    };
  }
}
