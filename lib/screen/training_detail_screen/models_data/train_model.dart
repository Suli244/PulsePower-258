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
            .map<TrainingPlan>((e) =>
                TrainingPlan.fromJson(e, json['trainingPlans'].indexOf(e)))
            .toList(),
      );
}

class TrainingPlan {
  final int totalTime;
  final int kkall;
  final int exerciseCount;
  final int approaches;
  final int seconds;
  final bool isPremium;

  final List<ExerciseList> exerciseList;

  TrainingPlan({
    required this.totalTime,
    required this.kkall,
    required this.exerciseCount,
    required this.approaches,
    required this.seconds,
    required this.exerciseList,
    required this.isPremium,
  });

  factory TrainingPlan.fromJson(Map<String, dynamic> json, int index) =>
      TrainingPlan(
        totalTime: json["totalTime"],
        kkall: json["kkall"],
        exerciseCount: json["exerciseCount"],
        approaches: json["approaches"],
        seconds: json["seconds"],
        isPremium: index > 2,
        exerciseList: json["exerciseList"]
            .map<ExerciseList>(
              (e) => ExerciseList.fromJson(e),
            )
            .toList(),
      );
}

class ExerciseList {
  final String image;
  final String title;
  final String description;

  ExerciseList({
    required this.image,
    required this.title,
    required this.description,
  });

  factory ExerciseList.fromJson(Map<String, dynamic> json) => ExerciseList(
        image: json["image"],
        title: json["title"],
        description: json["description"],
      );
}
