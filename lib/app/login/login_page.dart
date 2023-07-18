import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    super.key,
  });

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var errorMessage = '';
  var isCreatingAccount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Sklep Że Ho Ho'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            backgroundImage: AssetImage('images/santa1.jpeg'),
            radius: 80,
          ),
          const SizedBox(height: 20),
          Text(isCreatingAccount == true ? 'Rejestracja' : 'Logowanie'),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: widget.emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                hintText: 'E-mail',
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: widget.passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                hintText: 'Hasło',
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              obscureText: true,
            ),
          ),
          Text(errorMessage),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: const StadiumBorder(),
            ),
            child: Text(
                isCreatingAccount == true ? 'Zarejestruj się' : 'Zaloguj się'),
            onPressed: () async {
              if (isCreatingAccount == true) {
                //rejestracja
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: widget.emailController.text,
                    password: widget.passwordController.text,
                  );
                } catch (error) {
                  setState(
                    () {
                      errorMessage = error.toString();
                    },
                  );
                }
              } else {
                //logowanie
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: widget.emailController.text,
                    password: widget.passwordController.text,
                  );
                } catch (error) {
                  setState(
                    () {
                      errorMessage = error.toString();
                    },
                  );
                }
              }
            },
          ),
          if (isCreatingAccount == false) ...[
            TextButton(
              child: const Text('Utwórz konto'),
              onPressed: () {
                setState(() {
                  isCreatingAccount = true;
                });
              },
            ),
          ],
          if (isCreatingAccount == true) ...[
            TextButton(
              child: const Text('Masz już konto?'),
              onPressed: () {
                setState(() {
                  isCreatingAccount = false;
                });
              },
            ),
          ],
        ],
      ),
    );
  }
}
