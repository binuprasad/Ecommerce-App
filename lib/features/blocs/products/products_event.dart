import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProductsEvent extends ProductEvent {
  final bool isInitialLoad;

  LoadProductsEvent({this.isInitialLoad = false});
}
