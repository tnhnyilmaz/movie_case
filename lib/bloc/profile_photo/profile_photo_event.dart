part of 'profile_photo_bloc.dart';

abstract class ProfilePhotoEvent extends Equatable {
  const ProfilePhotoEvent();

  @override
  List<Object?> get props => [];
}

class PickPhotoRequested extends ProfilePhotoEvent {}

class UploadPhotoRequested extends ProfilePhotoEvent {
  final String imagePath;

  const UploadPhotoRequested({required this.imagePath});

  @override
  List<Object?> get props => [imagePath];
}
