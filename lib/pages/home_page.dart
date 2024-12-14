import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Updated naming for clarity
  final List<Widget> _pages = [
    const StorePage(),
    const CartPage(),
    const FavoritesPage(),
    const AccountPage(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'My Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'My Account',
          ),
        ],
        selectedItemColor: Colors.purpleAccent,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        type: BottomNavigationBarType.fixed, // Changed for consistent color
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      systemOverlayStyle:
          SystemUiOverlayStyle.light, // Sets the system UI overlay
      elevation: 0, // Removes shadow
      backgroundColor: Colors.purpleAccent,
      automaticallyImplyLeading: false, // Removes default back button
      title: const Text(
        "Tiny Grove UK",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {
            // Add functionality for notifications here
          },
          color: Colors.white,
        ),
        const SizedBox(width: 10),
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            // Add functionality for shopping cart here
          },
          color: Colors.white,
        ),
      ],
    );
  }
}

// Placeholder pages
class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Store Page'),
    );
  }
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Cart Page'),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Favorites Page'),
    );
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Account Page'),
    );
  }
}
