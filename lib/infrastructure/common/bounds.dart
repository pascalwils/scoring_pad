import 'package:equatable/equatable.dart';

class Bounds<T> extends Equatable {
  final T min;
  final T max;

  const Bounds({required this.min, required this.max});

  @override
  List<Object?> get props => [min, max];
}
