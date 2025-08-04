import 'package:flutter/material.dart';

final ThemeData customTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF0F0F0F),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.dark,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontFamily: 'Euclid Circular A',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'Euclid Circular A',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Euclid Circular A',
      fontSize: 13,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Euclid Circular A',
      fontSize: 14,
      color: Colors.white,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Euclid Circular A',
      fontSize: 12,
      color: Colors.white,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      fontFamily: 'Euclid Circular A',
      color: Colors.white,
      decoration: TextDecoration.underline,
      decorationColor: Colors.white,
    ),
    titleSmall: TextStyle(
      fontSize: 15,
      fontFamily: 'Euclid Circular A',
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    labelLarge: TextStyle(
      fontSize: 4,
      fontFamily: 'Euclid Circular A',
      color: Colors.white,
    ),
    
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    textStyle: const TextStyle(color: Colors.black),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xffe50914),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
  ),
);
