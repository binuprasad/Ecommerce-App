import 'package:ecommerce_app/data/Repository/product_repository.dart';
import 'package:ecommerce_app/features/blocs/products/Product_details/product_detail_bloc.dart';
import 'package:ecommerce_app/features/widgets/option_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ProductDetailPage extends StatelessWidget {
  final int id;
  const ProductDetailPage({super.key, required this.id});

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
        elevation: 0,
        backgroundColor: Colors.transparent,

        actions: const [Icon(Icons.favorite_border), SizedBox(width: 10)],
      ),
      body: BlocProvider(
        create: (_) =>
            ProductDetailBloc(context.read<ProductRepository>())
              ..add(LoadProductDetailEvent(id)),
        child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            if (state is ProductDetailLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailError) {
              return Center(child: Text(state.message));
            } else if (state is ProductDetailsLoaded) {
              final product = state.product;
              return DefaultTabController(
                length: 2,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 220.h,
                              decoration: BoxDecoration(
                                // color: const Color(0xFFF5F4FF),
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.w,
                                  ),
                                  child: CircleAvatar(
                                    radius: 100.r,
                                    backgroundColor:  const Color.fromARGB(255, 205, 203, 221),
                                    
                                    child: Image.network(
                                      product.thumbnail,
                                      height: 180.h,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 12.w,
                              top: 16.h,
                              child: Column(
                                children: [
                                  OptionIcon(icon: Icons.headphones_rounded),
                                  SizedBox(height: 10.h),
                                  OptionIcon(icon: Icons.widgets_outlined),
                                  SizedBox(height: 10.h),
                                  OptionIcon(icon: Icons.invert_colors),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          top: 12.h,
                        ),
                        child: Text(
                          '\$ ${product.price}',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h,),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        child: Text(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 23.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          'About the Item',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      Padding(
                        padding: EdgeInsets.symmetric(
                         
                          vertical: 5.h,
                        ),
                        child: TabBar(
                          tabAlignment: TabAlignment.start,
                          isScrollable: true,
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          labelColor: Colors.black,
                          tabs: [
                            Tab(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Text(
                                  "Full Specification",
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ),
                            ),
                            Tab(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Text(
                                  'Reviews',
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 12.h),

                      SizedBox(
                        height: 240.h,
                        child: TabBarView(
                        
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Text(
                                product.description,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: product.reviews.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5.h,
                                    horizontal: 15.w,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: .start,
                                    children: [
                                      Text(
                                        product.reviews[index].comment,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: .spaceBetween,
                                        children: [
                                          Text(
                                            '- ${product.reviews[index].reviewerName}',
                                          ),
                                          Text(
                                            DateFormat('dd-MM-yyyy').format(
                                              product.reviews[index].date,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              );
            }
            return Center(child: Text('Something went wrong!'));
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {},
        child: const Icon(Icons.edit),
      ),
    );
  }
}
