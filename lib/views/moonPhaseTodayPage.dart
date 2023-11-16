import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/MoonPhase.dart';

class MoonPhaseTodayPage extends StatefulWidget {
  MoonPhaseTodayPage({Key? key, required this.moonPhase}) : super(key: key);
  MoonPhase moonPhase;

  @override
  State<MoonPhaseTodayPage> createState() => _MoonPhaseTodayPageState();
}

class _MoonPhaseTodayPageState extends State<MoonPhaseTodayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sky.jpg'),
            fit: BoxFit.cover,
            opacity: 0.6,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Data: ${DateFormat('dd/MM/yyyy').format(widget.moonPhase.data)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  'Dia lunar Conway: ${widget.moonPhase.diaLunarConway}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                  ),
                ),
                Text(
                    'Fase da lua (provável) Conway: ${widget.moonPhase.fase_lua}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                    )),
                const SizedBox(height: 16),
                Image.asset(widget.moonPhase.imagem),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
