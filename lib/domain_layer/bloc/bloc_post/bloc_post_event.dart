import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_project/data_layer/models/post.dart';

abstract class PostEvent {}

class GetPosts extends PostEvent {
  bool? isIndex;

  GetPosts(this.isIndex);
}

class SearchPost extends PostEvent {
  final String query;
  bool? isIndex;

  SearchPost(this.query, this.isIndex);
}

abstract class LikePostEvent {}

class ToggleLike extends LikePostEvent {
  bool isLiked;
  PostModel post;
  String userId;
  Timestamp time;
  ToggleLike(this.isLiked, this.post, this.userId, this.time);
}

abstract class CommentEvent {}

class AddComment extends CommentEvent {
  PostModel post;
  Map<String, dynamic> commentData;
  AddComment(this.post, this.commentData);
}
