import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice8/bloc/bloc.dart';
import 'package:practice8/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// два контролерра для получения текста из формы заполнения
  final usernameContoller = TextEditingController();
  final passwordController = TextEditingController();
  late AuthBlocBloc authBloc;

  @override
  void initState() {
    authBloc = AuthBlocBloc();
    super.initState();
  }

  @override
  void dispose() {
    usernameContoller.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("AppBar"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              buildAuthBlocListener(),
              buildLoginFormFiled(),
              buildPasswordFormFiled(),
              buildButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAuthBlocListener() {
    return BlocConsumer(
      bloc: authBloc,

      /// слушатель если какое то сосояние произошло и мы что то делаем
      listener: (context, state) {
        if (state is LoadedAuthState) {
          /// к примеру тут мы проверяем состояние [LoadedAuthState] то переходи на след экран
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfileInfoPage()));
        }
        if (state is FailureLoginState) {
          /// если состояние ошибка то показываем ошибку
          showError(context);
        }
      },
      builder: (context, state) {
        if (state is LoadingAuthState) {
          /// тут вы делаем загрузку пока данные нам приходят и говорят зарегались ли мы или нет
          return Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              color: Colors.black.withOpacity(0.2),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  /// тут формы для заполнения -
  /// логин MikePayne
  /// пароль myBeaut1fu11P@ssW0rd!
  Widget buildLoginFormFiled() {
    return TextField(
      controller: usernameContoller,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        icon: Icon(Icons.login_rounded),
        hintText: "Введите логин",
      ),
    );
  }

  Widget buildPasswordFormFiled() {
    return TextField(
      controller: passwordController,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        icon: Icon(Icons.login_rounded),
        hintText: "Введите пароль",
      ),
    );
  }

  Widget buildButton() {
    return OutlinedButton(
      onPressed: () {
        String username = usernameContoller.text;
        String password = passwordController.text;
        authBloc.add(GetAuthEvent(username, password));
      },
      child: const Text("Авторизоваться"),
    );
  }

  Future<void> showError(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: const Text("Error"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            OutlinedButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
