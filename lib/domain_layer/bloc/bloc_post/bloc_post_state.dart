import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_project/data_layer/models/post.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostsLoaded extends PostState {
  final List<PostModel> posts;
  final List<PostModel> filteredPosts;
  final bool isSearching;
  bool? isIndex;

  PostsLoaded(this.posts, this.isSearching, this.filteredPosts, this.isIndex);
}

abstract class LikePostState {}

class LikePostInitial extends LikePostState {}

class LikePostLoading extends LikePostState {}

class LikePostsToggled extends LikePostState {}

abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class Commented extends CommentState {
  Map<String, dynamic> updateCommentData;

  Commented(this.updateCommentData);
}
