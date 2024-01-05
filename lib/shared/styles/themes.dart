import 'package:flutter/material.dart';

var lightTheme=ThemeData(
  appBarTheme: const AppBarTheme(
    color: Colors.white38,
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
  fontFamily: 'hussein',
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.black,
    type: BottomNavigationBarType.shifting,
    unselectedItemColor: Colors.grey,
  )
);

var darkTheme=ThemeData(
    iconTheme: const IconThemeData(
    color: Colors.white
  ),
    iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStatePropertyAll(Colors.white),
    ),
  ),
    textTheme: const TextTheme(
    bodySmall: TextStyle(
      color: Colors.white54,
      fontWeight: FontWeight.w300,
      fontSize: 12,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      height: 1.4
    ),
    displaySmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16,
      height: 1.4,
    ),
    displayMedium: TextStyle(
      color: Colors.white,
      fontSize: 25,
    ),

  ),
    appBarTheme: const AppBarTheme(
      elevation: 15,
      color: Colors.black,
    ),
    buttonTheme:  ButtonThemeData(
       focusColor: Colors.grey[700]
     ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStatePropertyAll(Colors.grey[700]),
        textStyle: const MaterialStatePropertyAll(
          TextStyle(
            fontSize: 18
          ),
        )
      )
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStatePropertyAll(Colors.grey[700]),
      )
    ),
    colorScheme:  const ColorScheme(
      background: Colors.black,
      brightness: Brightness.dark,
      error: Colors.red,
      onBackground: Colors.blueGrey,
      onError: Colors.red,
      onPrimary: Colors.green,
      onSecondary: Colors.blueGrey,
      onSurface: Colors.white,//widgets on the screen
      primary: Colors.blueGrey,
      secondary: Colors.pink,
      surface: Colors.black,
    ),
    useMaterial3: true,
    fontFamily: 'hussein',
    inputDecorationTheme: InputDecorationTheme(
      hoverColor: Colors.green,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 15,
      selectedItemColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.white24,
      backgroundColor: Colors.black54,
    )
);