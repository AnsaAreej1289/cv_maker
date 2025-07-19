// lib/cv_template_models.dart

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cv_template_models.g.dart'; // <<< THIS LINE HAS BEEN ADDED BACK AND IS CRUCIAL FOR FIXING THE ERRORS

@JsonSerializable()
class CvTemplate {
  final TemplateMetadata metadata;
  final TemplateLayout layout;
  final TemplateColors colors;
  final TemplateFonts fonts;
  final DefaultData defaultData;

  CvTemplate({
    required this.metadata,
    required this.layout,
    required this.colors,
    required this.fonts,
    required this.defaultData,
  });

  factory CvTemplate.fromJson(Map<String, dynamic> json) => _$CvTemplateFromJson(json);
  Map<String, dynamic> toJson() => _$CvTemplateToJson(this);

  CvTemplate copyWith({
    TemplateMetadata? metadata,
    TemplateLayout? layout,
    TemplateColors? colors,
    TemplateFonts? fonts,
    DefaultData? defaultData,
  }) {
    return CvTemplate(
      metadata: metadata ?? this.metadata,
      layout: layout ?? this.layout,
      colors: colors ?? this.colors,
      fonts: fonts ?? this.fonts,
      defaultData: defaultData ?? this.defaultData,
    );
  }
}

@JsonSerializable()
class TemplateMetadata {
  final String id;
  final String name;
  final String description;
  final String thumbnailUrl;

  TemplateMetadata({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnailUrl,
  });

  factory TemplateMetadata.fromJson(Map<String, dynamic> json) => _$TemplateMetadataFromJson(json);
  Map<String, dynamic> toJson() => _$TemplateMetadataToJson(this);
}

@JsonSerializable()
class TemplateLayout {
  final String type;
  final Map<String, dynamic> settings;

  TemplateLayout({
    required this.type,
    required this.settings,
  });

  factory TemplateLayout.fromJson(Map<String, dynamic> json) => _$TemplateLayoutFromJson(json);
  Map<String, dynamic> toJson() => _$TemplateLayoutToJson(this);
}

@JsonSerializable()
class TemplateColors {
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final Color primary;
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final Color secondary;
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final Color background;
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final Color text;

  TemplateColors({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.text,
  });

  factory TemplateColors.fromJson(Map<String, dynamic> json) => _$TemplateColorsFromJson(json);
  Map<String, dynamic> toJson() => _$TemplateColorsToJson(this);

  static Color _colorFromJson(int rgb) => Color(rgb);
  static int _colorToJson(Color color) => color.value;
}

@JsonSerializable()
class TemplateFonts {
  final String heading;
  final String body;

  TemplateFonts({
    required this.heading,
    required this.body,
  });

  factory TemplateFonts.fromJson(Map<String, dynamic> json) => _$TemplateFontsFromJson(json);
  Map<String, dynamic> toJson() => _$TemplateFontsToJson(this);
}

@JsonSerializable()
class DefaultData {
  String? profileImagePath;
  String? name;
  String? title;
  String? summary;
  List<Experience>? experiences;
  List<Education>? education;
  List<String>? skills;
  List<String>? languages;
  ContactInfo? contact;

  DefaultData({
    this.profileImagePath,
    this.name,
    this.title,
    this.summary,
    this.experiences,
    this.education,
    this.skills,
    this.languages,
    this.contact,
  });

  factory DefaultData.fromJson(Map<String, dynamic> json) => _$DefaultDataFromJson(json);
  Map<String, dynamic> toJson() => _$DefaultDataToJson(this);

  DefaultData copyWith({
    String? profileImagePath,
    String? name,
    String? title,
    String? summary,
    List<Experience>? experiences,
    List<Education>? education,
    List<String>? skills,
    List<String>? languages,
    ContactInfo? contact,
  }) {
    return DefaultData(
      profileImagePath: profileImagePath,
      name: name ?? this.name,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      experiences: experiences ?? this.experiences,
      education: education ?? this.education,
      skills: skills ?? this.skills,
      languages: languages ?? this.languages,
      contact: contact ?? this.contact,
    );
  }
}

@JsonSerializable()
class Experience {
  String? position;
  String? company;
  String? years;
  List<String>? responsibilities;

  Experience({
    this.position,
    this.company,
    this.years,
    this.responsibilities,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => _$ExperienceFromJson(json);
  Map<String, dynamic> toJson() => _$ExperienceToJson(this);

  Experience copyWith({
    String? position,
    String? company,
    String? years,
    List<String>? responsibilities,
  }) {
    return Experience(
      position: position ?? this.position,
      company: company ?? this.company,
      years: years ?? this.years,
      responsibilities: responsibilities ?? this.responsibilities,
    );
  }
}

@JsonSerializable()
class Education {
  String? degree;
  String? institution;
  String? years;

  Education({
    this.degree,
    this.institution,
    this.years,
  });

  factory Education.fromJson(Map<String, dynamic> json) => _$EducationFromJson(json);
  Map<String, dynamic> toJson() => _$EducationToJson(this);

  Education copyWith({
    String? degree,
    String? institution,
    String? years,
  }) {
    return Education(
      degree: degree ?? this.degree,
      institution: institution ?? this.institution,
      years: years ?? this.years,
    );
  }
}

@JsonSerializable()
class ContactInfo {
  String? phone;
  String? email;
  String? address;
  String? website;

  ContactInfo({
    this.phone,
    this.email,
    this.address,
    this.website,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) => _$ContactInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ContactInfoToJson(this);

  ContactInfo copyWith({
    String? phone,
    String? email,
    String? address,
    String? website,
  }) {
    return ContactInfo(
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      website: website ?? this.website,
    );
  }
}