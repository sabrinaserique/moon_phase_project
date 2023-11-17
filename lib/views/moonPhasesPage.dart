import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../models/MoonPhase.dart';
import '../widgets/moonPhase_List_Item.dart';

class MoonPhasesPage extends StatefulWidget{
  MoonPhasesPage({super.key, required this.moonPhases});
  List<MoonPhase> moonPhases;

  @override
  State<MoonPhasesPage> createState() => _MoonPhasesPageState();
}

class _MoonPhasesPageState extends State<MoonPhasesPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
            decoration: BoxDecoration(
                color: HexColor('#121423')
            ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (MoonPhase phase in widget.moonPhases)
                        MoonPhaseListItem(
                          moonPhase: phase,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
  }
}