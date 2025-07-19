// lib/templates_screen.dart

// lib/templates_screen.dart

import 'package:flutter/material.dart';
import 'cv_template_models.dart';
import 'template_service.dart';
import 'template_editor_screen.dart';
import 'cv_display_widget.dart'; // Still imports directly from lib/

// ... (rest of your TemplatesScreen code as provided previously))

class TemplatesScreen extends StatefulWidget {
  const TemplatesScreen({super.key});

  @override
  State<TemplatesScreen> createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends State<TemplatesScreen> {
  late Future<List<CvTemplate>> _templatesFuture;

  @override
  void initState() {
    super.initState();
    print('TemplatesScreen: Initializing state...');
    _templatesFuture = TemplateService.loadTemplates();
  }

  @override
  Widget build(BuildContext context) {
    print('TemplatesScreen: Building widget tree.');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Template', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black54),
      ),
      body: FutureBuilder<List<CvTemplate>>(
        future: _templatesFuture,
        builder: (context, snapshot) {
          print('TemplatesScreen FutureBuilder: ConnectionState: ${snapshot.connectionState}, HasError: ${snapshot.hasError}, HasData: ${snapshot.hasData}');

          if (snapshot.connectionState == ConnectionState.waiting) {
            print('TemplatesScreen FutureBuilder: Waiting for data...');
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('TemplatesScreen FutureBuilder ERROR: ${snapshot.error}');
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error loading templates: ${snapshot.error}\n'
                      'Please check your JSON files and pubspec.yaml assets.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red[700], fontSize: 16),
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print('TemplatesScreen FutureBuilder: No data or empty list. Data length: ${snapshot.data?.length ?? 0}');
            return const Center(child: Text('No templates found. Please add JSON files to assets/templates/.'));
          } else {
            final List<CvTemplate> templates = snapshot.data!;
            print('TemplatesScreen FutureBuilder: Successfully loaded ${templates.length} templates. Displaying GridView.');
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.7, // Adjust this as needed for your miniature CVs
              ),
              itemCount: templates.length,
              itemBuilder: (context, index) {
                final template = templates[index];
                return TemplatePreviewCard(
                  template: template,
                  onTap: () {
                    // Navigate to editor screen, passing the selected template
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TemplateEditorScreen(
                          template: template,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class TemplatePreviewCard extends StatelessWidget {
  final CvTemplate template;
  final VoidCallback onTap;

  const TemplatePreviewCard({
    super.key,
    required this.template,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3, // Allocate most space to the CV preview
              child: Center(
                // Use the CvDisplayWidget here with a scale factor
                child: FittedBox(
                  fit: BoxFit.contain, // Ensures the CV fits within the card
                  child: SizedBox(
                    width: 300, // Define a base width for the full CV
                    height: 400, // Define a base height for the full CV
                    child: CvDisplayWidget(
                      template: template,
                      scale: 0.5, // Adjust this scale factor to fit the preview card
                    ),
                  ),
                ),
              ),
            ),
            // Bottom section for template name and description (remains the same)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    template.metadata.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    template.metadata.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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