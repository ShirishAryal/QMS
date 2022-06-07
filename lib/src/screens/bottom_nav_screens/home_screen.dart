import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:qms/src/controller/api_requests.dart';
import '../../api_services/base_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Welcome to QMS!'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () async {
                // ApiRequest().createUser();
                // print(response);
                // await ApiRequest().getData();
                Navigator.pushNamed(context, "/signup");
              },
              child: Text('create user')),
        ),
      ),
    );
  }
}
