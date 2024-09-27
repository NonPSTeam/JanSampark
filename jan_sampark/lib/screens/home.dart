import 'package:flutter/material.dart';
import 'package:jan_sampark/screens/comment.dart';
import 'contacts.dart';
import 'communities.dart';
import 'gpost.dart';
import 'profile.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;
  List<Map<String, dynamic>> _localGrievances = [];
  
    final List<Map<String, dynamic>> _grievances = [
    {
      'title': 'Water logging issues in several areas after heavy rains.',
      'location': 'Hyderabad, Telangana',
      'description':
          'Several areas in Hyderabad have been experiencing severe water logging after the recent heavy rains. This has caused major inconvenience to residents, leading to traffic jams and difficulties in commuting. Immediate action is required to improve drainage systems in these areas to prevent further issues.',
      'comments': ['This needs urgent attention!', 'I faced the same issue today.'],
      'upvotes': 0,
      'downvotes': 0,
    },
    {
      'title': 'Law and order situation deteriorating in certain neighborhoods.',
      'location': 'Hyderabad, Telangana',
      'description':
          'Residents in certain neighborhoods of Hyderabad have reported a noticeable increase in criminal activities, including theft and vandalism. The community is feeling unsafe and is urging local authorities to increase police patrolling and take necessary measures to ensure safety.',
      'comments': ['We need more police presence.', 'Something must be done about this.'],
      'upvotes': 0,
      'downvotes': 0,
    },
    {
      'title': 'Fallen trees blocking roads and causing inconvenience.',
      'location': 'Hyderabad, Telangana',
      'description':
          'After a recent storm, several trees have fallen, blocking main roads and causing significant inconvenience to commuters. The debris has also damaged some properties and vehicles. It is crucial that the local authorities clear the fallen trees and ensure the roads are accessible again.',
      'comments': ['This is causing major traffic delays.', 'We need quick action on this.'],
      'upvotes': 0,
      'downvotes': 0,
    },
  ];
  void _onItemTapped(int index) {
    if (index == 3) {
      // When "Post" is tapped, navigate to GPostPage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GPostPage(
            onGrievanceSubmitted: _addNewGrievance,
          ),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _addNewGrievance(Map<String, dynamic> grievance) {
    setState(() {
      _localGrievances.insert(0, grievance);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCDDFE2),
      body: _getSelectedPage(),
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
          _buildBottomNavigationBarItem(Icons.post_add, 'Post', 3),
          _buildBottomNavigationBarItem(Icons.person, 'Profile', 4),
        ],
      ),
    );
  }

  Widget _getSelectedPage() {
    final List<Widget> _pages = [
      ContactPage(),
      CommunitiesPage(),
      _buildHomePageContent(), // Current HomePage content
      GPostPage(onGrievanceSubmitted: _addNewGrievance),
      ProfilePage(),
    ];
    return _pages[_selectedIndex];
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
            const Text(
              'YOUR GRIEVANCES',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            for (var grievance in _localGrievances) _buildGrievanceBox(grievance),
            const SizedBox(height: 20),
            const Text(
              'AROUND YOU',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            for (var grievance in _grievances) _buildGrievanceBoxx(grievance),
          ],
        ),
      ),
    );
  }

  Widget _buildGrievanceBox(Map<String, dynamic> grievance) {
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
            'Type: ${grievance['type'] ?? ''}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            grievance['description'] ?? '',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(grievance['timestamp'] ?? '')),
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          // Displaying comments
          if (grievance['comments'] != null && grievance['comments'].isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: grievance['comments'].map<Widget>((comment) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    comment,
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    ),
  );
}

Widget _buildGrievanceBoxx(Map<String, dynamic> grievance) {
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
            grievance['title'] ?? '',
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.thumb_up_alt_outlined),
                    onPressed: () {
                      setState(() {
                        grievance['upvotes']++;
                      });
                    },
                  ),
                  Text(grievance['upvotes'].toString()),
                  IconButton(
                    icon: Icon(Icons.thumb_down_alt_outlined),
                    onPressed: () {
                      setState(() {
                        grievance['downvotes']++;
                      });
                    },
                  ),
                  Text(grievance['downvotes'].toString()),
                ],
              ),
              IconButton(
                icon: Icon(Icons.comment_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommentPage(grievance: grievance),
                    ),
                  );
                },
              ),
              Icon(Icons.share_outlined),
            ],
          ),
          const SizedBox(height: 10),
          // Displaying comments below the title and buttons
          if (grievance['comments'] != null && grievance['comments'].isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: grievance['comments'].map<Widget>((comment) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    comment,
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
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
}


void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
