import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:zoned/data/remote/users_service.dart';

import 'users_service_test.mocks.dart';

@GenerateMocks([UsersService])
void main() {
  group('UserService', () {
    UsersService service = MockUsersService();

    test('get all menu returns data', () async {
      when(service.listUsers()).thenAnswer((_) async => {});

      var menus = await service.listUsers();
      expect(menus, {});
    });
  });
}
