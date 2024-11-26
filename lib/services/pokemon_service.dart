import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/models/poke_api_model.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/utils/constants.dart';
import 'package:pokedex_app/utils/dio_exceptions.dart';

class PokemonService {
  final ApiService _apiService = ApiService();

  Future<Pokemon?> getPokemonByNameOrNumber(String query) async {
    try {
      final response = await _apiService.dio
          .get('${ApiConstants.pokemonDetailsByNumberOrName}$query');

      return Pokemon.fromDetailJson(response.data);
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception('Failed to load pokemon: $e');
    }
  }

  Future<PokemonListModel> getPokemonList(
      {int offset = 0, int limit = 20}) async {
    try {
      final response = await _apiService.dio.get(
        '/pokemon',
        queryParameters: {
          'offset': offset,
          'limit': limit,
        },
      );
      return PokemonListModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception('Failed to load pokemon: $e');
    }
  }
}

class ApiService {
  static final ApiService _instance = ApiService._internal();
  late Dio _dio;

  factory ApiService() => _instance;

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUri,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint(
              'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path} URI:${response.realUri}');
          return handler.next(response);
        },
        onError: (error, handler) {
          debugPrint(
              'ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path} URI: ${error.response!.realUri}');
          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
