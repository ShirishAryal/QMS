import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qms/src/controller/api_requests.dart';
import 'package:qms/src/widgets/toast_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/validation.dart';
import '../../widgets/loader.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _hidePass = true;
  bool _isChecked = false;
  @override
  void initState() {
    _loadUserEmailPassword();
    super.initState();
  }

  @override
  void dispose() {
    // ignore: avoid_print
    print('login screen disposed');
    super.dispose();
  }

  void _loadUserEmailPassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("email") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;
      if (_remeberMe) {
        setState(() {
          _isChecked = true;
        });
        _emailController.text = _email;
        _passwordController.text = _password;
      }
    } catch (e) {}
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LogIn Screen'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  emailField(),
                  passwordField(),
                  const SizedBox(height: 10),
                  rememberMe(),
                  const SizedBox(height: 20),
                  submitButton(),
                  const SizedBox(height: 20),
                  signUp(),
                  const SizedBox(
                    height: 20,
                  ),
                  skipNow()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          color: Theme.of(context).primaryColor,
        ),
        labelText: 'Email Address',
        hintText: 'you@example.com',
      ),
      validator: validateEmail,
    );
  }

  Widget passwordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _hidePass,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Theme.of(context).primaryColor,
        ),
        suffixIcon: InkWell(
            onTap: () {
              setState(() {
                _hidePass = !_hidePass;
              });
            },
            child: _hidePass
                ? const Icon(Icons.visibility_off)
                : const Icon(Icons.visibility)),
        labelText: 'Password',
        hintText: 'Password',
      ),
      validator: validatePassword,
    );
  }

  Widget submitButton() {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, "/");
        if (formKey.currentState!.validate()) {
          Map map = <String, String>{};
          map['email'] = _emailController.text;
          map['password'] = _passwordController.text;
          QmsLoader.of(context).show();
          ApiRequest().userLogin(map).then(
            (value) {
              QmsLoader.of(context).hide();
              print(value.msgCode);
              if (value.msgCode == 1) {
                Navigator.pushNamed(context, "/");
                ToastMessage.success(value.msg.toString());
              } else {
                ToastMessage.error(value.msg);
              }
            },
          );
        }
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Log In',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget rememberMe() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
          height: 24.0,
          width: 24.0,
          child: Theme(
            data: ThemeData(unselectedWidgetColor: Colors.black // Your color
                ),
            child: Checkbox(
                activeColor: Colors.black,
                value: _isChecked,
                onChanged: (value) {
                  _isChecked = value!;
                  SharedPreferences.getInstance().then(
                    (prefs) {
                      prefs.setBool("remember_me", value);
                      prefs.setString('email', _emailController.text);
                      prefs.setString('password', _passwordController.text);
                    },
                  );
                  setState(() {
                    _isChecked = value;
                  });
                }),
          )),
      SizedBox(width: 10.0),
      Text("Remember Me", style: TextStyle(color: Colors.black, fontSize: 14))
    ]);
  }

  Widget signUp() {
    return TextButton(
        onPressed: () {
          Navigator.pushNamed(context, "/signup");
        },
        child: const Text('Create new user?'));
  }

  Widget skipNow() {
    return TextButton(
        onPressed: () {
          Navigator.pushNamed(context, "/");
        },
        child: const Text('May be later'));
  }
}
