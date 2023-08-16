import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 88, 84, 84),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 100),
          const CircleAvatar(
            backgroundColor: Colors.pink,
            radius: 82,
            child: CircleAvatar(
              backgroundImage: AssetImage('images/santapink.jpeg'),
              radius: 80,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Sklep, że Ho Ho',
            style:
                GoogleFonts.permanentMarker(color: Colors.pink, fontSize: 40),
          ),
          const SizedBox(height: 20),
          Text(
            isCreatingAccount == true ? 'Rejestracja' : 'Logowanie',
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: widget.emailController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.grey,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  // borderRadius: BorderRadius.circular(25.0),
                ),
                hintText: 'E-mail',
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink),
                  // borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: widget.passwordController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    // borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: 'Hasło',
                  hintStyle: const TextStyle(color: Colors.white),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                    // borderRadius: BorderRadius.circular(25.0),
                  ),
                  suffixIcon: IconButton(
                    color: Colors.white,
                    icon: Icon(
                        isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                  )),
              obscureText: isObscure,
            ),
          ),
          Text(errorMessage),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              // shape: const StadiumBorder(),
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
              style: TextButton.styleFrom(
                foregroundColor: Colors.pink,
              ),
              onPressed: () {
                setState(() {
                  isCreatingAccount = true;
                });
              },
              child: const Text('Utwórz konto'),
            ),
          ],
          if (isCreatingAccount == true) ...[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.pink,
              ),
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
