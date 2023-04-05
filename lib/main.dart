import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_image/provider/provider.dart';

import 'components/components.dart';
import 'screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()..initState())
      ],
      child: MaterialApp(
        title: 'Search Image',
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.cuatomTheme(),
        home: HomePage(),
      ),
    );
  }
}
