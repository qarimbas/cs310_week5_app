import 'package:cs310_lecture9/loading.dart';
import 'package:cs310_lecture9/message_box.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final pageController = PageController();

  bool _isSelected = false;
  int widthCounter = 10;
  bool loading = true;

  void _increment() {
    setState(() {
      widthCounter += 10;
    });
  }

  Future<void> loadPageData() async {
    Future.delayed(Duration(seconds: 10), () {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadPageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CS310'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          _increment();
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey,
        child: Container(height: 50),
      ),
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            children: [
              messageViewSetup(),
              animatedWrap(),
              dummyContainer(),
              dummyRow(),
              dummyWrap(),
              tableBuilder(),
              chipList(),
            ],
          ),
          if (loading) Loading(),
        ],
      ),
    );
  }

  Widget messageViewSetup() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MessageBox(),
      ],
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
      labelStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
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

  Widget myInputChip(String title, Color color) {
    return InputChip(
      label: Text(title),
      labelStyle: TextStyle(
        color: _isSelected ? Colors.white : Colors.grey,
        fontWeight: FontWeight.bold,
      ),
      labelPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      backgroundColor: color.withAlpha(128),
      selectedColor: color,
      elevation: 6,
      shadowColor: color.withAlpha(200),
      avatar: CircleAvatar(
        backgroundColor: Colors.white70,
        child: Text(
          title[0].toUpperCase(),
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
      selected: _isSelected,
      onSelected: (bool selected) {
        setState(() {
          _isSelected = selected;
        });
      },
      deleteIcon: _isSelected ? Icon(Icons.cancel) : Icon(Icons.add),
      deleteIconColor: Colors.white70,
      onDeleted: () {
        if (_isSelected) {
          print('$title delete');
        } else {
          setState(() {
            _isSelected = true;
          });
        }
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
        myChip('Hacker', Color(0xFF007F5c)),
        myChip('Developer', Color(0xff3a829c)),
        myChip('Racer', Color(0xFF19ca21)),
        myChip('Traveller', Color(0xFF60230b)),
        myInputChip('CS310 Student', Color(0xffc85909)),
      ],
    );
  }

  Widget animatedWrap() {
    return Wrap(
      alignment: WrapAlignment.start,
      children: [
        AnimatedContainer(
          duration: Duration(seconds: 1),
          height: 64,
          width: (5 * widthCounter) % (MediaQuery.of(context).size.width),
          color: Colors.blue,
          curve: Curves.easeInOut,
        ),
      ],
    );
  }
}
