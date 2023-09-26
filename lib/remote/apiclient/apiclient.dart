import 'package:dio/dio.dart';

import 'package:moviesapiflutterassesment/utills/enum.dart';

class MovieApiClient {
  String? baseUrl;
  Map<String, dynamic>? queryParameters;
  Map<String, dynamic>? body;

  MovieApiClient({required this.baseUrl, this.body, this.queryParameters});

  request({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
    RequestMethod requestMethod = RequestMethod.get,
  }) {
    if (beforeSend != null) {
      beforeSend();
    }
    final options = RequestOptions(
      baseUrl: baseUrl,
      queryParameters: queryParameters,
      data: body,
      method: requestMethod == RequestMethod.get ? "Get" : "POST",
    );
    Dio().fetch(options).then((value) {
      if (onSuccess != null && value.statusCode == 200) {
        onSuccess(value.data);
      } else {
        if (onError != null) {
          onError('Invalid Status Code');
        }
      }
    }).onError((error, stackTrace) {
      if (onError != null) {
        onError(error);
      }
    });
  }
}
