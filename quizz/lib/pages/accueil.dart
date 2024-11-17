import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Accueil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade400,
        actions: [],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: size.height / 3,
              child: Card(
                  elevation: 8,
                  child: Padding(
                    padding: EdgeInsets.all(1),
                    child: Row(mainAxisSize: MainAxisSize.max, children: [
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.bar_chart_sharp,
                              size: size.height / 4,
                            ),
                            Text('12000 points')
                          ],
                        ),
                      ),
                      Spacer(),
                      Expanded(
                          child: Column(
                        children: [
                          CircleAvatar(
                            child: Icon(
                              Icons.person,
                              size: size.height / 7,
                            ),
                            radius: size.height / 8,
                          ),
                          Text('Modou Gueye')
                        ],
                      )),
                    ]),
                  )),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Card(
                        elevation: 3,
                        child: Column(
                          children: [
                            Icon(
                              Icons.history,
                              size: 100,
                            ),
                            Text('History'),
                          ],
                        ),
                      ),
                      Card(
                        elevation: 3,
                        child: Column(
                          children: [
                            Icon(Icons.run_circle_rounded, size: 100),
                            Text('Maths'),
                          ],
                        ),
                      ),
                      Card(
                        elevation: 3,
                        child: Column(
                          children: [
                            Icon(
                              Icons.run_circle_rounded,
                              size: 100,
                            ),
                            Text('Maths'),
                          ],
                        ),
                      ),
                      Card(
                        elevation: 3,
                        child: Column(
                          children: [
                            Icon(Icons.run_circle_rounded, size: 100),
                            Text('Maths'),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ],
        ),
        padding: EdgeInsets.all(12),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_circle_filled),
        onPressed: null,
      ),
    );
  }
}
