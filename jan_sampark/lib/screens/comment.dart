import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentPage extends StatefulWidget {
  final Map<String, dynamic> grievance;
  CommentPage({required this.grievance});

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController _commentController = TextEditingController();
  List<Map<String, dynamic>> comments = [];
  String? replyingTo; // To track who the user is replying to

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
                    Text('Water Agency', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('@hydwatersupplies', style: TextStyle(color: Colors.grey)),
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
                hintText: replyingTo != null ? 'Replying to $replyingTo...' : 'Post your reply',
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
                    'handle': '@you',
                    'text': replyingTo != null 
                      ? 'Replying to $replyingTo: ${_commentController.text}' 
                      : _commentController.text,
                    'timestamp': DateTime.now(),
                    'impressions': 0,
                    'reposts': 0,
                    'isReposted': false,
                    'isSaved': false,
                  });
                  _commentController.clear();
                  replyingTo = null; // Reset after sending the comment
                });
              }
            },
            child: Text('Send'),
          ),
        ],
      ),
    );
  }

  void _replyToComment(Map<String, dynamic> comment) {
    setState(() {
      replyingTo = comment['author']; // Set who the user is replying to
      _commentController.text = ''; // Clear the input
    });
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
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
