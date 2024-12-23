import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:moviles_2024/provider/test_provider.dart';
import 'package:moviles_2024/screens/movies_screen.dart';
import 'package:moviles_2024/screens/profile_screen.dart';
import 'package:moviles_2024/screens/settings_screen.dart';
import 'package:moviles_2024/settings/color_settings.dart';
import 'package:moviles_2024/settings/global_values.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {

   final testprovider = Provider.of<TestProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSettings.navColor,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.access_alarm)),
          GestureDetector(
              onTap: () {},
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Image.asset('assets/icon_sonic.png'),
              ))
        ],
      ),
      body: Builder(builder: (context) {
        switch (index) {
          case 1:
            return ProfileScreen();
          case 2:
          // Lógica para cerrar sesión
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _logout();
            });
            return Container();
          default:
            return ProfileScreen();
        }
      }),
      //endDrawer: Drawer(),
      drawer: myDrawer(testprovider),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.person, title: 'Profile'),
          TabItem(icon: Icons.exit_to_app, title: 'Exit'),
        ],
        onTap: (int i) {
          setState(() {
            index = i; // Actualizar el índice
          });
        },
      ),

      floatingActionButtonLocation:  ExpandableFab.location,
      floatingActionButton:ExpandableFab(
        key: _key,
        children: [
          FloatingActionButton.small(
             heroTag: "btn1",
            onPressed: (){
              GlobalValues.banthemeDark.value = false;
            },
            child:const Icon(Icons.light_mode)
            ),
          FloatingActionButton.small(
            heroTag: "btn2",
            onPressed: (){
              GlobalValues.banthemeDark.value = true;
            },
            child: const Icon(Icons.dark_mode) ,)
          
        ]),

    );
  }

    void _logout() {
    // Lógica para cerrar sesión, por ejemplo, navegar a la pantalla de inicio de sesión
    Navigator.of(context).pushReplacementNamed('/login');
  }

  Widget myDrawer(TestProvider testprovider){
      return Drawer(
        child: ListView(
          children: [
             UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzoEHXyPFTvvqwFKKMX9XqrHlbPu4m1PG3KQ&s'),
              ),
              accountName: Text(testprovider.name), 
              accountEmail: Text('antuan@hotmail.com')
              ),
              ListTile(
                onTap: () => Navigator.pushNamed(context,'/firebaseMovie'),
                title:  Text('Movies List'),
                subtitle:  Text('Database of movies'),
                leading: Icon(Icons.movie),//lado izquierdo,
                trailing: Icon(Icons.chevron_right), //lado derecho
              ),
                ListTile(
                onTap: () => Navigator.pushNamed(context,'/settings'),
                title:  Text('Theme settings'),
                subtitle:  Text('personalizar'),
                leading: Icon(Icons.palette),//lado izquierdo,
                trailing: Icon(Icons.chevron_right), //lado derecho
              ),
                ListTile(
                onTap: () => Navigator.pushNamed(context,'/popularMovies'),
                title:  Text('pellculas populares'),
                leading: Icon(Icons.movie_creation),//lado izquierdo,
                trailing: Icon(Icons.chevron_right), //lado derecho
              ),
                ListTile(
                onTap: () => Navigator.pushNamed(context,'/favoriteMovies'),
                title:  Text('pellculas favoritas'),
                leading: Icon(Icons.favorite),//lado izquierdo,
                trailing: Icon(Icons.chevron_right), //lado derecho
              ),
          ],
          
        ),
      );
    }
}
