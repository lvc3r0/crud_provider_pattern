import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './providers/person_provider.dart';
import './providers/validator_provider.dart';
import './pages/list_page.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PersonProvider>.value(
          value: PersonProvider(),
        ),
        ChangeNotifierProvider<ValidatorProvider>.value(
          value: ValidatorProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ListPage(),
      ),
    );
  }
}
