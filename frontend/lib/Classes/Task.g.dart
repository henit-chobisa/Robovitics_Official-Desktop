// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    id: json['_id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    assignedDate: DateTime.parse(json['assignedDate'] as String),
    lastDate: DateTime.parse(json['lastDate'] as String),
    referencingDocumentLink: json['referencingDocumentLink'] as String,
    bannerLink: json['bannerLink'] as String,
    mentor: UserB.fromJson(json['mentor'] as Map<String, dynamic>),
    core: json['core'] as String,
    isCompleted: json['isCompleted'] as bool,
    isTeamTask: json['isTeamTask'] as bool,
    discussions: (json['discussions'] as List<dynamic>)
        .map((e) => DiscussionModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    qna: (json['qna'] as List<dynamic>)
        .map((e) => QnaModel.FromJson(e as Map<String, dynamic>))
        .toList(),
    submissions: (json['submissions'] as List<dynamic>)
        .map((e) => Submission.fromJson(e as Map<String, dynamic>))
        .toList(),
    pointsAlloted: json['pointsAlloted'] as int,
    assignedTo: (json['assignedTo'] as List<dynamic>)
        .map((e) => UserB.fromJson(e as Map<String, dynamic>))
        .toList(),
    acknowledgedBy: (json['acknowledgedBy'] as List<dynamic>)
        .map((e) => UserB.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'assignedDate': instance.assignedDate.toIso8601String(),
      'lastDate': instance.lastDate.toIso8601String(),
      'referencingDocumentLink': instance.referencingDocumentLink,
      'bannerLink': instance.bannerLink,
      'mentor': instance.mentor,
      'acknowledgedBy': instance.acknowledgedBy,
      'assignedTo': instance.assignedTo,
      'core': instance.core,
      'isCompleted': instance.isCompleted,
      'isTeamTask': instance.isTeamTask,
      'discussions': instance.discussions,
      'qna': instance.qna,
      'submissions': instance.submissions,
      'pointsAlloted': instance.pointsAlloted,
    };
