import 'package:faker/faker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/infra/cache/cache.dart';

class FlutterSecureStorageSpy extends Mock implements FlutterSecureStorage {}

void main() {
  late LocalStorageAdapter sut;
  late FlutterSecureStorageSpy secureStorage;
  late String key;
  late String value;

  setUp(() {
    secureStorage = FlutterSecureStorageSpy();
    sut = LocalStorageAdapter(secureStorage: secureStorage);
    key = faker.lorem.word();
    value = faker.guid.guid();
  });

  group('saveSecure', () {
    void mockSaveSecureError() {
      when(secureStorage.write(key: key, value: value)).thenThrow(Exception());
    }

    test('Should call save secure with correct values', () async {
      await sut.saveSecure(key: key, value: value);

      verify(secureStorage.write(key: key, value: value));
    });

    test('Should throw if save secure throws', () {
      mockSaveSecureError();
      final future = sut.saveSecure(key: key, value: value);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });

  group('fetchSecure', () {
    PostExpectation mockFetchSecureCall() => when(secureStorage.read(key: key));

    void mockFetchSecure() {
      mockFetchSecureCall().thenAnswer((_) async => value);
    }

    void mockFetchSecureError() {
      mockFetchSecureCall().thenThrow(Exception());
    }

    setUp(() {
      mockFetchSecure();
    });

    test('Should call fetch secure with correct value', () async {
      await sut.fetchSecure(key);

      verify(secureStorage.read(key: key));
    });

    test('Should return correct value on sucess', () async {
      final fetchedValue = await sut.fetchSecure(key);

      expect(fetchedValue, value);
    });

    test('Should throw if fetch secure throws', () async {
      mockFetchSecureError();
      final future = sut.fetchSecure(key);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });

  group('deleteSecure', () {
    void mockDeleteSecureError() =>
        when(secureStorage.delete(key: key)).thenThrow(Exception());

    test('Should call delete with correct value', () async {
      await sut.deleteSecure(key);

      verify(secureStorage.delete(key: key)).called(1);
    });

    test('Should thorw if delete thorws', () async {
      mockDeleteSecureError();
      final future = sut.deleteSecure(key);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });
}
