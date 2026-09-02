import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase initialization warning: $e');
  }

  runApp(const UnionRideApp());
}