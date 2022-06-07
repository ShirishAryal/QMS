import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Search your question'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: const Center(child: Text('Search Screen')),
      ),
    );
  }
}
