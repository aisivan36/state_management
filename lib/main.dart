// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'data/memory_repository.dart';
import 'mock_service/mock_service.dart';

import 'ui/main_screen.dart';

Future<void> main() async {
  _setupLogging();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      ///[MultiProvider]uses the providers property to define multiple providers
      providers: [
        /// return [ChangeNotifierProvider] that has the type [MemoryRepository]
        ChangeNotifierProvider<MemoryRepository>(
          // set lazy to false, which creates the repository right away instade of
          // waiting till we need it. This is useful when the repository has to do
          // some background work to start up
          lazy: false,
          // creates repository
          create: (_) => MemoryRepository(),
          // return material app as the child widget
        ),

        /// a new provider which will use the new mock service
        Provider(
          /// Create [MockService] and call [create()] to load [JSON] files
          /// here using cascade operator
          create: (_) => MockService()..create(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Recipe',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
