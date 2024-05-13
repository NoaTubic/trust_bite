// ignore_for_file: always_use_package_imports

import 'package:dio/dio.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:food_safety/main/app_environment.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

final apiClientProvider = Provider<ApiClient>(
  (ref) => ApiClient(
    ref.watch(
      dioProvider(EnvInfo.apiBaseUrl),
    ),
  ),
);

final dioProvider = Provider.family<Dio, String>(
  (ref, baseUrl) => Dio(
    BaseOptions(baseUrl: baseUrl),
  )..interceptors.addAll(
      [
        LoggyDioInterceptor(requestBody: true, requestHeader: true),
      ],
    ),
);

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;
}
