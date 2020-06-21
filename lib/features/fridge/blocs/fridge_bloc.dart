import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:tech_task/core/networking/api_provider.dart';
import 'package:tech_task/core/networking/api_response.dart';
import 'package:tech_task/features/fridge/models/fridge.dart';
import 'package:tech_task/features/fridge/repositories/fridge_repository.dart';

class FridgeBloc{
  FridgeRepository _fridgeRepository;
  StreamController _fridgeController;

  StreamSink<ApiResponse<Fridge>> get fridgeSink =>
      _fridgeController.sink;

  Stream<ApiResponse<Fridge>> get fridgeStream =>
      _fridgeController.stream;

  FridgeBloc() {
    _fridgeController = StreamController<ApiResponse<Fridge>>();
    _fridgeRepository = FridgeRepository(apiProvider: ApiProvider(httpClient: http.Client()));
    getFridge();
  }

  getFridge() async {
    fridgeSink.add(ApiResponse.loading('Fetching Ingredients...'));
    try {
      List<dynamic> ingredientList = await _fridgeRepository.getIngredientList();
      Fridge fridge = Fridge.fromJson(ingredientList);
      fridgeSink.add(ApiResponse.completed(fridge));
    } catch (e) {
      fridgeSink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _fridgeController?.close();
  }
}