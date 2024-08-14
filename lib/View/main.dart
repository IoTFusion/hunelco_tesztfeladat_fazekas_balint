import 'dart:convert';

import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:hunelco_tesztfeladat_fazekas_balint/Model/Movie.dart';
import 'package:hunelco_tesztfeladat_fazekas_balint/View/Widget/MovieCard.dart';
import 'package:hunelco_tesztfeladat_fazekas_balint/ViewModel/GetMovies.dart';

import '../Model/Result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hunelco tesztfeladat',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme:
        ColorScheme.dark(
          primary: new Color.fromARGB(255, 100, 100, 100),
          background: new Color.fromARGB(255, 40, 40, 40)
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Movie list'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Movie? movie;
  String? searchTerm;
  int pageCount=1;
  List<Result> results = [];
  final scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarWithSearchSwitch(
        onChanged: (text) {
          searchTerm = text;
          fetchMovieList();
        }, // onSubmitted: (text) => searchText.value = text,
        appBarBuilder: (context) {
          return AppBar(
            title: Text('Movie'),
            actions: [
              AppBarSearchButton(),
            ],
          );
        },
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: _listScreen(),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {
    super.initState();
  }

  _listScreen(){
    return NotificationListener<ScrollEndNotification>(
        onNotification: (notification) {
      if (notification.metrics.pixels ==
          notification.metrics.maxScrollExtent) {
        pageCount++;
        fetchMovieList();
      }
      return false;
    },
    child: ListView.builder(
        shrinkWrap: true,
        itemCount: movie?.results.length??0,
        controller: scrollController,

        itemBuilder: (BuildContext context, int index) => MovieCard(results[index])
    )
    );
  }

  void fetchMovieList() async {

    Response response = await GetMovies().get(searchTerm??"", pageCount);
    if(response.statusCode == 200){
      if(mounted){
        setState(() {
          movie = Movie.fromJson(jsonDecode(response.body));
          for(Result result in movie?.results??[])
          {
            results.add(result);
          }
        });
      }
    }else{
      print(response.body);
    }
  }
}
