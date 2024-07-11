import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String accessToken = 'EAAlvKgsFbJ0BO64CR8AqltIiK72rTZCV8EtFJdnMKFwBoUG34ZAwDMLnrF7BXrG9mh2rBCgAjJyOvK3BxgIImP8UMi5YiUKmeDX4RnFC7DZCM44opFpPKgskn2RbdJ1ELZCu2Vt1UtfN6hkQfZCeESaqCaAfJlxctAudMgPYTOY5cks6GhzsjxZCHwCFyGbGhu';
  final String userId = '122099949260395551';

  Future<void> createFacebookPage() async {
    final url = 'https://graph.facebook.com/v20.0/$userId/accounts';
    final body = {
      'name': 'My New Page',
      'about': 'Description of my new page',
      'category': 'Community',
      'access_token': accessToken,
    };

    final response = await http.post(
      Uri.parse(url),
      body: json.encode(body),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    setState(() {
      if (response.statusCode == 200) {
        _response = 'Page created successfully: ${response.body}';
      } else {
        _response = 'Failed to create page: ${response.body}';
      }
    });
  }

  String _response = 'No response yet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Facebook Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: createFacebookPage,
              child: const Text('Create Page'),
            ),
            SizedBox(height: 20),
            Text(_response),
          ],
        ),
      ),
    );
  }
}
