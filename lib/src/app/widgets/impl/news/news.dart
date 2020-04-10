import 'package:flutter/material.dart';
import 'package:flutter_breaking_news/src/app/widgets/widgets.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SIGN IN IS OK'),
      ),
      body: Center(child: AuthLogoutButton()),
    );
  }
}
