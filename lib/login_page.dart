import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_project/page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  TextEditingController _emailController1 = TextEditingController();
  TextEditingController _passwordController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey1,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(300, 10, 10, 10),
          child: Column(
            children: [
              Image.asset(
                "lib/assets/image.jpeg",
                width: 600,
                height: 300,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 30, 100, 10),
                child: Container(
                  width: 600,
                  child: TextFormField(
                      controller: _emailController1,
                      validator: (email) {
                        if (!email!.contains("@")) {
                          return "wrong email format";
                        } else if (!email.contains(".com")) {
                          return "wrong email format";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Email"),
                          prefixIcon: Icon(Icons.email))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                child: Container(
                  width: 600,
                  child: TextFormField(
                      controller: _passwordController1,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Password"),
                          prefixIcon: Icon(Icons.lock))),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    // logIn(context);
                    if (_formKey1.currentState!.validate()) {
                      logIn();
                    }
                  },
                  child: const Text("log in"),
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.cyan,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)))),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logIn() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController1.text, password: _passwordController1.text);
      if (credential != null) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => PageN()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        print('incorrect email or password');

        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button?
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('incorrect email or password'),
              actions: <Widget>[
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user');
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button?
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Wrong password provided for that user'),
              actions: <Widget>[
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        // Handle other authentication errors here
        print('Authentication error: ${e.code}');
      }
    }
  }
}

//invalid-credential
