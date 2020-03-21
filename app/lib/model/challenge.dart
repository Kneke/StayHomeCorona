
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'challenge.g.dart';

@JsonSerializable()
class Challenge {
  Challenge(this.id, this.title, this.description, this.category, this.points);

  final int id;
  final String title;
  final String description;
  final String category;
  final int points;

  factory Challenge.fromJson(Map<String, dynamic> json) => _$ChallengeFromJson(json);
  factory Challenge.fromJsonString(String jsonString) => _$ChallengeFromJson(json.decode(jsonString));
  Map<String, dynamic> toJson() => _$ChallengeToJson(this);
  String toJsonString() => _$ChallengeToJson(this).toString();
}

