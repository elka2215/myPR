part of 'bloc.dart';

@immutable
abstract class AuthBlocEvent {}

/// наше евент где два
class GetAuthEvent extends AuthBlocEvent {
  final String username;
  final String password;
  GetAuthEvent(this.username, this.password);
}
