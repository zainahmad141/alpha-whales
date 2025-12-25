import 'package:flutter/material.dart';


class HomeProvider extends ChangeNotifier {
  Future<void> test(BuildContext context) async {
    try {
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Flashlight not available: $e")),
      );
    }
  }

}