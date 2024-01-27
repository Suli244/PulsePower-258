import 'package:pulsepower_258/screen/training_detail_screen/models_data/train_model.dart';

final trainData = TrainingModel(
  title: 'Beginner',
  mainImage: 'mainImage',
  trainingPlans: [
    TrainingPlan(
      totalTime: 1,
      kkall: 160,
      exerciseCount: 2,
      approaches: 1,
      seconds: 15,
      exerciseList: [
        ExerciseList(
          image:
              'https://www.supersprint.com/public/img/01-504900-504930-504960-504990-505020.jpg',
          title: 'TITLE 1',
          desciption:
              'Lie on your back, bend your legs, lift the body to your knees, lower it back.',
        ),
        ExerciseList(
          image:
              'https://www.supersprint.com/public/img/01-504900-504930-504960-504990-505020.jpg',
          title: 'TITLE 2',
          desciption:
              'Stand up to the bar. Start moving alternately with each foot forward, as if running.',
        ),
        // ExerciseList(
        //   image:
        //       'https://www.supersprint.com/public/img/01-504900-504930-504960-504990-505020.jpg',
        //   title: 'TITLE 3',
        //   desciption:
        //       'Lie on your back, bend your legs, lift the body to your knees, lower it back.',
        // ),
        // ExerciseList(
        //   image:
        //       'https://www.supersprint.com/public/img/01-504900-504930-504960-504990-505020.jpg',
        //   title: 'TITLE 4',
        //   desciption:
        //       'Lie down on your knees in the plank. Alternately stretch out your leg, lifting it up as far as possible. Return to the starting position.',
        // ),
      ],
    ),
  ],
);
