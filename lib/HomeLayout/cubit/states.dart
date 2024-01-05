import 'package:my_social_app/components/components.dart';
import 'package:my_social_app/modules/add%20new%20post/add%20new%20post.dart';

abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {}

class ChangeBottomNavBarState extends SocialStates {}

class AddNewPostState extends SocialStates {
  AddNewPostState(context) {
    navigateTo(context: context, screen: const AddNewPost());
  }

}

class GetProfileUserSuccessState extends SocialStates{}

class GetProfileUserLoadingState extends SocialStates{}

class ProfileImagePickerSuccessState extends SocialStates {}

class ProfileImagePickerErrorState extends SocialStates {}

class CoverImagePickerSuccessState extends SocialStates {}

class CoverImagePickerErrorState extends SocialStates {}

class UploadProfileImageSuccessState extends SocialStates {}

class UploadProfileImageErrorState extends SocialStates {}

class UploadCoverImageSuccessState extends SocialStates {}

class UploadCoverImageErrorState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

class LoadingUpdateUserState extends SocialStates {}

class ShowMessageState extends SocialStates{}

//posts

class PostLoadingState extends SocialStates {}

class PostErrorState extends SocialStates {}

class PostSuccessState extends SocialStates {}

class GetImagePostSuccess extends SocialStates {}

class RemoveImagePostSuccessState extends SocialStates {}

class GetPostsLoadingState extends SocialStates {}

class GetPostsErrorState extends SocialStates {}

class GetPostsSuccessState extends SocialStates {}

class LikePostLoadingState extends SocialStates {}

class LikePostSuccessState extends SocialStates {}

class LikePostErrorState extends SocialStates {}

class CommentSuccessState extends SocialStates {}

class CommentErrorState extends SocialStates {}

class GetCommentLoadingState extends SocialStates {}

class GetCommentSuccessState extends SocialStates {}

class GetCommentErrorState extends SocialStates {}

class RemovePostLoadingState extends SocialStates {}

class RemovePostSuccessState extends SocialStates {}

class RemovePostErrorState extends SocialStates {}

class ChangeSnackBarState extends SocialStates {}

class GetUsersSuccessState extends SocialStates {}

class GetUsersLoadingState extends SocialStates {}

class GetUsersErrorState extends SocialStates {}

class SendMessageSuccessState extends SocialStates {}

class GetChatSuccessState extends SocialStates {}

class SocialSignOutState extends SocialStates{}

class GetLikesSuccessState extends SocialStates {}

class GetLikesLoadingState extends SocialStates{}

class ChangeTextPostState extends SocialStates{}

class SearchPostsSuccessState extends SocialStates{}
class SearchPostsLoadingState extends SocialStates{}


