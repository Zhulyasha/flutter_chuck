import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChuckJoke {
  String imageUrl;
  String joke;

  ChuckJoke({
    this.imageUrl = 'https://picsum.photos/250?image=9',
    this.joke = 'Awesome joke',
  });
}
