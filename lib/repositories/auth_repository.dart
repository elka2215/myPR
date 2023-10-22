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
    try {
      response = await http.post(
        Uri.parse("https://freefakeapi.io/authapi/login"),

        /// наш апи который сам нашел
        body: convert.jsonEncode({
          /// в тело мы переносим параметры
          'username': event.username,
          'password': event.password,
        }),
      );
      emit(LoadedAuthState());

      /// и если у нас все хорошо ушел запрос то мы вызывем состняие что все загрузилось
      print(response.body);
    } catch (_) {
      emit(FailureLoginState());
    }
  }
}
