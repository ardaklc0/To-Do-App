import 'package:flutter/material.dart';

class GorevlerRepository {
    List<Gorev> gorevler = [
      Gorev("Lorem ipsum dolor sit amet", DateTime.utc(2023, 2, 23), "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt", "", "Yazılım"),
      Gorev("Lorem ipsum dolor sit amet", DateTime.utc(2023, 2, 23), "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt", "", "Almanca"),
      Gorev("Lorem ipsum dolor sit amet", DateTime.utc(2023, 2, 23), "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt", "", "Google"),


    ];

    Set<Gorev> favoriGorevler = {};


  void favoriyeEkle(Gorev gorev, bool favorideMi) {
    if (favorideMi) {
      favoriGorevler.add(gorev);
    } else {
      favoriGorevler.remove(gorev);
    }
  }

  bool favorideMi(Gorev gorev) {
    return favoriGorevler.contains(gorev);
  }


}

class Gorev {
  String ad;
  DateTime date;
  String ayrinti;
  String altgorev;
  String kategori;

  Gorev(this.ad, this.date, this.ayrinti, this.altgorev, this.kategori);

  @override
  String toString() {
    return '${ad}';
  }
}