import 'package:flutter/material.dart';
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
  final List<Widget> _pages = [
    ContactPage(),
    CommunitiesPage(),
    HomePage(),
    GPostPage(),
    ProfilePage(),
  ];

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
          _buildBottomNavigationBarItem(Icons.post_add, 'Post', 3),
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
                width: 500,
                height: 200,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Center(
                  child: Text(
                    'GRIEVANCES',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'AROUND YOU',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            for (var grievance in _grievances) _buildGrievanceBox(grievance),
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
            grievance['title'],
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
        ],
      ),
    ),
  );
}
}

class GrievanceDetailsPage extends StatelessWidget {
  final Map<String, dynamic> grievance;

  GrievanceDetailsPage({required this.grievance});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grievance Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${grievance['title']}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Description: ${grievance['description']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Comments:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...(grievance['comments'] as List<dynamic>? ?? [])
                .map<Widget>((comment) => Text(comment.toString()))
                .toList(),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
class CommentPage extends StatefulWidget {
  final Map<String, dynamic> grievance;

  CommentPage({required this.grievance});

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController _commentController = TextEditingController();
  List<Map<String, dynamic>> comments = [];

  @override
  void initState() {
    super.initState();
    // Add some sample comments
    comments = [
      {
        'author': 'John Doe',
        'handle': '@johndoe',
        'text': 'This is a serious issue that needs immediate attention!',
        'timestamp': DateTime.now().subtract(Duration(hours: 2)),
        'impressions': 152,
        'reposts': 3,
        'isReposted': false,
        'isSaved': false,
      },
      {
        'author': 'Jane Smith',
        'handle': '@janesmith',
        'text': 'I have faced the same problem in my area. We need a long-term solution.',
        'timestamp': DateTime.now().subtract(Duration(hours: 1)),
        'impressions': 87,
        'reposts': 1,
        'isReposted': false,
        'isSaved': false,
      },
      {
        'author': 'Alex Johnson',
        'handle': '@alexj',
        'text': 'Has anyone reached out to the local authorities about this?',
        'timestamp': DateTime.now().subtract(Duration(minutes: 30)),
        'impressions': 45,
        'reposts': 0,
        'isReposted': false,
        'isSaved': false,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildOriginalPost(),
                Divider(height: 1, color: Colors.grey[300]),
                ...comments.map(_buildCommentTile).toList(),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),
          _buildCommentInput(),
        ],
      ),
    );
  }

  Widget _buildOriginalPost() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, color: Colors.white),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Grievance Connect', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('@grievanceconnect', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            widget.grievance['title'],
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 12),
          Text(
            widget.grievance['description'],
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildIconButton(Icons.comment_outlined, widget.grievance['comments'].length.toString(), () {}),
              _buildIconButton(Icons.repeat, '0', () {}),
              _buildIconButton(Icons.bar_chart, '0', () {
                _showInsightsDialog(context, widget.grievance);
              }),
              _buildIconButton(Icons.bookmark_border, '', () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommentTile(Map<String, dynamic> comment) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: Text(comment['author'][0], style: TextStyle(color: Colors.black)),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(comment['author'], style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 4),
                        Text(comment['handle'], style: TextStyle(color: Colors.grey)),
                        Spacer(),
                        Text(
                          DateFormat('h:mm a').format(comment['timestamp']),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(comment['text']),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildIconButton(Icons.comment_outlined, '', () {
                          _replyToComment(comment);
                        }),
                        _buildIconButton(
                          comment['isReposted'] ? Icons.repeat : Icons.repeat_outlined,
                          comment['reposts'].toString(),
                          () {
                            setState(() {
                              comment['isReposted'] = !comment['isReposted'];
                              comment['reposts'] += comment['isReposted'] ? 1 : -1;
                            });
                          },
                        ),
                        _buildIconButton(Icons.bar_chart, comment['impressions'].toString(), () {
                          _showInsightsDialog(context, comment);
                        }),
                        _buildIconButton(
                          comment['isSaved'] ? Icons.bookmark : Icons.bookmark_border,
                          '',
                          () {
                            setState(() {
                              comment['isSaved'] = !comment['isSaved'];
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(height: 1, color: Colors.grey[300]),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, String count, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          SizedBox(width: 4),
          Text(count, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, color: Colors.grey[600]),
          ),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Post your reply',
                border: InputBorder.none,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (_commentController.text.isNotEmpty) {
                setState(() {
                  comments.add({
                    'author': 'You',
                    'handle': '@user',
                    'text': _commentController.text,
                    'timestamp': DateTime.now(),
                    'impressions': 0,
                    'reposts': 0,
                    'isReposted': false,
                    'isSaved': false,
                  });
                  _commentController.clear();
                });
              }
            },
            child: Text('Post', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  void _replyToComment(Map<String, dynamic> comment) {
    _commentController.text = '${comment['handle']} ';
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _showInsightsDialog(BuildContext context, Map<String, dynamic> post) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Insights'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Impressions: ${post['impressions']}'),
              SizedBox(height: 8),
              Text('Reposts: ${post['reposts']}'),
              SizedBox(height: 8),
              Text('Comments: ${post['comments'] != null ? post['comments'].length : 0}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}