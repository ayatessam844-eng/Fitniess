// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnboardingPageModel _$OnboardingPageModelFromJson(Map<String, dynamic> json) =>
    OnboardingPageModel(
      title: json['title'] as String,
      description: json['description'] as String,
      imageAsset: json['imageAsset'] as String,
    );

Map<String, dynamic> _$OnboardingPageModelToJson(
  OnboardingPageModel instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'imageAsset': instance.imageAsset,
};
