import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jan Sampark',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 50, 192, 236)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Jan Sampark'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic data;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    final response = await http.get(Uri.parse('http://localhost:3000/'));

    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    } else {
      setState(() {
        data = 'Failed to fetch data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB0C3FF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Solving grievances, strengthening communities',
              style: TextStyle(
                fontFamily: 'Jacques Francois',
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              child: const Text('Get Started'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
            if (data != null) ...[
              const SizedBox(height: 20),
              Text(
                'Data: $data',
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
