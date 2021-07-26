// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostItem _$PostItemFromJson(Map<String, dynamic> json) {
  //$checkKeys(json, requiredKeys: const ['title']);
  return PostItem(
    title: json['title'] as String,
    body: json['body'] as String,
    userId: json['userId'],
    postId: json['id'] as int,
  );
}

Map<String, dynamic> _$PostItemToJson(PostItem instance) => <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'userId': instance.userId,
      'id': instance.postId,
    };
