import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:jobs_api/jobs_api.dart';
import 'package:uuid/uuid.dart';

part 'job.g.dart';

/// {@template job}
/// A single job item.
///
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
    required this.title,
    this.description = '',
    this.isCompleted = false,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// The unique identifier of the job.
  ///
  /// Cannot be empty.
  final String id;

  /// The title of the job.
  ///
  /// Note that the title may be empty.
  final String title;

  /// The description of the job.
  ///
  /// Defaults to an empty string.
  final String description;

  /// Whether the job is completed.
  ///
  /// Defaults to `false`.
  final bool isCompleted;

  /// Returns a copy of this job with the given values updated.
  ///
  /// {@macro job}
  Job copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Job(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  /// Deserializes the given [JsonMap] into a [Job].
  static Job fromJson(JsonMap json) => _$JobFromJson(json);

  /// Converts this [Job] into a [JsonMap].
  JsonMap toJson() => _$JobToJson(this);

  @override
  List<Object> get props => [id, title, description, isCompleted];
}
