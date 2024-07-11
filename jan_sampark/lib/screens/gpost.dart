import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class GPostPage extends StatefulWidget {
  @override
  _GPostPageState createState() => _GPostPageState();
}

class _GPostPageState extends State<GPostPage> {
  String? _selectedGrievanceType;
  String? _selectedState;
  String? _selectedDistrict;
  String? _selectedCategory;
  String? _selectedConcern;
  TextEditingController _grievanceController = TextEditingController();

  List<String> grievanceTypes = [
    'Complaint',
    'Suggestion',
    'Seeking Guidance/Info'
  ];

  List<String> states = [
    'Andhra Pradesh',
    'Maharashtra','Delhi',
    'Tamil Nadu',
    'Telangana',
    'West Bengal',
    'Karnataka'
  ];

  List<String> districts = [
    'Hyderabad',
    'Vizag',
    'Chennai',
    'Mumbai',
    'Kolkata',
    'Delhi',
    'Bengaluru'
  ];

  List<String> categories = [
    'Public Services',
    'Infrastructure',
    'Healthcare',
    'Education',
    'Environment'
  ];

  List<String> concerns = [
    'Road Maintenance',
    'Water Supply',
    'Hospital Services',
    'School Facilities',
    'Pollution'
  ];

  File? _selectedPDF;
  List<File> _selectedImages = [];

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedPDF = File(result.files.single.path!);
      });
    }
  }

  Future<void> _pickImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();

    if (images != null) {
      setState(() {
        _selectedImages = images.map((image) => File(image.path)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCDDFE2),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          title: Text('Grievance Upload'),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Type Of Grievance',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: _selectedGrievanceType,
                hint: Text('Select Grievance Type'),
                onChanged: (value) {
                  setState(() {
                    _selectedGrievanceType = value;
                  });
                },
                items: grievanceTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Text('State',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: _selectedState,
                hint: Text('Select State'),
                onChanged: (value) {
                  setState(() {
                    _selectedState = value;
                  });
                },
                items: states.map((state) {
                  return DropdownMenuItem(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Text('District',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: _selectedDistrict,
                hint: Text('Select District'),
                onChanged: (value) {
                  setState(() {
                    _selectedDistrict = value;
                  });
                },
                items: districts.map((district) {
                  return DropdownMenuItem(
                    value: district,
                    child: Text(district),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Text('Grievance Category/Ministry',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                hint: Text('Select Category/Ministry'),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                items: categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Text('Grievance Concerns to?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: _selectedConcern,
                hint: Text('Select Concern'),
                onChanged: (value) {
                  setState(() {
                    _selectedConcern = value;
                  });
                },
                items: concerns.map((concern) {
                  return DropdownMenuItem(
                    value: concern,
                    child: Text(concern),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Text('Type Your Grievance Here',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextField(
                controller: _grievanceController,
                maxLines: 6,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  hintText: 'Enter your grievance details',
                ),
              ),
              SizedBox(height: 16),
              Text('Attach Your PDF File',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: _pickPDF,
                icon: Icon(Icons.attach_file),
                label: Text('Attach PDF'),
              ),
              _selectedPDF != null
                  ? Text('Selected PDF: ${_selectedPDF!.path}')
                  : Container(),
              SizedBox(height: 16),
              Text('Upload Images here',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: _pickImages,
                icon: Icon(Icons.image),
                label: Text('Upload Images'),
              ),
              _selectedImages.isNotEmpty
                  ? Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: _selectedImages.map((image) {
                        return Image.file(
                          image,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        );
                      }).toList(),
                    )
                  : Container(),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle form submission
                  },
                  child: Text('SUBMIT'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GPostPage(),
  ));
}
