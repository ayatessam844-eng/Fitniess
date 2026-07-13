import 'package:equatable/equatable.dart';

class OnboardingPageEntity extends Equatable {
  const OnboardingPageEntity({
    required this.title,
    required this.description,
    required this.imageAsset,
  });

  final String title;
  final String description;
  final String imageAsset;

  @override
  List<Object?> get props => [title, description, imageAsset];
}
