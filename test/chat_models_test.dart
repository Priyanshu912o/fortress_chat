import 'package:flutter_test/flutter_test.dart';
import 'package:Fortress/features/conversations/data/models/chat_room_model.dart';
import 'package:Fortress/features/messaging/data/models/message_model.dart';
import 'package:Fortress/features/people/data/models/connection_model.dart';
import 'package:Fortress/features/people/data/models/contact_profile_model.dart';
import 'package:Fortress/features/people/domain/entities/connection_status.dart';

void main() {
  group('Fortress Chat Models & Serialization Tests', () {
    test('ContactProfileModel fromJson correctly parses user data', () {
      final json = {
        'uid': 'user_123',
        'email': 'alice@fortress.chat',
        'name': 'Alice Smith',
        'dpUrl': 'https://fortress.chat/alice.png',
        'isOnline': true,
        'lastSeen': '2026-09-13T10:00:00.000Z',
      };

      final profile = ContactProfileModel.fromJson(json);

      expect(profile.uid, 'user_123');
      expect(profile.email, 'alice@fortress.chat');
      expect(profile.name, 'Alice Smith');
      expect(profile.isOnline, true);
      expect(profile.lastSeen, isNotNull);
    });

    test('ConnectionModel fromJson resolves otherUser correctly', () {
      final json = {
        'id': 'conn_456',
        'fromUid': 'user_me',
        'toUid': 'user_bob',
        'status': 'ACCEPTED',
        'createdAt': '2026-09-13T09:00:00.000Z',
        'updatedAt': '2026-09-13T09:05:00.000Z',
        'fromUser': {'uid': 'user_me', 'name': 'Me', 'email': 'me@test.com'},
        'toUser': {'uid': 'user_bob', 'name': 'Bob', 'email': 'bob@test.com'},
      };

      final conn = ConnectionModel.fromJson(json, currentUid: 'user_me');

      expect(conn.id, 'conn_456');
      expect(conn.status, ConnectionStatus.accepted);
      expect(conn.otherUid, 'user_bob');
      expect(conn.otherName, 'Bob');
      expect(conn.otherEmail, 'bob@test.com');
    });

    test('ChatRoomModel parses direct and group rooms correctly', () {
      final json = {
        'id': 'room_789',
        'isDirect': true,
        'createdAt': '2026-09-13T08:00:00.000Z',
        'lastMessageBody': 'Hey there, how are you?',
        'lastMessageAt': '2026-09-13T08:30:00.000Z',
        'lastSenderId': 'user_bob',
        'unreadCount': 2,
        'participants': [
          {
            'uid': 'user_me',
            'role': 'MEMBER',
            'user': {'name': 'Me', 'email': 'me@test.com'},
          },
          {
            'uid': 'user_bob',
            'role': 'MEMBER',
            'user': {'name': 'Bob', 'email': 'bob@test.com'},
          },
        ],
      };

      final room = ChatRoomModel.fromJson(json, currentUid: 'user_me');

      expect(room.chatRoomId, 'room_789');
      expect(room.isDirect, true);
      expect(room.otherUserName, 'Bob');
      expect(room.displayName, 'Bob');
      expect(room.lastMessageBody, 'Hey there, how are you?');
      expect(room.unreadCount, 2);
    });

    test('MessageModel parses receipts and distinguishes sender', () {
      final json = {
        'id': 'msg_001',
        'clientMessageId': 'client_uuid_1',
        'chatRoomId': 'room_789',
        'senderId': 'user_me',
        'body': 'Hello, Fortress!',
        'sentAt': '2026-09-13T08:29:00.000Z',
        'sender': {'name': 'Me'},
        'receipts': [
          {'uid': 'user_bob', 'deliveredAt': '2026-09-13T08:29:05.000Z'}
        ],
      };

      final message = MessageModel.fromJson(json, currentUid: 'user_me');

      expect(message.messageId, 'msg_001');
      expect(message.clientMessageId, 'client_uuid_1');
      expect(message.isMe, true);
      expect(message.body, 'Hello, Fortress!');
      expect(message.status, 'delivered');
    });
  });
}
