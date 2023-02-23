import 'package:flutter/material.dart';
import 'package:todo_app/pages/duzenleme_sayfasi.dart';
import 'package:todo_app/pages/gorev_sayfasi.dart';
import 'package:todo_app/repository/gorevler_repository.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(title: "To-Do List"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GorevlerRepository gorevlerRepository = GorevlerRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          gorevEklemeSayfasinaGit();
        },
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => GorevSatiri(
                      gorevlerRepository.gorevler[index],
                      gorevlerRepository,
                      index,
                      sil,
                      baslikDegistir,
                      ayrintiDegistir,
                      tarihDegistir,
                      gorevEkle
                  ),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: gorevlerRepository.gorevler.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> gorevEklemeSayfasinaGit() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GorevSayfasi(
          gorevEkle
        ),
      ),
    );
  }

  void sil(Gorev gorev) {
    setState(() {
      gorevlerRepository.gorevler.remove(gorev);
    });
  }

  void gorevEkle(String gorevAd, DateTime gorevTarihi, String gorevAyrinti, String gorevAlt, String gorevKategori) {
    gorevlerRepository.gorevler.add(
        Gorev(
            gorevAd,
            gorevTarihi,
            gorevAyrinti,
            gorevAlt,
            gorevKategori
      )
    );
  }

  void baslikDegistir(String eskiBaslik, String yeniBaslik) {
    final index = gorevlerRepository.gorevler.indexWhere((element) =>
      element.ad == eskiBaslik);
    setState(() {
      gorevlerRepository.gorevler[index].ad = yeniBaslik;
    });
  }

  void ayrintiDegistir(String eskiAyrinti, String yeniAyrinti) {
    final index = gorevlerRepository.gorevler.indexWhere((element) =>
      element.ayrinti == eskiAyrinti);
    setState(() {
      gorevlerRepository.gorevler[index].ayrinti = yeniAyrinti;
    });
  }

  void tarihDegistir(DateTime eskiTarih, DateTime yeniTarih) {
    final index = gorevlerRepository.gorevler.indexWhere((element) =>
      element.date == eskiTarih);
    setState(() {
      gorevlerRepository.gorevler[index].date = yeniTarih;
    });
  }


}

class GorevSatiri extends StatefulWidget {
  final Gorev gorev;
  final GorevlerRepository gorevlerRepository;
  final int index;
  final Function sil;
  final Function baslikDegistir;
  final Function ayrintiDegistir;
  final Function tarihDegistir;
  final Function gorevEkle;

  GorevSatiri(
      this.gorev,
      this.gorevlerRepository,
      this.index,
      this.sil,
      this.baslikDegistir,
      this.ayrintiDegistir,
      this.tarihDegistir,
      this.gorevEkle,
      {Key? key}) : super(key: key);
  @override
  State<GorevSatiri> createState() => _GorevSatiriState();
}

class _GorevSatiriState extends State<GorevSatiri> {


  @override
  Widget build(BuildContext context) {
    bool favorideMi = widget.gorevlerRepository.favorideMi(widget.gorev);
    return ListTile(
      key: ValueKey(widget.index),
      onTap: () {
        duzenlemeSayfasinaGit();
      },
      subtitle: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.gorev.ayrinti,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.gorev.date.toString().
              replaceAll("-", ".").
              substring(0,10),
            ),
          )
        ],
      ),
      title: Text(
        "${widget.gorev.ad}",
        overflow: TextOverflow.ellipsis,
      ),
      leading: IconButton(
        icon: Icon(Icons.radio_button_unchecked),
        onPressed: () {
          setState(() {
            widget.sil(widget.gorev);
          });
        },
      ),
      trailing: IconButton(
        icon: Icon(favorideMi ? Icons.favorite : Icons.favorite_outline),
        onPressed: () {
          widget.gorevlerRepository.favoriyeEkle(
              widget.gorev,
              !favorideMi
          );
          setState(() {
          });
        },
      ),
    );
  }



  Future<void> duzenlemeSayfasinaGit() async {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => DuzenlemeSayfasi(
              widget.gorev.kategori,
              widget.gorevlerRepository,
              widget.gorev,
              widget.baslikDegistir,
              widget.ayrintiDegistir,
              widget.tarihDegistir,
              widget.gorevEkle
        ),
      ),
    );
  }
}

