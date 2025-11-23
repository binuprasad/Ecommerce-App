part of 'edit_product_bloc.dart';

sealed class EditProductState extends Equatable {
  const EditProductState();

  @override
  List<Object> get props => [];
}

final class EditProductInitial extends EditProductState {}

class EditLoading extends EditProductState {}

class EditSuccess extends EditProductState {
  final ProductUpdatelResponse updatedProduct;

  const EditSuccess({required this.updatedProduct});
  @override
  List<Object> get props => [updatedProduct];
}

class EditFailure extends EditProductState {
  final String message;

  const EditFailure(this.message);
  @override
  List<Object> get props => [message];
}
