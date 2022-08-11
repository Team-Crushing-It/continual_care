// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Job _$JobFromJson(Map<String, dynamic> json) => Job(
      id: json['id'] as String?,
      pay: (json['pay'] as num?)?.toDouble() ?? 0,
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
      location: json['location'] as String? ?? '',
      caregiver: json['caregiver'] as String? ?? '',
      link: json['link'] as String? ?? '',
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$JobToJson(Job instance) => <String, dynamic>{
      'id': instance.id,
      'pay': instance.pay,
      'dateTime': instance.dateTime.toIso8601String(),
      'location': instance.location,
      'caregiver': instance.caregiver,
      'link': instance.link,
      'isCompleted': instance.isCompleted,
    };
