import 'package:flutter/material.dart';
import 'contacts.dart';
import 'communities.dart';
import 'gpost.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2; 
  final List<Widget> _pages = [
    ContactPage(),
    CommunitiesPage(),
    HomePage(),
    GPostPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCDDFE2),
      body: _selectedIndex == 2 ? _buildHomePageContent() : _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          _buildBottomNavigationBarItem(Icons.contact_page, 'Contact', 0),
          _buildBottomNavigationBarItem(Icons.group, 'Communities', 1),
          _buildBottomNavigationBarItem(Icons.home, 'Home', 2),
          _buildBottomNavigationBarItem(Icons.post_add, 'GPost', 3),
          _buildBottomNavigationBarItem(Icons.person, 'Profile', 4),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: _selectedIndex == index
          ? Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade300,
                  ),
                ),
                Icon(icon, color: Colors.blue),
              ],
            )
          : Icon(icon),
      label: label,
    );
  }

  Widget _buildHomePageContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const Center(
              child: Text(
                'Welcome! User',
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                width:500,
                height:200,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Text(
                  'GRIEVANCES',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'AROUND YOU',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            _buildInputBox(
              'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
            ),
            _buildInputBox(
              'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.',
            ),
            _buildInputBox(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBox(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.thumb_up_alt_outlined),
                Icon(Icons.thumb_down_alt_outlined),
                Icon(Icons.comment_outlined),
                Icon(Icons.share_outlined),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
