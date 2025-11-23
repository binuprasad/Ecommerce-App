import 'package:ecommerce_app/features/blocs/edit_product/edit_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProductPage extends StatefulWidget {
  final int id;
  final String title;
  final int price;
  final String description;
  const EditProductPage({
    super.key,
    required this.title,
    required this.price,
    required this.description,
    required this.id,
  });

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late TextEditingController titleController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.title);
    priceController = TextEditingController(text: widget.price.toString());
    descriptionController = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.chevron_left_sharp),
            ),
          ),
        ),
        title: Text(widget.title),
      ),

      body: BlocListener<EditProductBloc, EditProductState>(
        listener: (context, state) {
          if (state is EditSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Product Updated Successfully!')),
            );
            Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: 10.h),
                Text(
                  'Update Product Details',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 25.h),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Product Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.h),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.h),
                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Description',

                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 30.h),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(12.r),
                      ),
                    ),
                    onPressed: () {
                      final data = {
                        "title": titleController.text,
                        "price": int.parse(priceController.text),
                        "description": descriptionController.text,
                      };

                      context.read<EditProductBloc>().add(
                        UpdateProductEvent(widget.id, data),
                      );
                    },
                    child: Text(
                      'Update Product',
                      style: TextStyle(fontSize: 18.sp, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
