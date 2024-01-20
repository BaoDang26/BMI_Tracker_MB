// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SalesData extends Equatable {
  final String x;
  final double y;

  const SalesData({
    required this.x,
    required this.y,
  });

  @override
  List<Object> get props => [x, y];

  static List<SalesData> salesList = [
    SalesData(x: 'BMW', y: 10),
    SalesData(x: 'Mercedes', y: 15),
    SalesData(x: 'ABC', y: 8),
    SalesData(x: 'Apple', y: 20),
    SalesData(x: 'Google', y: 18),
  ];
}
