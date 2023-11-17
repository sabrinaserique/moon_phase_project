import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:styled_text/tags/styled_text_tag.dart';
import 'package:styled_text/widgets/styled_text.dart';
import '../models/MoonPhase.dart';

class MoonPhaseListItem extends StatelessWidget {
  const MoonPhaseListItem({super.key, required this.moonPhase});
  final MoonPhase moonPhase;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: HexColor('#474753'),
        ),
        margin: const EdgeInsets.symmetric(vertical: 2),
        // separa os elementos da lista
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      StyledText(
                        text: '<title>Data:</title> <value>${DateFormat('dd/MM/yyyy').format(moonPhase.data)}</value>',
                        tags: {
                          'title': StyledTextTag(
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: HexColor('#9b9ca1'),
                            ),
                          ),
                          'value': StyledTextTag(
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white
                              )
                          )
                        },
                      ),
                      StyledText(
                        text: '<title>Dia lunar:</title>  <value>${moonPhase.diaLunarConway}</value>',
                        tags: {
                          'title': StyledTextTag(
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: HexColor('#9b9ca1'),
                            ),
                          ),
                          'value': StyledTextTag(
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white
                              )
                          )
                        },
                      ),
                      StyledText(
                          text: '<title>Fase da lua (provável):</title> <value>${moonPhase.fase_lua}</value>',
                        tags: {
                          'title': StyledTextTag(
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: HexColor('#9b9ca1'),
                            ),
                          ),
                          'value': StyledTextTag(
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white
                              )
                          )
                        },
                      ),
                    ],
                  ),
            ),
            Column(
              children: [
                Image.asset(
                  moonPhase.imagem,
                  height: 50,
                  width: 50,
                  fit: BoxFit.scaleDown,
                ),
              ],
            ),
          ],
        ),
    );
  }
}
