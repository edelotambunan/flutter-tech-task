import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tech_task/core/config/api_url.dart';
import 'package:tech_task/core/networking/api_exception.dart';
import 'package:tech_task/core/networking/api_provider.dart';
import 'package:http/http.dart' as http;

final String url = ApiUrl.ingredientListUrl;

class MockApiProvider extends Mock implements ApiProvider {
  ApiProvider _apiProvider;

  MockApiProvider(http.Client httpClient) {
    _apiProvider = ApiProvider(httpClient: httpClient);
    when(get(url)).thenAnswer((_) => _apiProvider.get(url));
  }
}

class MockHttpClient extends Mock implements http.Client {}

void main (){
  group('ApiProvider', (){
    final mockHttpClient = MockHttpClient();
    final mockApiProvider = MockApiProvider(mockHttpClient);
    test('Return json array (List) if response code 200', () async {
      final mockSuccessResponse = '''[{"title": "Ham","use-by": "2020-11-25"}]''';

      when(mockHttpClient.get(url)).thenAnswer((_) async => Future.value(http.Response(mockSuccessResponse, 200)));
      expect(await mockApiProvider.get(url), isA<List>());
    });

    test('Throws ClientErrorException if response code 400', () async{
      when(mockHttpClient.get(url)).thenAnswer((_) async => Future.value(http.Response('', 400)));
      try {
        await mockApiProvider.get(url);
        fail("No Exception thrown");
      } catch (exception) {
        expect(exception, isInstanceOf<ClientErrorException>());
      }
    });

    test('Throws ServerErrorException if response code 500', () async{
      when(mockHttpClient.get(url)).thenAnswer((_) async => Future.value(http.Response('', 500)));
      try {
        await mockApiProvider.get(url);
        fail("No Exception thrown");
      } catch (exception) {
        expect(exception, isInstanceOf<ServerErrorException>());
      }
    });

    test('Throws DefaultException if response code is not 200,400 or 500', () async{
      when(mockHttpClient.get(url)).thenAnswer((_) async => Future.value(http.Response('', 403)));
      try {
        await mockApiProvider.get(url);
        fail("No Exception thrown");
      } catch (exception) {
        expect(exception, isInstanceOf<DefaultException>());
      }
    });
  });
}