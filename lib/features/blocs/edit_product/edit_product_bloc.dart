import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/data/Repository/product_repository.dart';
import 'package:ecommerce_app/data/models/product_update_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_product_event.dart';
part 'edit_product_state.dart';

class EditProductBloc extends Bloc<EditProductEvent, EditProductState> {
  final ProductRepository repository;
  EditProductBloc(this.repository) : super(EditProductInitial()) {
    on<UpdateProductEvent>((event, emit) async {
      try {
        emit(EditProductInitial());
        final updatedProduct = await repository.updateProduct(
          event.id,
          event.data,
        );

        emit(EditSuccess(updatedProduct: updatedProduct));
      } catch (e) {
        emit(EditFailure(e.toString()));
      }
    });
  }
}
