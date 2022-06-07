import 'package:flutter/material.dart';
import 'package:qms/src/controller/api_requests.dart';
import 'package:qms/src/widgets/loader.dart';
import 'package:qms/src/widgets/toast_message.dart';
import '../../utils/validation.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  createState() {
    return SignupScreenState();
  }
}

class SignupScreenState extends State<SignupScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    print('signup screen disposed');
    super.dispose();
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp Screen'),
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
                  confirmPasswordField(),
                  Container(
                    margin: const EdgeInsets.only(top: 25.0),
                  ),
                  submitButton(),
                  const SizedBox(height: 40),
                  accountExist()
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
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Theme.of(context).primaryColor,
        ),
        labelText: 'Password',
        hintText: 'Password',
      ),
      validator: validatePassword,
    );
  }

  Widget confirmPasswordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Theme.of(context).primaryColor,
        ),
        labelText: 'Confirm Password',
        hintText: 'Password',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }

        if (value != _passwordController.text) {
          return 'Password does not match.';
        }

        return null;
      },
    );
  }

  Widget submitButton() {
    return GestureDetector(
      onTap: () async {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          QmsLoader.of(context).show();
          Map map = <String, String>{};
          map['email'] = _emailController.text;
          map['password'] = _passwordController.text;
          // if (await ApiRequest().createUser(map) != null) {
          //   QmsLoader.of(context).hide();
          //   Navigator.pushNamed(context, "/bottomnav");
          // }
          QmsLoader.of(context).hide();
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
              'Sign Up',
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

  Widget accountExist() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already, have an account?'),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/login");
            },
            child: const Text('Login')),
      ],
    );
  }
}
