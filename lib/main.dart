import 'package:flutter/material.dart';
import 'package:moon_phase_project/views/moonPhasesPage.dart';

import 'models/MoonPhase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MoonPhasesPage(moonPhases: printLunarAnalysis()),
    );
  }
}

const int synodicPeriod = 2551442877; //29.530588854 days

var knownLuaNova = DateTime.parse("1970-01-07T00:00:00.000Z");

int getLunarDay(DateTime dia) {
  Duration diff = dia.difference(knownLuaNova); // Diferença em milliseconds
  final lunarDay =
      Duration(milliseconds: diff.inMilliseconds % synodicPeriod).inDays;
  return lunarDay;
}

String getMoonPhaseConway(int lunarDay) {
  if (lunarDay <= 28) {
    if (lunarDay >= 24) {
      return "Minguante";
    }
    if (lunarDay >= 22) {
      return "Quarto Minguante";
    }
    if (lunarDay >= 17) {
      return "Minguante Gibosa";
    }
    if (lunarDay >= 14) {
      return "Lua Cheia";
    }
    if (lunarDay >= 9) {
      return "Crescente Gibosa";
    }
    if (lunarDay >= 7) {
      return "Quarto Crescente";
    }
    if (lunarDay >= 2) {
      return "Crescente";
    }
  }
  return "Lua Nova"; //0,1,29
}

int getLunarDayConway(DateTime ldt) {
  int year = ldt.year;
  int month = ldt.month;
  int day = ldt.day;

  if (year < 1900 || year >= 2100)
    throw Exception("Date must be greater than 1900 and less than 2100");

  double centS = -4.0;
  if (year > 2000) {
    centS = -8.3;
  }
  double lastTwoDigits = year % 100.0;
  double vl = lastTwoDigits % 19;
  if (vl > 9) {
    vl -= 19.0;
  }
  vl *= 11.0;
  vl %= 30;
  vl += centS;

  vl += month + day;
  if (month < 3) {
    vl += 2;
  }

  vl = vl % 30;
  return ((vl < 0) ? vl + 30 : vl).round();
}

List<MoonPhase> printLunarAnalysis() {
  DateTime now = DateTime.now();
  DateTime endDate = now.add(const Duration(days: 30));
  String nomeLua;
  int lunarDayConway;
  List<MoonPhase> list =[];

  DateTime dia = now;

  while(dia.isBefore(endDate)) {
    lunarDayConway = getLunarDayConway(dia);
    nomeLua = getMoonPhaseConway(lunarDayConway);
    MoonPhase lua = MoonPhase(fase_lua: nomeLua, data: dia, diaLunarConway: lunarDayConway);

    list.add(lua);

    dia = dia.add(Duration(days: 1));
  }

  return list;
}


