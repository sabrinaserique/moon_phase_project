import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moon_phase_project/views/moonPhaseTodayPage.dart';
import 'package:moon_phase_project/views/moonPhasesPage.dart';

import '../models/Moon.dart';
import '../models/MoonPhase.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor('#474753'),
          centerTitle: true,
          leading: const BackButton(
            color: Colors.white,
          ),
          bottom: TabBar(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              labelColor: Colors.blueGrey.shade900,
              unselectedLabelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.white),
              tabs: const [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Hoje"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Próximos 30 dias"),
                    ),
                  ),
                ]
          ),
          title: const Text(
                  'Fases da Lua',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                  )
              ),
        ),
        body: TabBarView(
          children: [
            MoonPhaseTodayPage(moonPhase: printLunarTodayAnalysis()),
            MoonPhasesPage(moonPhases: printLunarAnalysis()),
          ],
        ),
      ),
    );
  }
}
//Funções
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
      return Moon(fase_lua: 'Minguante', imagem: '../assets/images/moons/minguante.png');
    }
    if (lunarDay >= 22) {
      return Moon(
          fase_lua: 'Quarto Minguante',
          imagem: '../assets/images/moons/quartoMinguante.png');
    }
    if (lunarDay >= 17) {
      return Moon(
          fase_lua: 'Minguante Gibosa',
          imagem: '../assets/images/moons/minguanteGibosa.png');
    }
    if (lunarDay >= 14) {
      return Moon(fase_lua: 'Lua Cheia', imagem: '../assets/images/moons/luaCheia.png');
    }
    if (lunarDay >= 9) {
      return Moon(
          fase_lua: 'Crescente Gibosa',
          imagem: '../assets/images/moons/crescenteGibosa.png');
    }
    if (lunarDay >= 7) {
      return Moon(
          fase_lua: 'Quarto Crescente',
          imagem: '../assets/images/moons/quartoCrescente.png');
    }
    if (lunarDay >= 2) {
      return Moon(fase_lua: 'Crescente', imagem: '../assets/images/moons/crescente.png');
    }
  }
  return Moon(
      fase_lua: 'Lua Nova', imagem: '../assets/images/moons/luaNova.png'); //0,1,29
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
