part of 'edit_product_bloc.dart';

sealed class EditProductEvent extends Equatable {
  const EditProductEvent();

  @override
  List<Object> get props => [];
}

class UpdateProductEvent extends EditProductEvent{
  final int id;
  final Map<String,dynamic> data;

 const UpdateProductEvent( this.id,  this.data);

  @override
  List<Object> get props => [id,data];
  
}
