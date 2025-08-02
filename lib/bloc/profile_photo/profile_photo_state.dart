part of 'profile_photo_bloc.dart';

abstract class ProfilePhotoState extends Equatable {
  const ProfilePhotoState();

  @override
  List<Object?> get props => [];
}

class ProfilePhotoInitial extends ProfilePhotoState {}

class ProfilePhotoLoading extends ProfilePhotoState {}

class ProfilePhotoSelected extends ProfilePhotoState {
  final String imagePath;

  const ProfilePhotoSelected({required this.imagePath});

  @override
  List<Object?> get props => [imagePath];
}

class ProfilePhotoFailure extends ProfilePhotoState {
  final String error;

  const ProfilePhotoFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class ProfilePhotoUploaded extends ProfilePhotoState {
  final String message;

  const ProfilePhotoUploaded({required this.message});

  @override
  List<Object?> get props => [message];
}
