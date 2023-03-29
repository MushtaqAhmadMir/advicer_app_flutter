import 'dart:convert';

import 'package:advisor_app/0_data/exceptions/exceptions.dart';
import 'package:advisor_app/0_data/models/advice_modal.dart';
import 'package:http/http.dart' as http;

abstract class AdviceRemoteDataSource {
  ///requests a random advice from api
  /// returns [AdviceModel] if successfull
  /// throws a server error/exception if status code is not 200
  Future<AdviceModel> getRandomAdviceFromApi();
}

class AdviceRemoteDataSourceImpl extends AdviceRemoteDataSource {
  AdviceRemoteDataSourceImpl({required this.client});
  final  http.Client client;
  @override
  Future<AdviceModel> getRandomAdviceFromApi() async {
    final response = await client.get(
        Uri.parse('https://api.flutter-community.com/api/v1/advice'),
        headers: {'content-type': 'application/json'});

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final responseBody = json.decode(response.body);
      print(response);
      return AdviceModel.fromJson(responseBody);
    }
  }
}
