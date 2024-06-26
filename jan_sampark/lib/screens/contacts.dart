import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SearchBox(),
            SizedBox(height: 16),
            ContactCard(
              title: 'Hyderabad Metropolitan Water Supply and Sewage Board',
              issues: ['Water Logging', 'Waste Management', 'Damaged Roads', 'Increase in Street Dogs', 'Fallen Trees'],
            ),
            ContactCard(
              title: 'Hyderabad City Police',
              issues: ['Law & Order', 'Traffic Management', 'Crime Reporting', 'Community Policing', 'Emergency Services'],
            ),
            ContactCard(
              title: 'Telangana State Southern Power Distribution Company Limited',
              issues: ['Power Outages', 'Billing Issues', 'Meter Readings', 'New Connections', 'Disconnections'],
            ),
            ContactCard(
              title: 'GHMC',
              issues: ['Water Logging', 'Waste Management', 'Damaged Roads', 'Increase in Street Dogs', 'Fallen Trees'],
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
          icon: Icon(Icons.search),
        ),
      ),
    );
  }
}

class ContactCard extends StatefulWidget {
  final String title;
  final List<String> issues;

  const ContactCard({Key? key, required this.title, required this.issues}) : super(key: key);

  @override
  _ContactCardState createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  bool _isExpanded = false;

  void _showContactDetails(BuildContext context, String issue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(issue),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Contact: +91-123-456-7890'),
              Text('Email: example@example.com'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2.0,
      child: ExpansionTile(
        title: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        initiallyExpanded: _isExpanded,
        onExpansionChanged: (bool expanded) {
          setState(() => _isExpanded = expanded);
        },
        children: widget.issues
            .map((issue) => ListTile(
                  title: Text(issue),
                  leading: Icon(Icons.chevron_right),
                  onTap: () {
                    _showContactDetails(context, issue);
                  },
                ))
            .toList(),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ContactPage(),
  ));
}
