import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:jobs_api/jobs_api.dart';
import 'package:uuid/uuid.dart';

part 'job.g.dart';

/// {@template job}
/// A single job item.
//TODO: Update this
/// //update
/// Contains a [title], [description] and [id], in addition to a [isCompleted]
/// flag.
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [Job]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class Job extends Equatable {
  /// {@macro job}
  Job({
    String? id,
    this.pay = 0,
    DateTime? dateTime,
    this.location = '',
    this.caregiver = '',
    this.link = '',
    this.isCompleted = false,
  })  : assert(
          id == null || id.isNotEmpty, // id: ''
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4(),
        dateTime = dateTime ?? DateTime(1970);

  /// The unique identifier of the job.
  ///
  /// Cannot be empty.
  final String id;

  /// The pay of the job.
  ///
  /// Note that the pay may be empty.
  final double pay;

  /// The date and time of the job.
  ///
  /// Note that the date may be empty.
  final DateTime dateTime;

  /// The location of the job.
  ///
  /// Note that the location may be empty.
  final String location;

  /// The caregiver of the job.
  ///
  /// Note that the caregiver may be empty.
  final String caregiver;

  /// The link of the job.
  ///
  /// Note that the link may be empty.
  final String link;

  /// The bool of whether or not the job is done
  ///
  /// Note that the link may be empty.
  final bool isCompleted;

  /// Returns a copy of this job with the given values updated.
  ///
  /// {@macro job}
  Job copyWith({
    String? id,
    double? pay,
    DateTime? dateTime,
    String? location,
    String? caregiver,
    String? link,
    bool? isCompleted,
  }) {
    return Job(
      id: id ?? this.id,
      pay: pay ?? this.pay,
      dateTime: dateTime ?? this.dateTime,
      location: location ?? this.location,
      caregiver: caregiver ?? this.caregiver,
      link: link ?? this.link,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  /// Deserializes the given [JsonMap] into a [Job].
  static Job fromJson(JsonMap json) => _$JobFromJson(json);

  /// Converts this [Job] into a [JsonMap].
  JsonMap toJson() => _$JobToJson(this);

  @override
  List<Object> get props =>
      [id, pay, dateTime, location, caregiver, link, isCompleted];
}
