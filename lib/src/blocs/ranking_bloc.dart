// @dart=2.9
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class RankingBloc {
  var _reviewController = BehaviorSubject<String>();
  var _ratingController = BehaviorSubject<int>();
  var _adReviewController = BehaviorSubject<dynamic>();

  //  INSERTAR VALORES AL STREAM
  Function(String) get changeReview => _reviewController.sink.add;
  Function(int) get changeRating => _ratingController.sink.add;
  Function(dynamic) get changeAdReview => _adReviewController.sink.add;

  // OBTENER LOS VALORES DE EL EMAIL Y PASSWORD

  String get review => _reviewController.value;
  int get rating => _ratingController.value;
  dynamic get adReview => _adReviewController.value;

  Stream<String> get reviewStream => _reviewController.stream;
  Stream<int> get ratingStream => _ratingController.stream;
  Stream<dynamic> get adReviewStream => _adReviewController.stream;

  dispose() {
    _reviewController?.close();
    _ratingController?.close();
    _adReviewController?.close();
  }

  streamNull() {
    _reviewController = BehaviorSubject<String>();
    _ratingController = BehaviorSubject<int>();
    _adReviewController = BehaviorSubject<dynamic>();
  }
}

RankingBloc blocRanking = RankingBloc();
