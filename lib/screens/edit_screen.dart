import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final String label;
  final String initialValue;
  final bool isPassword;
  final TextInputType keyboardType;

  EditPage({required this.label, required this.initialValue, required this.isPassword, required this.keyboardType});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.label}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              obscureText: widget.isPassword,
              keyboardType: widget.keyboardType,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _controller.text);
              },
              child: Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
