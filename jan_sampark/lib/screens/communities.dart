import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CommunitiesPage(),
    );
  }
}

// Models (replace with your actual grievance and community data structures)
class Community {
  final String name;
  final String imageUrl; // Optional: URL for community image

  Community(this.name, {required this.imageUrl});
}

class Grievance {
  final String title;
  final String location; // Optional: Location of grievance
  final int upvotes;

  Grievance(this.title, this.location, this.upvotes);
}

// Functions to fetch trending data (replace with your app's implementation)
List<Community> getTrendingCommunities() {
  // Fetch trending communities from your app's data source
  // ... (implementation details)
  return [
    Community("Community A", imageUrl: "https://via.placeholder.com/120"),
    Community("Community B", imageUrl: "https://via.placeholder.com/120"),
    Community("Community C", imageUrl: "https://via.placeholder.com/120"),
    Community("Community D", imageUrl: "https://via.placeholder.com/120"),
    Community("Community E", imageUrl: "https://via.placeholder.com/120"),
  ];
}

List<Grievance> getTrendingGrievances() {
  // Fetch trending grievances from your app's data source
  // ... (implementation details)
  return [
    Grievance("Allegation of corruption/malpractices", "Hyderabad", 150),
    Grievance("Allegation of harassment/misbehavior", "Hyderabad", 120),
    Grievance("Central Govt: Miscellaneous", "Hyderabad", 100),
    Grievance("Civic amenities/Quality of service", "Hyderabad", 200),
    Grievance("Compensations/Refunds", "Hyderabad", 90),
    Grievance("Delay in decision/implementation of decision", "Hyderabad", 80),
    Grievance("Law & Order", "Hyderabad", 170),
    Grievance("Legal Redress", "Hyderabad", 60),
    Grievance("Requests", "Hyderabad", 140),
    Grievance("Retirement dues", "Hyderabad", 50),
    Grievance("Revenue/Land/Tax", "Hyderabad", 110),
    Grievance("Scheduled castes/STs/Backward", "Hyderabad", 130),
    Grievance("Service matters", "Hyderabad", 70),
    Grievance("Social Evils", "Hyderabad", 190),
    Grievance("State Govt: Miscellaneous", "Hyderabad", 40),
  ];
}

// Widget for section headers
class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Widget for trending community cards
class TrendingCommunityCard extends StatelessWidget {
  final Community community;

  const TrendingCommunityCard({Key? key, required this.community})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Container(
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(community.imageUrl), // Handle optional image
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    community.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  ElevatedButton(
                    onPressed: () {
                      // Handle joining/following community functionality
                    },
                    child: Text('Join'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 24),
                      textStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for trending grievance cards
class TrendingGrievanceCard extends StatelessWidget {
  final Grievance grievance;

  const TrendingGrievanceCard({Key? key, required this.grievance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: EdgeInsets.all(8.0),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://via.placeholder.com/50"), // Placeholder image
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        title: Text(
          grievance.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, size: 14),
                SizedBox(width: 4),
                Text(grievance.location),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.thumb_up, size: 14),
                SizedBox(width: 4),
                Text('${grievance.upvotes} upvotes'),
              ],
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          // Navigate to grievance details
        },
      ),
    );
  }
}

// Main community page
class CommunitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Community> trendingCommunities = getTrendingCommunities();
    List<Grievance> trendingGrievances = getTrendingGrievances();

    return Scaffold(
      appBar: AppBar(
        title: Text('Community Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trending Communities Section
            SectionHeader(title: 'Trending Communities'),
            Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: trendingCommunities.length, // Number of trending communities
                itemBuilder: (context, index) {
                  return TrendingCommunityCard(
                    community: trendingCommunities[index],
                  );
                },
              ),
            ),
            // Trending Grievances Section
            SectionHeader(title: 'Trending Grievances'),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: trendingGrievances.length, // Number of trending grievances
              itemBuilder: (context, index) {
                return TrendingGrievanceCard(
                  grievance: trendingGrievances[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
