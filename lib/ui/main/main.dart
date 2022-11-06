import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoned/ui/feeds/create_feeds_viewmodel.dart';
import 'package:zoned/ui/home/home_viewmodel.dart';
import 'package:zoned/ui/main/main_viewmodel.dart';
import 'package:zoned/ui/map/maps_viewmodel.dart';
import 'package:zoned/ui/profile/profile_viewmodel.dart';

import '../../firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => MainViewModel()),
        ChangeNotifierProvider(create: (_) => CreateFeedsViewModel()),
        ChangeNotifierProvider(create: (_) => MapsViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
      ],
      child: MaterialApp(
        title: 'Zone D',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zone D'),
      ),
      body: Consumer<MainViewModel>(
        builder: (context, viewModel, _) {
          return Center(
            child: viewModel.autoSelectPage(),
          );
        },
      ),
      bottomNavigationBar: Consumer<MainViewModel>(
        builder: (context, viewModel, _) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Maps',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.create_new_folder),
                label: 'Create Feed',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded),
                label: 'Profile',
              ),
            ],
            currentIndex: viewModel.selectedIndex,
            selectedItemColor: Colors.amber[800],
            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey,
            onTap: viewModel.onItemTapped,
          );
        },
      ),
    );
  }
}
