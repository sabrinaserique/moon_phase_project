import 'package:flutter/material.dart';
import 'package:moon_phase_project/views/moonPhaseTodayPage.dart';
import 'package:moon_phase_project/views/moonPhasesPage.dart';
import 'models/Moon.dart';
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
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Hoje'),
                Tab(text: 'Próximos 30 dias'),
              ],
            ),
            title: const Text('Fases da Lua'),
          ),
          body: TabBarView(
            children: [
              MoonPhaseTodayPage(moonPhase: printLunarTodayAnalysis()),
              MoonPhasesPage(moonPhases: printLunarAnalysis()),
            ],
          ),
        ),
      ),
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

Moon getMoonPhaseConway(int lunarDay) {
  if (lunarDay <= 28) {
    if (lunarDay >= 24) {
      return Moon(fase_lua: 'Minguante', imagem: 'assets/images/minguante.jpg');
    }
    if (lunarDay >= 22) {
      return Moon(
          fase_lua: 'Quarto Minguante',
          imagem: 'assets/images/quartoMinguante.jpg');
    }
    if (lunarDay >= 17) {
      return Moon(
          fase_lua: 'Minguante Gibosa',
          imagem: 'assets/images/minguanteGibosa.jpg');
    }
    if (lunarDay >= 14) {
      return Moon(fase_lua: 'Lua Cheia', imagem: 'assets/images/luaCheia.jpg');
    }
    if (lunarDay >= 9) {
      return Moon(
          fase_lua: 'Crescente Gibosa',
          imagem: 'assets/images/crescenteGibosa.jpg');
    }
    if (lunarDay >= 7) {
      return Moon(
          fase_lua: 'Quarto Crescente',
          imagem: 'assets/images/quartoCrescente.jpg');
    }
    if (lunarDay >= 2) {
      return Moon(fase_lua: 'Crescente', imagem: 'assets/images/crescente.jpg');
    }
  }
  return Moon(
      fase_lua: 'Lua Nova', imagem: 'assets/images/luaNova.jpg'); //0,1,29
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
  Moon luaFase;
  int lunarDayConway;
  List<MoonPhase> list = [];
  MoonPhase lua;

  DateTime dia = now;
  dia = dia.add(Duration(days: 1));

  while (dia.isBefore(endDate)) {
    lunarDayConway = getLunarDayConway(dia);
    luaFase = getMoonPhaseConway(lunarDayConway);

    lua = MoonPhase(
        fase_lua: luaFase.fase_lua,
        data: dia,
        diaLunarConway: lunarDayConway,
        imagem: luaFase.imagem);

    list.add(lua);

    dia = dia.add(Duration(days: 1));
  }

  return list;
}

MoonPhase printLunarTodayAnalysis() {
  DateTime now = DateTime.now();
  int lunarDayConway;

  DateTime dia = now;

  lunarDayConway = getLunarDayConway(dia);
  Moon lua = getMoonPhaseConway(lunarDayConway);
  MoonPhase luaFase = MoonPhase(
      fase_lua: lua.fase_lua,
      data: dia,
      diaLunarConway: lunarDayConway,
      imagem: lua.imagem);

  return luaFase;
}
