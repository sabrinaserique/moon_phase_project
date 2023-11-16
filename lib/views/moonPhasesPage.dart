import 'package:flutter/material.dart';
import '../models/MoonPhase.dart';
import '../widgets/moonPhase_List_Item.dart';

class MoonPhasesPage extends StatefulWidget{
  MoonPhasesPage({Key? key, required this.moonPhases}) : super(key: key);
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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/icone.jpg'),
              fit: BoxFit.cover,
              opacity: 0.6,
            ),
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