import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:styled_text/styled_text.dart';
import '../models/MoonPhase.dart';

class MoonPhaseTodayPage extends StatefulWidget {
  MoonPhaseTodayPage({super.key, required this.moonPhase});
  MoonPhase moonPhase;

  @override
  State<MoonPhaseTodayPage> createState() => _MoonPhaseTodayPageState();
}

class _MoonPhaseTodayPageState extends State<MoonPhaseTodayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: HexColor('#121423')
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(widget.moonPhase.imagem),
                const SizedBox(height: 20),
                StyledText(
                  text: '<title>Data:</title>  <value>${DateFormat('dd/MM/yyyy').format(widget.moonPhase.data)}</value>',
                  tags: {
                    'title': StyledTextTag(
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey,
                      ),
                    ),
                    'value': StyledTextTag(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white
                      )
                    )
                  },
                ),
                StyledText(
                  text: '<title>Dia lunar Conway:</title> <value>${widget.moonPhase.diaLunarConway}</value>',
                  tags: {
                    'title': StyledTextTag(
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey,
                      ),
                    ),
                    'value': StyledTextTag(
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white
                        )
                    )
                  },
                ),
                StyledText(
                    text: '<title>Fase da lua (provável):</title>  <value>${widget.moonPhase.fase_lua}</value>',
                    tags: {
                      'title': StyledTextTag(
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey,
                        ),
                      ),
                      'value': StyledTextTag(
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white
                          )
                      )
                    },
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
