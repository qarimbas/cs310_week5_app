import 'package:json_annotation/json_annotation.dart';

part 'postItem.g.dart';

@JsonSerializable()
class PostItem {
  @JsonKey(required: true)
  String title;
  @JsonKey(includeIfNull: false)
  String body;
  dynamic userId;
  @JsonKey(name: 'id')
  int postId;

  PostItem({
    required this.title,
    required this.body,
    required this.userId,
    required this.postId,
  });

  factory PostItem.fromJson(Map<String, dynamic> json) =>
      _$PostItemFromJson(json);

  Map<String, dynamic> toJson() => _$PostItemToJson(this);
}
