// import 'dart:convert';

// import 'package:flutter/foundation.dart';

// class TrainingModelV2 {
//   final String title;
//   final String mainImage;

//   final List<TrainingPlanV2> trainingPlans;

//   TrainingModelV2({
//     required this.title,
//     required this.mainImage,
//     required this.trainingPlans,
//   });

//   factory TrainingModelV2.fromJson(Map<String, dynamic> json) =>
//       TrainingModelV2(
//         title: json["title"],
//         mainImage: json["mainImage"],
//         trainingPlans: json['trainingPlans']
//             .map<TrainingPlanV2>(
//               (e) => TrainingPlanV2.fromJson(
//                   e, json['trainingPlans'].indexOf(e) > 2),
//             )
//             .toList(),
//       );

//   @override
//   String toString() =>
//       'TrainingModelV2(title: $title, mainImage: $mainImage, trainingPlans: $trainingPlans)';
// }

// class TrainingPlanV2 {
//   final int totalTime;
//   final int kkall;
//   final int exerciseCount;
//   final int approaches;
//   final int seconds;
//   final bool isPremium;
//   final List<ExerciseList> exerciseList;

//   TrainingPlanV2({
//     required this.totalTime,
//     required this.kkall,
//     required this.exerciseCount,
//     required this.approaches,
//     required this.seconds,
//     required this.exerciseList,
//     required this.isPremium,
//   });

//   factory TrainingPlanV2.fromJson(Map<String, dynamic> map, bool isPremium) {
//     return TrainingPlanV2(
//       isPremium: isPremium,
//       totalTime: map['totalTime']?.toInt() ?? 0,
//       kkall: map['kkall']?.toInt() ?? 0,
//       exerciseCount: map['exerciseCount']?.toInt() ?? 0,
//       approaches: map['approaches']?.toInt() ?? 0,
//       seconds: map['seconds']?.toInt() ?? 0,
//       exerciseList: List<ExerciseList>.from(
//         map['exerciseList']?.map(
//           (x) => ExerciseList.fromJson(
//             x,
//             isPremium,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   String toString() {
//     return 'TrainingPlanV2(totalTime: $totalTime, kkall: $kkall, exerciseCount: $exerciseCount, approaches: $approaches, seconds: $seconds, exerciseList: $exerciseList)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is TrainingPlanV2 &&
//         other.totalTime == totalTime &&
//         other.kkall == kkall &&
//         other.exerciseCount == exerciseCount &&
//         other.approaches == approaches &&
//         other.seconds == seconds &&
//         listEquals(other.exerciseList, exerciseList);
//   }

//   @override
//   int get hashCode {
//     return totalTime.hashCode ^
//         kkall.hashCode ^
//         exerciseCount.hashCode ^
//         approaches.hashCode ^
//         seconds.hashCode ^
//         exerciseList.hashCode;
//   }
// }

// class ExerciseList {
//   final String image;
//   final String title;
//   final String description;
//   final bool isPremium;

//   ExerciseList({
//     required this.image,
//     required this.title,
//     required this.isPremium,
//     required this.description,
//   });

//   ExerciseList copyWith({
//     String? image,
//     String? title,
//     String? description,
//     bool? isPremium,
//   }) {
//     return ExerciseList(
//       isPremium: isPremium ?? this.isPremium,
//       image: image ?? this.image,
//       title: title ?? this.title,
//       description: description ?? this.description,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     final result = <String, dynamic>{};

//     result.addAll({'image': image});
//     result.addAll({'title': title});
//     result.addAll({'description': description});

//     return result;
//   }

//   factory ExerciseList.fromJson(Map<String, dynamic> map, bool isPremium) {
//     return ExerciseList(
//       isPremium: isPremium,
//       image: map['image'] ?? '',
//       title: map['title'] ?? '',
//       description: map['description'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   @override
//   String toString() =>
//       'ExerciseList(image: $image, title: $title, description: $description)';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is ExerciseList &&
//         other.image == image &&
//         other.title == title &&
//         other.description == description;
//   }

//   @override
//   int get hashCode => image.hashCode ^ title.hashCode ^ description.hashCode;
// }
