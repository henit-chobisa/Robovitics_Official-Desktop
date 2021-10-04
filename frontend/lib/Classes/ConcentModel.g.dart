// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ConcentModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConcentModel _$ConcentModelFromJson(Map<String, dynamic> json) {
  return ConcentModel(
    id: json['_id'] as String,
    Concent: json['Concent'] as String,
    Upvotes: json['Upvotes'] as int,
    Downvotes: json['Downvotes'] as int,
    DownvotedBy:
        (json['DownvotedBy'] as List<dynamic>).map((e) => e as String).toList(),
    UpvotedBy:
        (json['UpvotedBy'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$ConcentModelToJson(ConcentModel instance) =>
    <String, dynamic>{
      'Concent': instance.Concent,
      'UpvotedBy': instance.UpvotedBy,
      'DownvotedBy': instance.DownvotedBy,
      'id': instance.id,
      'Upvotes': instance.Upvotes,
      'Downvotes': instance.Downvotes,
    };
