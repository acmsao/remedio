import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'db_firestore.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseFirestore db = DbFirestore.get();

  @override
  Widget build(BuildContext context) {
    var snapshot =
        FirebaseFirestore.instance.collection('Medicamento').snapshots();
    var item = FirebaseFirestore.instance.collection('Medicamento');

    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.medication),
          backgroundColor: Colors.black,
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(children: [
          Center(child: Image.asset('lib/imagens/Univesp.jpg')),
          Container(
            padding: const EdgeInsets.only(top: 20),
            color: Colors.white.withOpacity(0.8),
            child: StreamBuilder(
              stream: snapshot,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Erro ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("Lista Vazia"));
                }

                final itens = snapshot.requireData;

                return ListView.separated(
                    itemBuilder: (context, i) {
                      return Container(
                        color: Colors.black.withOpacity(0.7),
                        padding: const EdgeInsets.all(2),
                        child: ListTile(
                          leading: Text("${itens.docs[i]['remedio']}",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white)),
                          title: Center(
                            child: Text(
                                'Primeiro horario:   ${itens.docs[i]['horario']}',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ),
                          subtitle: Center(
                            child: Text(
                              'Intervalo:   ${itens.docs[i]['intervalo']} horas',
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              item.doc(itens.docs[i].id).delete();
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                          height: 12,
                          color: Colors.red,
                          thickness: 5,
                        ),
                    itemCount: itens.size);
              },
            ),
          ),
        ]));
  }
}
