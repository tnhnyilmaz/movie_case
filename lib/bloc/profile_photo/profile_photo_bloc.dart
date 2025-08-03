import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_case/repositories/profile_repository.dart';

part 'profile_photo_event.dart';
part 'profile_photo_state.dart';

class ProfilePhotoBloc extends Bloc<ProfilePhotoEvent, ProfilePhotoState> {
  final ImagePicker _picker = ImagePicker();
  final ProfileRepository profileRepository;
  ProfilePhotoBloc(this.profileRepository) : super(ProfilePhotoInitial()) {
    on<PickPhotoRequested>((event, emit) async {
      emit(ProfilePhotoLoading());
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: ImageSource.gallery,
          maxWidth: 600,
          maxHeight: 600,
          imageQuality: 80,
        );
        if (pickedFile != null) {
          emit(ProfilePhotoSelected(imagePath: pickedFile.path));
        } else {
          emit(ProfilePhotoInitial());
        }
      } catch (e) {
        emit(ProfilePhotoFailure(e.toString()));
      }
    });

    // Bloc içindeki yükleme kısmı
    on<UploadPhotoRequested>((event, emit) async {
      emit(ProfilePhotoLoading());
      try {
        // Repository artık fotoğrafın URL'sini döndürüyor
        final uploadedPhotoUrl = await profileRepository.uploadProfilePhoto(
          event.imagePath,
        );
        emit(
          ProfilePhotoUploaded(photoUrl: uploadedPhotoUrl),
        ); // URL'yi state'e gönderiyoruz
      } catch (e) {
        emit(ProfilePhotoFailure(e.toString()));
      }
    });
  }
}
