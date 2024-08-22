
import 'package:flutter/material.dart';
import 'package:untitled1/BusBay.dart';
import 'package:untitled1/BusDetailsPage.dart';
import 'package:untitled1/Coursers_and_branches.dart';
import 'package:untitled1/Crew_Details.dart';
import 'package:untitled1/HomePage.dart';
import 'package:untitled1/Registerpage.dart';
import 'package:untitled1/SelectUser.dart';
import 'package:untitled1/Updates.dart';
import 'Loginpage.dart';

void main() {
  runApp(
      MaterialApp(
    debugShowCheckedModeBanner: false,
    home:  SelectUserPage(),
    routes: {
      'register': (context)=> const Registerpage(),
      'login':(context)=> const Loginpage(),
    },
  ));
}

