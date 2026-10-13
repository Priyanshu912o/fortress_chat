import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:Fortress/core/network/api_client.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MockFirebaseAuth extends Fake implements FirebaseAuth {
  @override
  User? get currentUser => null;
}

void main() {
  group('ApiClient and Connection Accept Body Payload Tests', () {
    test('ApiClient patch defaults null data to empty map to prevent empty JSON body error', () async {
      final dio = Dio();
      // Intercept request to inspect options.data
      dynamic capturedData;
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            capturedData = options.data;
            return handler.resolve(
              Response(
                requestOptions: options,
                statusCode: 200,
                data: {'chatRoomId': 'room_abc'},
              ),
            );
          },
        ),
      );

      final client = ApiClient(dio, MockFirebaseAuth());
      final res = await client.patch<Map<String, dynamic>>('/api/connections/123/accept');

      expect(res.statusCode, 200);
      expect(capturedData, isNotNull);
      expect(capturedData, isA<Map>());
      expect((capturedData as Map).isEmpty, true);
    });

    test('ApiClient post defaults null data to empty map', () async {
      final dio = Dio();
      dynamic capturedData;
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            capturedData = options.data;
            return handler.resolve(
              Response(
                requestOptions: options,
                statusCode: 200,
                data: {'status': 'ok'},
              ),
            );
          },
        ),
      );

      final client = ApiClient(dio, MockFirebaseAuth());
      final res = await client.post<Map<String, dynamic>>('/api/test');

      expect(res.statusCode, 200);
      expect(capturedData, isNotNull);
      expect(capturedData, isA<Map>());
      expect((capturedData as Map).isEmpty, true);
    });
  });
}
