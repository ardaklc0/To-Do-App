import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TakvimSayfasi extends StatefulWidget {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime gorevDate;
  Function tarihDegistir;

  TakvimSayfasi(this.gorevDate, this.tarihDegistir, {Key? key}) : super(key: key);

  @override
  State<TakvimSayfasi> createState() => _TakvimSayfasiState();
}

class _TakvimSayfasiState extends State<TakvimSayfasi> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(1900, 1, 1),
              lastDay: DateTime.utc(2100, 12, 30),
              focusedDay: widget._focusedDay,
              calendarFormat: widget._calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(widget._selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(widget._selectedDay, selectedDay)) {
                  setState(() {
                    widget._selectedDay = selectedDay;
                    widget._focusedDay = focusedDay;
                    print(widget._focusedDay);
                  });
                }
              },
              onFormatChanged: (format) {
                if (widget._calendarFormat != format) {
                  setState(() {
                    widget._calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                widget._focusedDay = focusedDay;
              },
            ),
            ElevatedButton(
              child: Text("Tarihi değiştir"),
              onPressed: () {
                widget.tarihDegistir(widget.gorevDate, widget._focusedDay);
              },
            ),
          ],
        ),
      ),
    );
  }
}
