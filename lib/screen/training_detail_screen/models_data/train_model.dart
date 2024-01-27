class TrainingModel {
  final String title;
  final String mainImage;
  final List<TrainingPlan> trainingPlans;

  TrainingModel({
    required this.title,
    required this.mainImage,
    required this.trainingPlans,
  });

  factory TrainingModel.fromJson(Map<String, dynamic> json) => TrainingModel(
        title: json["title"],
        mainImage: json["mainImage"],
        trainingPlans: json['trainingPlans']
            .map<TrainingPlan>((e) => TrainingPlan.fromJson(e))
            .toList(),
      );
}

class TrainingPlan {
  final int totalTime;
  final int kkall;
  final int exerciseCount;
  final int approaches;
  final int seconds;
  final List<ExerciseList> exerciseList;

  TrainingPlan({
    required this.totalTime,
    required this.kkall,
    required this.exerciseCount,
    required this.approaches,
    required this.seconds,
    required this.exerciseList,
  });

  factory TrainingPlan.fromJson(Map<String, dynamic> json) => TrainingPlan(
        totalTime: json["totalTime"],
        kkall: json["kkall"],
        exerciseCount: json["exerciseCount"],
        approaches: json["approaches"],
        seconds: json["seconds"],
        exerciseList:
            json["exerciseList"].map((e) => ExerciseList.fromJson(e)).toList(),
      );
}

class ExerciseList {
  final String image;
  final String title;
  final String desciption;

  ExerciseList({
    required this.image,
    required this.title,
    required this.desciption,
  });

  factory ExerciseList.fromJson(Map<String, dynamic> json) => ExerciseList(
        image: json["image"],
        title: json["title"],
        desciption: json["desciption"],
      );
}
