import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Adicionar extends StatefulWidget {
  const Adicionar({Key? key}) : super(key: key);

  @override
  _AdicionarState createState() => _AdicionarState();
}

class _AdicionarState extends State<Adicionar> {
  var snapshot = FirebaseFirestore.instance.collection('Medicamento');

  var remedio = TextEditingController();
  var primeiro = TextEditingController();
  var intervalo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Adionar novo remédio'),
        leading: const Icon(Icons.add),
      ),
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Image.asset('lib/imagens/Univesp.jpg'),
        Container(
          color: Colors.white.withOpacity(0.8),
          child: Column(
            children: [
              TextFormField(
                controller: remedio,
                decoration: const InputDecoration(
                  icon: Icon(Icons.medication_outlined),
                  labelText: 'Remédio',
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.datetime,
                controller: primeiro,
                decoration: const InputDecoration(
                  icon: Icon(Icons.timer_rounded),
                  labelText: 'Primeiro horário',
                ),
              ),
              TextFormField(
                controller: intervalo,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  icon: Icon(Icons.av_timer_rounded),
                  labelText: 'Intervalo',
                ),
              ),
              const Padding(padding: EdgeInsets.all(30)),
              ElevatedButton.icon(
                onPressed: () {
                  
                  snapshot.add({
                    'remedio': remedio.text,
                    'horario': primeiro.text,
                    'intervalo': intervalo.text
                  });
                  remedio.clear();
                  primeiro.clear();
                  intervalo.clear();
                },
                icon: const Icon(Icons.add),
                label: const Text('Adicionar'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.red,
                  fixedSize: const Size(150, 50),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
