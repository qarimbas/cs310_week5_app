import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CS310'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pageController.jumpToPage(0);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey,
        child: Container(height: 50),
      ),
      body: PageView(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        children: [
          dummyContainer(),
          dummyRow(),
          dummyWrap(),
          tableBuilder(),
        ],
      ),
    );
  }

  Widget dummyContainer() {
    return Container(
      height: 64,
      width: 64,
      color: Colors.yellow,
    );
  }

  Widget dummyRow() {
    return Row(
      children: [
        dummyContainer(),
        dummyContainer(),
        dummyContainer(),
        dummyContainer(),
        dummyContainer(),
        dummyContainer(),
        dummyContainer(),
      ],
    );
  }

  Widget dummyWrap() {
    return Wrap(
      alignment: WrapAlignment.center,
      direction: Axis.horizontal,
      spacing: 2,
      runSpacing: 4,
      children: [
        dummyContainer(),
        dummyContainer(),
        dummyContainer(),
        dummyContainer(),
        dummyContainer(),
        dummyContainer(),
        dummyContainer(),
        dummyContainer(),
        dummyContainer(),
        dummyContainer(),
        dummyContainer(),
        dummyContainer(),
      ],
    );
  }

  Widget tableBuilder() {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      defaultColumnWidth: FlexColumnWidth(1.0),
      border: TableBorder.all(
        color: Colors.grey.shade600,
        width: 1.0,
      ),
      children: [
        TableRow(children: [
          dummyContainer(),
          dummyContainer(),
        ]),
        TableRow(children: [
          dummyWrap(),
          Container(),
        ]),
      ],
    );
  }
}
