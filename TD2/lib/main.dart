import 'package:flutter/material.dart';
import 'package:td2/addTask.dart';
import 'package:td2/main.dart';
import 'package:td2/models/task.dart';
import 'package:td2/settingsViewModel.dart';
import 'mytheme.dart';
import './futureBuilder.dart';
import './card2.dart';
import './settings.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_){
              SettingViewModel settingViewModel = SettingViewModel();
              //getSettings est deja appelee dans le constructeur
              return settingViewModel;
            }),
        ChangeNotifierProvider(
            create:(_){
              TaskViewModel taskViewModel = TaskViewModel();
              taskViewModel.generateTasks();
              return taskViewModel;
            } )
      ],
      child: Consumer<SettingViewModel>(
        builder: (context,SettingViewModel notifier,child){
          return MaterialApp(
              theme: notifier.isDark ? MyTheme.dark():MyTheme.light(),
              title: 'TD2',
              home: MyHomePage()
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    MyListWidget(),
    Ecran2(),
    Ecran3(),
    EcranSettings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TD2'),
        titleTextStyle: MyTheme.darkTextTheme.displayLarge,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.blue,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex==0?FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => AddTask(),
          )
          );
        },
        child: const Icon(Icons.add),):const SizedBox.shrink(),
    );
  }
}

class MyTextWidget extends StatelessWidget {
  final String text;
  final Color color;

  const MyTextWidget({Key? key, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: MyTheme.darkTextTheme.titleLarge,
        ),
      ),
    );
  }
}

class MyListWidget extends StatelessWidget {
  late List<Task> tasks; //= Task.generateTask(50);
  String tags='';
  @override
  Widget build(BuildContext context) {
    tasks = context.watch<TaskViewModel>().liste;
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.purple,
          child: Center(child: Text('Entry ${tasks[index].id}')),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}