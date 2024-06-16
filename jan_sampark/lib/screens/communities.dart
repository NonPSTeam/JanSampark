import 'package:flutter/material.dart';

class CommunitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Communities Page'),
      ),
      body: Center(
        child: Text(
          'Communities Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
