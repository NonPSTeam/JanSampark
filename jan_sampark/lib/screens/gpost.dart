import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class GPostPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onGrievanceSubmitted;

  GPostPage({required this.onGrievanceSubmitted});

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
    'Maharashtra',
    'Delhi',
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
      appBar: AppBar(
        title: Text('Grievance Upload'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdownField(
                title: 'Type Of Grievance',
                value: _selectedGrievanceType,
                items: grievanceTypes,
                onChanged: (value) {
                  setState(() {
                    _selectedGrievanceType = value;
                  });
                },
              ),
              _buildDropdownField(
                title: 'State',
                value: _selectedState,
                items: states,
                onChanged: (value) {
                  setState(() {
                    _selectedState = value;
                  });
                },
              ),
              _buildDropdownField(
                title: 'District',
                value: _selectedDistrict,
                items: districts,
                onChanged: (value) {
                  setState(() {
                    _selectedDistrict = value;
                  });
                },
              ),
              _buildDropdownField(
                title: 'Grievance Category/Ministry',
                value: _selectedCategory,
                items: categories,
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              _buildDropdownField(
                title: 'Grievance Concerns to?',
                value: _selectedConcern,
                items: concerns,
                onChanged: (value) {
                  setState(() {
                    _selectedConcern = value;
                  });
                },
              ),
              _buildTextField(),
              _buildPDFPicker(),
              _buildImagePicker(),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String title,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        DropdownButtonFormField<String>(
          value: value,
          hint: Text('Select $title'),
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Type Your Grievance Here',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
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
      ],
    );
  }

  Widget _buildPDFPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attach Your PDF File (Optional)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ElevatedButton.icon(
          onPressed: _pickPDF,
          icon: Icon(Icons.attach_file),
          label: Text('Attach PDF'),
        ),
        if (_selectedPDF != null)
          Text('Selected PDF: ${_selectedPDF!.path}'),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload Images here',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ElevatedButton.icon(
          onPressed: _pickImages,
          icon: Icon(Icons.image),
          label: Text('Upload Images'),
        ),
        if (_selectedImages.isNotEmpty)
          Wrap(
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
          ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Create a grievance object with the user's input
          Map<String, dynamic> grievance = {
            'type': _selectedGrievanceType,
            'description': _grievanceController.text,
            'timestamp': DateTime.now().toIso8601String(),
            // Add other relevant fields if necessary
          };

          // Call the callback function to send the grievance to HomePage
          widget.onGrievanceSubmitted(grievance);

          // Show a popup message
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Grievance Uploaded'),
                content: Text('Your grievance has been uploaded successfully.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(); // Return to HomePage
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );

          // Clear the input field
          _grievanceController.clear();
        },
        child: Text('SUBMIT'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GPostPage(
      onGrievanceSubmitted: (grievance) {
        // Handle the submitted grievance here
        print(grievance);
      },
    ),
  ));
}
