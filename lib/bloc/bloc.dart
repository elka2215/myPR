import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice8/repositories/auth_repository.dart';
part 'event_bloc.dart';
part 'state_bloc.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final _repository = AuthRepository();

  /// делаем экземпляр репозитория
  AuthBlocBloc() : super(AuthBlocInitial()) {
    on<AuthBlocEvent>((event, emit) => emit(AuthBlocInitial()));
    on<GetAuthEvent>(_repository.onGetAuthEvent);

    /// тут делаем запрос
  }
}
