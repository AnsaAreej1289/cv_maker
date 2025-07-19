// lib/template_editor_screen.dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import ImagePicker
import 'cv_template_models.dart';
import 'cv_display_widget.dart'; // Assuming this displays the CV
// You might need a service to save/update CVs if you're persisting changes
// import 'cv_service.dart'; // If you have a service for saving/loading user CVs

class TemplateEditorScreen extends StatefulWidget {
  final CvTemplate template;

  const TemplateEditorScreen({super.key, required this.template});

  @override
  State<TemplateEditorScreen> createState() => _TemplateEditorScreenState();
}

class _TemplateEditorScreenState extends State<TemplateEditorScreen> {
  // Use a mutable variable to hold the current template data
  // This will allow us to update specific fields like profileImagePath
  late CvTemplate _currentTemplate;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _currentTemplate = widget.template; // Initialize with the passed template
  }

  // Function to pick an image
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        // Update the profileImagePath in the current template's defaultData
        // Create new instances of immutable classes to reflect the change
        _currentTemplate = _currentTemplate.copyWith(
          defaultData: _currentTemplate.defaultData.copyWith(
            profileImagePath: image.path, // Use the picked image's path
          ),
        );
      });
      // Optionally: save the updated template immediately or on 'Save' button click
      // if (mounted && _cvService != null) {
      //   _cvService.saveCv(_currentTemplate);
      // }
    }
  }

  // Function to remove the image
  void _removeImage() {
    setState(() {
      _currentTemplate = _currentTemplate.copyWith(
        defaultData: _currentTemplate.defaultData.copyWith(
          profileImagePath: null, // Set path to null to remove
        ),
      );
    });
    // Optionally: save the updated template immediately or on 'Save' button click
    // if (mounted && _cvService != null) {
    //   _cvService.saveCv(_currentTemplate);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${widget.template.metadata.name}'),
        actions: [
          // Add a Save button if you want to explicitly save changes
          // IconButton(
          //   icon: const Icon(Icons.save),
          //   onPressed: () {
          //     // Save _currentTemplate to persistence (e.g., local storage, database)
          //     // Navigator.pop(context, _currentTemplate); // Pass back the updated template
          //   },
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Your existing CV Display Widget
              Center(
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 400, // Adjust size as needed for viewing
                      height: 550, // Adjust size as needed for viewing
                      child: CvDisplayWidget(
                        template: _currentTemplate, // Use _currentTemplate
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Profile Image Controls
              Text(
                'Profile Image',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image),
                    label: const Text('Add/Change Image'),
                  ),
                  const SizedBox(width: 10),
                  if (_currentTemplate.defaultData.profileImagePath != null && _currentTemplate.defaultData.profileImagePath!.isNotEmpty)
                    ElevatedButton.icon(
                      onPressed: _removeImage,
                      icon: const Icon(Icons.delete),
                      label: const Text('Remove Image'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Style for remove button
                        foregroundColor: Colors.white,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),

              // Add other editable fields here, e.g., using TextFormFields
              // For example, to edit name:
              Text(
                'Personal Details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextFormField(
                initialValue: _currentTemplate.defaultData.name,
                decoration: const InputDecoration(labelText: 'Full Name'),
                onChanged: (newName) {
                  setState(() {
                    _currentTemplate = _currentTemplate.copyWith(
                      defaultData: _currentTemplate.defaultData.copyWith(
                        name: newName,
                      ),
                    );
                  });
                },
              ),
              TextFormField(
                initialValue: _currentTemplate.defaultData.title,
                decoration: const InputDecoration(labelText: 'Title/Profession'),
                onChanged: (newTitle) {
                  setState(() {
                    _currentTemplate = _currentTemplate.copyWith(
                      defaultData: _currentTemplate.defaultData.copyWith(
                        title: newTitle,
                      ),
                    );
                  });
                },
              ),
              // Add similar TextFormFields for summary, contact details, etc.
              // Remember to create copyWith methods for nested objects like Contact, Experience, Education.
              // For lists (experiences, education, skills), you'll need more complex UI (e.g., list views with add/remove buttons for items).
            ],
          ),
        ),
      ),
    );
  }
}