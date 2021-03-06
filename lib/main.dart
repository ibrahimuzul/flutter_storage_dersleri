import 'package:flutter/material.dart';
import 'package:flutter_storage_dersleri/dosya_islemleri.dart';
import 'package:flutter_storage_dersleri/sqlflite_islemleri.dart';

import 'shared_pref_kullanimi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: SharedPrefKullanimi(),
      //home: DosyaIslemleri(),
      home: SqfliteIslemleri(),
    );
  }
}
