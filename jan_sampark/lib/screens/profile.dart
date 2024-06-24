import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCDDFE2),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          title: Text('Profile'),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: const Color.fromARGB(255, 8, 4, 4),
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'My Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                    child: _buildProfileButton(context, Icons.edit,
                        'Edit Profile', EditProfilePage())),
                SizedBox(width: 16),
                Expanded(
                    child: _buildProfileButton(context, Icons.share,
                        'Share Profile', ShareProfilePage())),
              ],
            ),
            SizedBox(height: 16),
            _buildProfileButton(
                context, Icons.assignment, 'My Grievances', MyGrievancesPage()),
            SizedBox(height: 16),
            _buildProfileButton(
                context, Icons.settings, 'Settings', SettingsPage()),
            SizedBox(height: 16),
            _buildProfileButton(context, Icons.account_box, 'Account Details',
                AccountDetailsPage()),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileButton(
      BuildContext context, IconData icon, String label, Widget page) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          minimumSize: Size(double.infinity, 50),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCDDFE2),
      appBar: AppBar(
        title: Text('Edit Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildEditButton(context, 'Change Profile Picture'),
            SizedBox(height: 16),
            _buildEditButton(context, 'Change Password'),
            SizedBox(height: 16),
            _buildEditButton(context, 'Verify Email'),
            SizedBox(height: 16),
             _buildEditButton(context, 'Username'),
          
          ],
        ),
      ),
    );
  }

  Widget _buildEditButton(BuildContext context, String label) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        minimumSize: Size(double.infinity, 50),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}

class ShareProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCDDFE2),
      appBar: AppBar(
        title: Text('Share Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Text(
          'Share Profile Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class MyGrievancesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCDDFE2),
      appBar: AppBar(
        title: Text('My Grievances'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Text(
          'My Grievances Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isSwitched = true;

  Widget _buildSettingsItem(BuildContext context, IconData icon, String label, {Widget? trailing}) {
  return Container(
    height: 60,
    child: ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Icon(icon, size: 20),
      ),
      title: Text(label, style: TextStyle(fontSize: 16), textAlign: TextAlign.left),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: trailing ?? Icon(Icons.arrow_forward_ios, size: 14),
      ),
      onTap: () {},
      contentPadding: EdgeInsets.symmetric(vertical: 4.0),
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCDDFE2),
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: _buildSettingsItem(
                  context, Icons.language, 'Language Preferences'),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: _buildSettingsItem(
                  context, Icons.notifications, 'Notifications',
                  trailing: Switch(
                      value: _isSwitched,
                      onChanged: (bool value) {
                        setState(() {
                          _isSwitched = value;
                        });
                      })),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: _buildSettingsItem(
                  context, Icons.lock, 'Two-Factor Authentication'),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: _buildSettingsItem(context, Icons.help, 'Help'),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: _buildSettingsItem(context, Icons.security, 'Security'),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: _buildSettingsItem(context, Icons.settings, 'Preferences'),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCDDFE2),
      appBar: AppBar(
        title: Text('Account Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildAccountDetailField(context, Icons.email, 'Email'),
            _buildAccountDetailField(context, Icons.person, 'Name'),
            _buildAccountDetailField(context, Icons.person, 'Gender'),
            _buildAccountDetailField(context, Icons.phone, 'Phone Number'),
            _buildAccountDetailField(context, Icons.location_pin, 'Pincode'),
            _buildAccountDetailField(
                context, Icons.credit_card, 'Aadhar Card Number'),
            _buildAccountDetailField(
                context, Icons.how_to_vote, 'Voter ID Number'),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountDetailField(
      BuildContext context, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
