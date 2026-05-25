import 'package:flutter_test/flutter_test.dart';
import 'package:sushi_garden_flutter/features/auth/auth_controller.dart';

void main() {
  group('login', () {
    test('cannot log in with an invalid email', () {
      final controller = AuthController()
        ..email = 'nope'
        ..password = 'secret';
      expect(controller.canLogin, isFalse);
    });

    test('cannot log in with an empty password', () {
      final controller = AuthController()
        ..email = 'anovikov@gmail.com'
        ..password = '';
      expect(controller.canLogin, isFalse);
    });

    test('can log in with a valid email and password', () {
      final controller = AuthController()
        ..email = 'anovikov@gmail.com'
        ..password = 'secret';
      expect(controller.canLogin, isTrue);
    });
  });

  group('register', () {
    AuthController filled() => AuthController()
      ..name = 'Александр'
      ..email = 'anovikov@gmail.com'
      ..password = 'secret'
      ..acceptedTerms = true;

    test('cannot register without accepting terms', () {
      final controller = filled()..acceptedTerms = false;
      expect(controller.canRegister, isFalse);
    });

    test('cannot register without a name', () {
      final controller = filled()..name = '  ';
      expect(controller.canRegister, isFalse);
    });

    test('cannot register with an invalid email', () {
      final controller = filled()..email = 'bad';
      expect(controller.canRegister, isFalse);
    });

    test('can register when all fields are valid and terms accepted', () {
      expect(filled().canRegister, isTrue);
    });
  });
}
