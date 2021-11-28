import 'package:flutter/material.dart';
import 'package:remedio/adicionar.dart';
import 'package:remedio/myhomepage.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final pageViewController = PageController();

  void disposed() {
    super.dispose();
    pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageViewController,
        children: const [
          MyHomePage(title: "Controle de Medicamentos"),
          Adicionar()
        ],
      ),
      bottomNavigationBar: AnimatedBuilder(
          animation: pageViewController,
          builder: (context, snapshot) {
            return BottomNavigationBar(
                selectedItemColor: Colors.blue[900],
                unselectedItemColor: Colors.blue[200],
                backgroundColor: Colors.black,
                currentIndex: pageViewController.page?.round() ?? 0,
                onTap: (index) {
                  pageViewController.jumpToPage(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Principal',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_rounded),
                    label: 'Adicionar',
                  )
                ]);
          }),
    );
  }
}
