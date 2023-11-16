import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/MoonPhase.dart';

class MoonPhaseListItem extends StatelessWidget {
  const MoonPhaseListItem({Key? key, required this.moonPhase})
      : super(key: key);
  final MoonPhase moonPhase;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.black,
        ),
        margin: const EdgeInsets.symmetric(vertical: 2),
        // separa os elementos da lista
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Data: ${DateFormat('dd/MM/yyyy').format(moonPhase.data)}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            Text(
              'Dia lunar Conway: ${moonPhase.diaLunarConway}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            Text('Fase da lua (provável) Conway: ${moonPhase.fase_lua}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                )
            ),
            const SizedBox(height: 16),
            Image.asset(
              moonPhase.imagem,
              height: 50,
              width: 50,
              fit: BoxFit.scaleDown,
            ),
          ],
        ));
  }
}
