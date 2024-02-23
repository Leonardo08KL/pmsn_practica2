import 'package:flutter/material.dart';
import 'package:pmsn_practica2/screens/dash_board_screen.dart';
import 'package:pmsn_practica2/screens/register_screen.dart';
import 'package:pmsn_practica2/settings/app_value_notifier.dart';
import 'package:pmsn_practica2/settings/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppValueNotifier.banTheme,
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: value
              ? ThemeApp.darkTheme(context)
              : ThemeApp.lightTheme(context),
          home: RegisterScreen(),
          routes: {
            "/dash": (BuildContext context) => DashBoardScreen(),
          },
        );
      },
    );
  }
}




/*
class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int contador = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Practica 1",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue,
        ),
        drawer: Drawer(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            contador++;
            print(contador);
            setState(() {});
          },
          child: Icon(Icons.ads_click),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.network(
                "https://sandstormit.com/wp-content/uploads/2021/06/incognito-2231825_960_720-1.png",
                height: 250,
              ),
            ),
            Text('Valor del contador $contador'),
          ],
        ),
      ),
    );
  }
}
*/