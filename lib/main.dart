import 'package:flutter/material.dart';

import 'package:moviesapiflutterassesment/view/movielistingscreen.dart';
import 'package:moviesapiflutterassesment/viewmodel/popularmovie_viewmodel.dart';

import 'package:provider/provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ListingApiViewModel>(create: (context) => ListingApiViewModel()),
      ],
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(


          primarySwatch: Colors.blue,
        ),
        home: const MovieApiListing(),
      ),

    );
  }
}

