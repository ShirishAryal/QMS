import 'package:flutter/material.dart';
import 'package:qms/src/controller/api_requests.dart';
import '../../controller/api_requests.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Profile'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    // await ApiRequest().userDetail();
                  },
                  child: Text('User Detail')),
              ElevatedButton(
                child: const Text('Log In'),
                onPressed: () {
                  Navigator.pushNamed(context, "/login");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
