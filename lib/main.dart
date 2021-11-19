import 'package:flutter/material.dart';
import 'package:flutter_chuck/model/chuck_joke.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(const MyApp());
}

// SpinKitFadingCircle spinkit = SpinKitFadingCircle(
//   itemBuilder: (BuildContext context, int index) {
//     return DecoratedBox(
//       decoration: BoxDecoration(
//         color: index.isEven ? Colors.red : Colors.green,
//       ),
//     );
//   },
// );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Jokes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var defaultChuckJoke = ChuckJoke();

  void getJokeUpdateUi() async {
    ChuckJoke chuckJoke = await getJoke();
    // spinkit = SpinKitFadingCircle((await getJoke()) as SpinKitRotatingCircle);

    setState(() {
      defaultChuckJoke.imageUrl = chuckJoke.imageUrl;
      defaultChuckJoke.joke = chuckJoke.joke;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(defaultChuckJoke.imageUrl),
            Text(defaultChuckJoke.joke),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {getJokeUpdateUi()},
      ),
    );
  }

  Future<ChuckJoke> getJoke() async {
    var url = Uri.http('api.chucknorris.io', '/jokes/random');

    var response = await http.get(
      url,
      headers: {"accept": "application/json"},
    );

    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);

      return ChuckJoke(
        imageUrl: json['icon_url'],
        joke: json['value'],
      );
    } else {
      print(response.statusCode);

      return ChuckJoke();
    }
  }
}
