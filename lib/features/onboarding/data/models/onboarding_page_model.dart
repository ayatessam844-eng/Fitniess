import 'package:fitnies/features/onboarding/domain/entities/onboarding_page_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'onboarding_page_model.g.dart';

@JsonSerializable()
final class OnboardingPageModel extends OnboardingPageEntity {
  const OnboardingPageModel({
    required super.title,
    required super.description,
    required super.imageAsset,
  });

  factory OnboardingPageModel.fromJson(Map<String, dynamic> json) {
    return _$OnboardingPageModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OnboardingPageModelToJson(this);
}
