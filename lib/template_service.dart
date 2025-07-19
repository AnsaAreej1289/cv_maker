// lib/template_service.dart

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'cv_template_models.dart'; // Ensure this path is correct and file is error-free

class TemplateService {
  static Future<List<CvTemplate>> loadTemplates() async {
    // ignore: avoid_print
    print('TemplateService: Starting to load templates...'); // Debug print

    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      // ignore: avoid_print
      print('TemplateService: AssetManifest.json loaded and decoded.'); // Debug print

      final templatePaths = manifestMap.keys
          .where((String key) => key.startsWith('assets/templates/') && key.endsWith('.json'))
          .toList();

      // ignore: avoid_print
      print('TemplateService: Found ${templatePaths.length} potential template paths.'); // Debug print
      for (var path in templatePaths) {
        // ignore: avoid_print
        print('TemplateService: Potential template path: $path'); // Debug print
      }


      final List<CvTemplate> templates = [];
      for (String path in templatePaths) {
        try {
          final String jsonString = await rootBundle.loadString(path);
          // ignore: avoid_print
          print('TemplateService: Loaded JSON string from $path.'); // Debug print
          final Map<String, dynamic> jsonMap = json.decode(jsonString);
          templates.add(CvTemplate.fromJson(jsonMap));
          // ignore: avoid_print
          print('TemplateService: Successfully parsed $path.'); // Debug print
        } catch (e) {
          // ignore: avoid_print
          print('TemplateService ERROR: Failed to load or parse template from $path: $e'); // Critical debug print
          // Optionally, add more robust error logging or skip problematic files
        }
      }
      // ignore: avoid_print
      print('TemplateService: Finished loading templates. Total loaded: ${templates.length}'); // Debug print
      return templates;
    } catch (e) {
      // ignore: avoid_print
      print('TemplateService CRITICAL ERROR: Error loading AssetManifest.json or initial setup: $e'); // Critical debug print
      return []; // Return empty list on critical failure
    }
  }
}