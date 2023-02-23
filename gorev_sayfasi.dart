import 'package:flutter/material.dart';

class GorevSayfasi extends StatefulWidget {
  Function gorevEkle;

  GorevSayfasi(this.gorevEkle, {Key? key}) : super(key: key);

  @override
  State<GorevSayfasi> createState() => _GorevSayfasiState();
}

class _GorevSayfasiState extends State<GorevSayfasi> {
  TextEditingController gorevAdiKontrolcusu = TextEditingController();
  TextEditingController gorevAyrintiKontrolcusu = TextEditingController();
  TextEditingController gorevAltGorev = TextEditingController();
  TextEditingController gorevKategori = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    gorevAdiKontrolcusu.dispose();
    gorevAyrintiKontrolcusu.dispose();
    gorevAltGorev.dispose();
    gorevKategori.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Göreve başlık ekleyin',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0)
                  ),
                ),
                controller: gorevAdiKontrolcusu,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Göreve ayrıntı ekleyin',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0)
                  ),
                ),
                controller: gorevAyrintiKontrolcusu,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Göreve alt göre ekle',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0)
                  )
                ),
                controller: gorevAltGorev,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Göreve kategori ekle',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0)
                  )
                ),
                controller: gorevKategori,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      )
                  ),
                  child: Text("Bitir"),
                  onPressed: () {
                    setState(() {
                      widget.gorevEkle(
                          gorevAdiKontrolcusu.text,
                          DateTime.utc(2023, 1, 1),
                          gorevAyrintiKontrolcusu.text,
                          gorevAltGorev.text,
                          "232"
                      );
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
