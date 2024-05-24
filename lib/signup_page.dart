import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_project/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_project/page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(70, 10, 70, 10),
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
                      controller: _nameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("User Name"),
                          prefixIcon: Icon(Icons.person))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                child: Container(
                  width: 600,
                  child: TextFormField(
                      controller: _emailController,
                      validator: (email) {
                        if (!email!.contains("@")) {
                          return "wrong email format";
                        } else if (!email!.contains(".com")) {
                          return "wrong email format";
                        }
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
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Password"),
                          prefixIcon: Icon(Icons.lock))),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      createAccount();
                    }
                  },
                  child: const Text("Sign up"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.cyan,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const LoginPage()));
                        },
                        child: const Text("log in"),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.cyan,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createAccount() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
        //name:_nameController.text,
      );
      if (credential != null) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(credential.user!.uid)
            .set({"full name": _nameController.text});
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => PageN()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('weak-password');

        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button?
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('your password is weak'),
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
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button?
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('The account already exists for that email.'),
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
      }
    } catch (e) {
      print(e);
    }
  }
}
