import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final mail = TextEditingController();
  final pass = TextEditingController();

  Future Login() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: mail.text.trim(), password: pass.text.trim())
          .then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      }).onError((error, stackTrace) {
        print('Wrong password');
      });
    } catch (err) {
      throw Exception(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          TextFormField(
            controller: mail,
            decoration: InputDecoration(hintText: 'Email'),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            obscureText: true,
            controller: pass,
            decoration: InputDecoration(hintText: 'password'),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Login();
              },
              child: Text('Login'))
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
    );
  }
}
