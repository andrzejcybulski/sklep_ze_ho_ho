import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Że Ho Ho sklep';
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      // home: const RootPage(appTitle: appTitle),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext concext) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (user == null) {
            return const Scaffold(
              body: Center(
                child: Text('Jesteś niezalogowany'),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: Text('Jesteś zalogowany jako ${user.email}'),
            ),
          );
        });
  }
}
          
        
        


// class RootPage extends StatelessWidget {
//   const RootPage({
//     super.key,
//     required this.appTitle,
//   });

//   final String appTitle;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           final user = snapshot.data;
//           if (user == null) {}
//           return Scaffold(
//             appBar: AppBar(
//               title: Text(appTitle),
//               backgroundColor: Colors.red,
//             ),
//             body: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 // const SizedBox(height: 20),
//                 // // const Image(
//                 // //   image: AssetImage('images/santa1.jpeg'),
//                 // //   width: 150,
//                 // // ),
//                 // const CircleAvatar(
//                 //   backgroundImage: AssetImage('images/santa1.jpeg'),
//                 //   radius: 80,
//                 // ),
//                 // const SizedBox(height: 20),
//                 // const Text('Logowanie'),
//                 // const SizedBox(height: 30),
//                 // Padding(
//                 //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 //   child: TextFormField(
//                 //     decoration: const InputDecoration(
//                 //       border: OutlineInputBorder(),
//                 //       hintText: 'Enter your e-mail',
//                 //     ),
//                 //   ),
//                 // ),
//                 // const SizedBox(height: 20),
//                 // Padding(
//                 //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 //   child: TextFormField(
//                 //     decoration: const InputDecoration(
//                 //       border: OutlineInputBorder(),
//                 //       hintText: 'Enter your password',
//                 //     ),
//                 //   ),
//                 // ),
//                 // ElevatedButton(
//                 //   style: ElevatedButton.styleFrom(
//                 //     backgroundColor: Colors.red,
//                 //   ),
//                 //   child: const Text('Zaloguj się'),
//                 //   onPressed: () {},
//                 // ),
//                 // // TextButton(
//                 // //   child: Text('Masz już konto? Zaloguj się'),
//                 // //   onPressed: () {},
//                 // // ),
//                 // // TextButton(
//                 // //   child: Text('Nie masz konta? Zarejestruj się'),
//                 // //   onPressed: () {},
//                 // // ),
//               ],
//             ),
//           );
//         });
//   }
// }
