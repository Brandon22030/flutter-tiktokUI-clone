import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const double _iconSize = 24.0;
  
  // Liste des écrans pour chaque onglet
  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(child: Text('Découvrir')),
    const SizedBox(), // Placeholder pour le bouton central (créer)
    const Center(child: Text('Boîte de réception')),
    const Center(child: Text('Profil')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontSize: 10),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        currentIndex: _selectedIndex,
        onTap: (index) {
          // Si c'est le bouton central (créer), ne changez pas l'index
          if (index == 2) {
            _showCreateOptions();
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home, size: _iconSize),
            label: 'Accueil',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search, size: _iconSize),
            label: 'Découvrir',
          ),
          BottomNavigationBarItem(
            icon: _buildCreateButton(),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.inbox, size: _iconSize),
            label: 'Boîte',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person, size: _iconSize),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  // Bouton central personnalisé pour créer du contenu
  Widget _buildCreateButton() {
    return Container(
      width: 48,
      height: 30,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blueAccent, Colors.redAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  // Afficher les options de création de contenu
  void _showCreateOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Créer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCreateOption(
                    icon: FontAwesomeIcons.camera,
                    label: 'Vidéo',
                    onTap: () {
                      Navigator.pop(context);
                      // Logique pour créer une vidéo
                    },
                  ),
                  _buildCreateOption(
                    icon: FontAwesomeIcons.photoFilm,
                    label: 'Story',
                    onTap: () {
                      Navigator.pop(context);
                      // Logique pour créer une story
                    },
                  ),
                  _buildCreateOption(
                    icon: FontAwesomeIcons.music,
                    label: 'Live',
                    onTap: () {
                      Navigator.pop(context);
                      // Logique pour démarrer un live
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // Option individuelle dans le menu de création
  Widget _buildCreateOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
