// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cv_template_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CvTemplate _$CvTemplateFromJson(Map<String, dynamic> json) => CvTemplate(
      metadata:
          TemplateMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      layout: TemplateLayout.fromJson(json['layout'] as Map<String, dynamic>),
      colors: TemplateColors.fromJson(json['colors'] as Map<String, dynamic>),
      fonts: TemplateFonts.fromJson(json['fonts'] as Map<String, dynamic>),
      defaultData:
          DefaultData.fromJson(json['defaultData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CvTemplateToJson(CvTemplate instance) =>
    <String, dynamic>{
      'metadata': instance.metadata,
      'layout': instance.layout,
      'colors': instance.colors,
      'fonts': instance.fonts,
      'defaultData': instance.defaultData,
    };

TemplateMetadata _$TemplateMetadataFromJson(Map<String, dynamic> json) =>
    TemplateMetadata(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );

Map<String, dynamic> _$TemplateMetadataToJson(TemplateMetadata instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'thumbnailUrl': instance.thumbnailUrl,
    };

TemplateLayout _$TemplateLayoutFromJson(Map<String, dynamic> json) =>
    TemplateLayout(
      type: json['type'] as String,
      settings: json['settings'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$TemplateLayoutToJson(TemplateLayout instance) =>
    <String, dynamic>{
      'type': instance.type,
      'settings': instance.settings,
    };

TemplateColors _$TemplateColorsFromJson(Map<String, dynamic> json) =>
    TemplateColors(
      primary: TemplateColors._colorFromJson((json['primary'] as num).toInt()),
      secondary:
          TemplateColors._colorFromJson((json['secondary'] as num).toInt()),
      background:
          TemplateColors._colorFromJson((json['background'] as num).toInt()),
      text: TemplateColors._colorFromJson((json['text'] as num).toInt()),
    );

Map<String, dynamic> _$TemplateColorsToJson(TemplateColors instance) =>
    <String, dynamic>{
      'primary': TemplateColors._colorToJson(instance.primary),
      'secondary': TemplateColors._colorToJson(instance.secondary),
      'background': TemplateColors._colorToJson(instance.background),
      'text': TemplateColors._colorToJson(instance.text),
    };

TemplateFonts _$TemplateFontsFromJson(Map<String, dynamic> json) =>
    TemplateFonts(
      heading: json['heading'] as String,
      body: json['body'] as String,
    );

Map<String, dynamic> _$TemplateFontsToJson(TemplateFonts instance) =>
    <String, dynamic>{
      'heading': instance.heading,
      'body': instance.body,
    };

DefaultData _$DefaultDataFromJson(Map<String, dynamic> json) => DefaultData(
      profileImagePath: json['profileImagePath'] as String?,
      name: json['name'] as String?,
      title: json['title'] as String?,
      summary: json['summary'] as String?,
      experiences: (json['experiences'] as List<dynamic>?)
          ?.map((e) => Experience.fromJson(e as Map<String, dynamic>))
          .toList(),
      education: (json['education'] as List<dynamic>?)
          ?.map((e) => Education.fromJson(e as Map<String, dynamic>))
          .toList(),
      skills:
          (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      contact: json['contact'] == null
          ? null
          : ContactInfo.fromJson(json['contact'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DefaultDataToJson(DefaultData instance) =>
    <String, dynamic>{
      'profileImagePath': instance.profileImagePath,
      'name': instance.name,
      'title': instance.title,
      'summary': instance.summary,
      'experiences': instance.experiences,
      'education': instance.education,
      'skills': instance.skills,
      'languages': instance.languages,
      'contact': instance.contact,
    };

Experience _$ExperienceFromJson(Map<String, dynamic> json) => Experience(
      position: json['position'] as String?,
      company: json['company'] as String?,
      years: json['years'] as String?,
      responsibilities: (json['responsibilities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ExperienceToJson(Experience instance) =>
    <String, dynamic>{
      'position': instance.position,
      'company': instance.company,
      'years': instance.years,
      'responsibilities': instance.responsibilities,
    };

Education _$EducationFromJson(Map<String, dynamic> json) => Education(
      degree: json['degree'] as String?,
      institution: json['institution'] as String?,
      years: json['years'] as String?,
    );

Map<String, dynamic> _$EducationToJson(Education instance) => <String, dynamic>{
      'degree': instance.degree,
      'institution': instance.institution,
      'years': instance.years,
    };

ContactInfo _$ContactInfoFromJson(Map<String, dynamic> json) => ContactInfo(
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      website: json['website'] as String?,
    );

Map<String, dynamic> _$ContactInfoToJson(ContactInfo instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address,
      'website': instance.website,
    };
