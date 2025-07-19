// lib/home_screen.dart

import 'package:flutter/material.dart';
import 'templates_screen.dart'; // Import the TemplatesScreen

class CvMakerHomeScreen extends StatelessWidget {
  const CvMakerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light grey background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // No shadow
        toolbarHeight: 70, // Slightly taller app bar
        title: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'CV Maker',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black54, size: 28),
            onPressed: () {
              // Handle settings tap (e.g., show a snackbar or navigate to settings screen)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings tapped!')),
              );
            },
          ),
          const SizedBox(width: 16), // Padding on the right
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row for Create New and Templates cards
            Row(
              children: [
                Expanded(
                  child: _buildFeatureCard(
                    context,
                    title: 'Create New',
                    description: 'Create your resume like a professional',
                    iconPath: 'assets/images/create_new_icon.png', // Replace with your asset
                    iconBackgroundColor: const Color(0xFFE0F7FA), // Light blue-green
                    cardColor: Colors.white,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Create New tapped! (Functionality not implemented yet)')),
                      );
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNewScreen()));
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildFeatureCard(
                    context,
                    title: 'Templates',
                    description: 'Select templates and create resume',
                    iconPath: 'assets/images/templates_illustration.jpg', // Replace with your asset
                    iconBackgroundColor: Colors.grey[200]!, // Light grey for templates
                    cardColor: Colors.white,
                    isImage: true, // Indicates it's a full illustration image
                    onTap: () {
                      // Navigate to the TemplatesScreen when this card is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TemplatesScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // My Creation Card (occupies full width)
            _buildFeatureCard(
              context,
              title: 'My Creation',
              description: 'Modify and share your creations',
              iconPath: 'assets/images/my_creation_icon.png', // Replace with your asset
              iconBackgroundColor: const Color(0xFFFFEBEE), // Light red-orange
              cardColor: Colors.white,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('My Creation tapped! (Functionality not implemented yet)')),
                );
                // Navigator.push(context, MaterialPageRoute(builder: (context) => MyCreationScreen()));
              },
            ),
            const SizedBox(height: 32),

            // Drafts Section Header
            const Padding(
              padding: EdgeInsets.only(left: 8.0, bottom: 12.0),
              child: Text(
                'Draft',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            // John Doe CV Draft Item
            _buildDraftItem(
              context,
              cvName: 'John Doe CV',
              updatedDate: '8-29-2023',
              creationDate: '8-25-2023',
              thumbnailPath: 'assets/images/john_doe_cv_thumbnail.png', // Replace with your asset
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('John Doe CV tapped! (Functionality not implemented yet)')),
                );
                // Navigator.push(context, MaterialPageRoute(builder: (context) => CvDetailScreen(cvName: 'John Doe CV')));
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build feature cards
  Widget _buildFeatureCard(
      BuildContext context, {
        required String title,
        required String description,
        required String iconPath,
        required Color iconBackgroundColor,
        required Color cardColor,
        bool isImage = false, // True if the iconPath is a full illustration
        VoidCallback? onTap,
      }) {
    return Card(
      color: cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: isImage ? double.infinity : 60, // Adjust width based on type
                height: isImage ? 80 : 60, // Adjust height based on type
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: isImage
                      ? Image.asset(iconPath, fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.image_not_supported, size: 40, color: Colors.grey[400]);
                  })
                      : Image.asset(iconPath, width: 40, height: 40, errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error, size: 40, color: Colors.red);
                  }), // Adjust size for icons
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build a draft item
  Widget _buildDraftItem(
      BuildContext context, {
        required String cvName,
        required String updatedDate,
        required String creationDate,
        required String thumbnailPath,
        VoidCallback? onTap,
      }) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // CV Thumbnail
              Container(
                width: 60,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200], // Placeholder background
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    thumbnailPath, // Your CV thumbnail image
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.description, size: 40, color: Colors.grey); // Fallback icon
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // CV Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cvName,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Updated : $updatedDate',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      creationDate,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}