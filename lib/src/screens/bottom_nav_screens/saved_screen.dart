import 'package:flutter/material.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Saved Files'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Center(
            child: ElevatedButton(
          child: const Text('Log In'),
          onPressed: () {
            Navigator.pushNamed(context, "/login");
          },
        )),
      ),
    );
  }
}
