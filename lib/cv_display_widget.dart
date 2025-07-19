// lib/cv_display_widget.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cv_template_models.dart';
import 'dart:io'; // Import for File

class CvDisplayWidget extends StatelessWidget {
  final CvTemplate template;
  final double scale;
  final File? profileImageFile; // New parameter for the picked image file

  const CvDisplayWidget({
    super.key,
    required this.template,
    this.scale = 1.0,
    this.profileImageFile, // Initialize the new parameter
  });

  @override
  Widget build(BuildContext context) {
    final double baseFontSize = 8 * scale;
    final double headingFontSize = 12 * scale;
    final double subHeadingFontSize = 10 * scale;
    final double largeHeadingFontSize = 24 * scale;
    final double padding = 12 * scale;
    final double sectionSpacing = 16 * scale;
    final double itemSpacing = 8 * scale;

    TextStyle getHeadingStyle({Color? color, double? fontSizeOverride, FontWeight? fontWeight}) {
      final String fontName = template.fonts.heading.isNotEmpty ? template.fonts.heading : 'Roboto';
      return GoogleFonts.getFont(
        fontName,
        fontSize: fontSizeOverride ?? headingFontSize,
        fontWeight: fontWeight ?? FontWeight.bold,
        color: color ?? template.colors.primary,
      );
    }

    TextStyle getBodyStyle({Color? color, double? fontSizeOverride, FontWeight? fontWeight, FontStyle? fontStyle}) {
      final String fontName = template.fonts.body.isNotEmpty ? template.fonts.body : 'Roboto';
      return GoogleFonts.getFont(
        fontName,
        fontSize: fontSizeOverride ?? baseFontSize,
        color: color ?? Colors.black87,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
      );
    }

    final Color primaryColor = template.colors.primary;
    final Color secondaryColor = template.colors.secondary;
    final Color textColor = Colors.black87;

    ImageProvider? currentProfileImage;

    // Determine which image to use: picked file, then asset, then default icon
    if (profileImageFile != null) {
      currentProfileImage = FileImage(profileImageFile!);
    } else if (template.defaultData.profileImagePath != null && template.defaultData.profileImagePath!.startsWith('assets/')) {
      // Check if it's an asset path
      currentProfileImage = AssetImage(template.defaultData.profileImagePath!);
    }
    // No else if for device path here, because profileImageFile takes precedence.

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            color: primaryColor,
            padding: EdgeInsets.symmetric(horizontal: padding * 1.5, vertical: padding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Image logic update
                if (currentProfileImage != null)
                  ClipOval(
                    child: Image(
                      image: currentProfileImage,
                      width: 80 * scale,
                      height: 80 * scale,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        debugPrint('Error loading profile image: $error');
                        return Icon(Icons.person, size: 70 * scale, color: secondaryColor);
                      },
                    ),
                  )
                else
                  Icon(Icons.person, size: 70 * scale, color: secondaryColor),
                SizedBox(width: padding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        template.defaultData.name ?? 'YOUR NAME',
                        style: getHeadingStyle(
                          fontSizeOverride: largeHeadingFontSize,
                          color: secondaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        template.defaultData.title ?? 'Your Professional Title',
                        style: getBodyStyle(
                          fontSizeOverride: headingFontSize,
                          color: secondaryColor.withOpacity(0.8),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: secondaryColor.withOpacity(0.3),
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (template.defaultData.education != null && template.defaultData.education!.isNotEmpty) ...[
                        _buildSectionHeader('EDUCATION', primaryColor, getHeadingStyle),
                        SizedBox(height: itemSpacing),
                        ...template.defaultData.education!.map((edu) => _buildEducationItem(edu, primaryColor, getBodyStyle, getHeadingStyle, subHeadingFontSize, itemSpacing)),
                        SizedBox(height: sectionSpacing),
                      ],

                      if (template.defaultData.skills != null && template.defaultData.skills!.isNotEmpty) ...[
                        _buildSectionHeader('SKILLS', primaryColor, getHeadingStyle),
                        SizedBox(height: itemSpacing),
                        ...template.defaultData.skills!.map((skill) => _buildSkillItem(skill, primaryColor, getBodyStyle, baseFontSize, scale)),
                        SizedBox(height: sectionSpacing),
                      ],

                      if (template.defaultData.languages != null && template.defaultData.languages!.isNotEmpty) ...[
                        _buildSectionHeader('LANGUAGES', primaryColor, getHeadingStyle),
                        SizedBox(height: itemSpacing),
                        ...template.defaultData.languages!.map((lang) => Text(lang, style: getBodyStyle(color: textColor))),
                        SizedBox(height: sectionSpacing),
                      ],
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(padding),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (template.defaultData.summary?.isNotEmpty == true) ...[
                          _buildSectionHeader('SUMMARY', primaryColor, getHeadingStyle),
                          SizedBox(height: itemSpacing),
                          Text(template.defaultData.summary!, style: getBodyStyle(color: textColor)),
                          SizedBox(height: sectionSpacing),
                        ],

                        if (template.defaultData.experiences != null && template.defaultData.experiences!.isNotEmpty) ...[
                          _buildSectionHeader('EXPERIENCE', primaryColor, getHeadingStyle),
                          SizedBox(height: itemSpacing),
                          ...template.defaultData.experiences!.map((exp) => _buildExperienceItem(exp, primaryColor, getBodyStyle, getHeadingStyle, subHeadingFontSize, itemSpacing, baseFontSize)),
                          SizedBox(height: sectionSpacing),
                        ],

                        if (template.defaultData.contact != null) ...[
                          _buildSectionHeader('CONTACT', primaryColor, getHeadingStyle),
                          SizedBox(height: itemSpacing),
                          if (template.defaultData.contact!.phone?.isNotEmpty == true)
                            _buildContactItem(Icons.phone, template.defaultData.contact!.phone!, primaryColor, getBodyStyle),
                          if (template.defaultData.contact!.email?.isNotEmpty == true)
                            _buildContactItem(Icons.email, template.defaultData.contact!.email!, primaryColor, getBodyStyle),
                          if (template.defaultData.contact!.website?.isNotEmpty == true)
                            _buildContactItem(Icons.public, template.defaultData.contact!.website!, primaryColor, getBodyStyle),
                          if (template.defaultData.contact!.address?.isNotEmpty == true)
                            _buildContactItem(Icons.location_on, template.defaultData.contact!.address!, primaryColor, getBodyStyle),
                          SizedBox(height: sectionSpacing),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color lineColor, TextStyle Function({Color? color, double? fontSizeOverride, FontWeight? fontWeight}) getHeadingStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: getHeadingStyle(color: lineColor)),
        Divider(color: lineColor, thickness: 1 * scale, height: 4 * scale),
      ],
    );
  }

  Widget _buildEducationItem(Education edu, Color primaryColor,
      TextStyle Function({Color? color, double? fontSizeOverride, FontWeight? fontWeight, FontStyle? fontStyle}) getBodyStyle,
      TextStyle Function({Color? color, double? fontSizeOverride, FontWeight? fontWeight}) getHeadingStyle,
      double subHeadingFontSize, double itemSpacing) {
    return Padding(
      padding: EdgeInsets.only(bottom: itemSpacing / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            edu.years ?? '',
            style: getBodyStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ),
          Text(
            edu.degree ?? '',
            style: getHeadingStyle(fontSizeOverride: subHeadingFontSize),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            edu.institution ?? '',
            style: getBodyStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSkillItem(String skill, Color barColor,
      TextStyle Function({Color? color, double? fontSizeOverride, FontWeight? fontWeight, FontStyle? fontStyle}) getBodyStyle,
      double baseFontSize,
      double scale) {
    // These values are hardcoded and don't come from your template models,
    // so they are just illustrative for a visual bar.
    final double skillPercentage = 0.8;
    final double barHeight = 4 * scale;
    final double barWidth = 100 * scale;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(skill, style: getBodyStyle()),
          SizedBox(height: 2 * scale),
          Stack(
            children: [
              Container(
                height: barHeight,
                width: barWidth,
                color: Colors.grey[300],
              ),
              Container(
                height: barHeight,
                width: barWidth * skillPercentage,
                color: barColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceItem(Experience exp, Color primaryColor,
      TextStyle Function({Color? color, double? fontSizeOverride, FontWeight? fontWeight, FontStyle? fontStyle}) getBodyStyle,
      TextStyle Function({Color? color, double? fontSizeOverride, FontWeight? fontWeight}) getHeadingStyle,
      double subHeadingFontSize, double itemSpacing,
      double baseFontSize) {
    return Padding(
      padding: EdgeInsets.only(bottom: itemSpacing / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exp.years ?? '',
            style: getBodyStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ),
          Text(
            exp.position ?? '',
            style: getHeadingStyle(fontSizeOverride: subHeadingFontSize),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            exp.company ?? '',
            style: getBodyStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (exp.responsibilities != null && exp.responsibilities!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: 8 * scale, top: 4 * scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: exp.responsibilities!.map((resp) => Text(
                  '• $resp',
                  style: getBodyStyle(fontSizeOverride: baseFontSize * 0.9),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text, Color iconColor,
      TextStyle Function({Color? color, double? fontSizeOverride, FontWeight? fontWeight, FontStyle? fontStyle}) getBodyStyle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2 * scale),
      child: Row(
        children: [
          Icon(icon, size: 14 * scale, color: iconColor),
          SizedBox(width: 5 * scale),
          Expanded(child: Text(text, style: getBodyStyle())),
        ],
      ),
    );
  }
}