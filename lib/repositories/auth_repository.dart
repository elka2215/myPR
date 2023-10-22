import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'dart:convert' as convert;

import 'package:practice8/bloc/bloc.dart';

class AuthRepository {
  /// запрос сам
  Future<void> onGetAuthEvent(
      GetAuthEvent event, Emitter<AuthBlocState> emit) async {
    Response response;
    emit(LoadingAuthState());
    response = await http.post(
      Uri.parse("https://freefakeapi.io/authapi/login"),

      /// наш апи который сам нашел
      body: convert.jsonEncode({
        /// в тело мы переносим параметры
        'username': event.username,
        'password': event.password,
      }),
    );

    if (response.statusCode == 200) {
      emit(LoadedAuthState());
    } else {
      emit(FailureLoginState());
    }
  }
}
