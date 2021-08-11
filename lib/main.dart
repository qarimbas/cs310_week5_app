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
          pageController.nextPage(
              duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
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
          chipList(),
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
    return SingleChildScrollView(
      child: Wrap(
        alignment: WrapAlignment.center,
        direction: Axis.horizontal,
        spacing: 40,
        runSpacing: 40,
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
      ),
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

  Widget myChip(String title, Color color) {
    return Chip(
      label: Text(title),
      labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      labelPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      backgroundColor: color,
      elevation: 6,
      shadowColor: color.withAlpha(200),
      avatar: CircleAvatar(
        backgroundColor: Colors.white70,
        child: Text(
          title[0].toUpperCase(),
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
      deleteIcon: Icon(Icons.cancel),
      deleteIconColor: Colors.white70,
      onDeleted: () {
        print('$title delete');
      },
    );
  }

  Widget chipList() {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 6,
      runSpacing: 6,
      children: [
        myChip('Gamer', Color(0xFFff6666)),
        myChip('Hacker', Color(0xFF007f5c)),
        myChip('Developer', Color(0xFF5f65d3)),
        myChip('Racer', Color(0xFF19ca21)),
        myChip('Traveller', Color(0xFF60230b)),
      ],
    );
  }
}
