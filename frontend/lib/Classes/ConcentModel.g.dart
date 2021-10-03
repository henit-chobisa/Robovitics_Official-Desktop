// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ConcentModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConcentModel _$ConcentModelFromJson(Map<String, dynamic> json) {
  return ConcentModel(
    id: json['id'] as String,
    Concent: json['Concent'] as String,
    Upvotes: json['Upvotes'] as int,
    Downvotes: json['Downvotes'] as int,
  );
}

Map<String, dynamic> _$ConcentModelToJson(ConcentModel instance) =>
    <String, dynamic>{
      'Concent': instance.Concent,
      'id': instance.id,
      'Upvotes': instance.Upvotes,
      'Downvotes': instance.Downvotes,
    };
