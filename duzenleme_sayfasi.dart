import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/pages/takvim_sayfasi.dart';
import 'package:todo_app/repository/gorevler_repository.dart';


class DuzenlemeSayfasi extends StatefulWidget {
  final String kategori;
  final GorevlerRepository gorevlerRepository;
  final Gorev gorev;
  Set<String> kategoriListesi = {};
  Function baslikDegistir;
  Function ayrintiDegistir;
  Function tarihDegistir;
  Function gorevEkle;

  DuzenlemeSayfasi(this.kategori, this.gorevlerRepository, this.gorev, this.baslikDegistir, this.ayrintiDegistir, this.tarihDegistir, this.gorevEkle, {Key? key}) : super(key: key);


  @override
  State<DuzenlemeSayfasi> createState() => _DuzenlemeSayfasiState();
}


class _DuzenlemeSayfasiState extends State<DuzenlemeSayfasi> {
  TextEditingController baslikKontrolcusu = TextEditingController();
  TextEditingController ayrintiKontrolcusu = TextEditingController();


  Set<String> kategoriListesiniAl(){
    for(String kategori in widget.gorevlerRepository.gorevler.map((e) => e.kategori)) {
      widget.kategoriListesi.add(kategori);
    };
    return widget.kategoriListesi;
  }

  late List<String> kategoriListesi = kategoriListesiniAl().toList();
  late String dropDownValue = widget.kategori;

  @override
  void initState() {
    super.initState();
    baslikKontrolcusu.text = widget.gorev.ad;
    ayrintiKontrolcusu.text = widget.gorev.ayrinti;
  }

  @override
  void dispose(){
    baslikKontrolcusu.dispose();
    ayrintiKontrolcusu.dispose();
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
              padding: EdgeInsets.all(16.0),
              child: DropdownButton(
                icon: Icon(Icons.arrow_drop_down_circle),
                elevation: 16,
                underline: Container(
                  height: 1,
                  color: Colors.black
                ),
                value: dropDownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropDownValue = newValue!;
                    widget.gorev.kategori = dropDownValue;
                  });
                },
                items: kategoriListesi.map((valueItem) {
                  return DropdownMenuItem<String>(
                      value: valueItem,
                      child: Text(valueItem)
                  );
                }).toList(),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 310,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25.0)
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          controller: baslikKontrolcusu,
                          onChanged: (value) {
                            setState(() {
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                        )
                      ),
                      child: Text("Bitir"),
                      onPressed: () {
                        widget.baslikDegistir(widget.gorev.ad, baslikKontrolcusu.text);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 310,
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(25.0)
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          controller: ayrintiKontrolcusu,
                          onChanged: (value) {
                            setState(() {
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)
                          )
                      ),
                      child: Text("Bitir"),
                      onPressed: () {
                        widget.ayrintiDegistir(widget.gorev.ayrinti, ayrintiKontrolcusu.text);
                      },
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
                )
              ),
              child: Text("Takvimi ayarla"),
              onPressed: () {
                takvimSayfasinaGit();
              },
            ),
          ],
        ),
      ),
    );
  }

  void seciliGunuAl (yeniGun) {
    widget.gorev.date = yeniGun;
  }

  Future<void> takvimSayfasinaGit() async{
    await Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => TakvimSayfasi(
              widget.gorev.date,
              widget.tarihDegistir,
        ),
      ),
    );
  }
}

