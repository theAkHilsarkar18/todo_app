import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home/provider/homeprovider.dart';
import 'package:todo_app/home/view/homescreen.dart';

void main()
{
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Homeprovider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/' : (context) => Homescreen(),
        },
      ),
    ),
  );
}