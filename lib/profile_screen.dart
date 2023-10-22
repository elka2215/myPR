import 'package:flutter/material.dart';

/// экран авторизации
class ProfileInfoPage extends StatefulWidget {
  const ProfileInfoPage({super.key});

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ProfilePage"),
      ),
      body: Container(
        margin: const EdgeInsets.all(30),
        child: const Text("Пользователь зарегистрирован"),
      ),
    );
  }
}
