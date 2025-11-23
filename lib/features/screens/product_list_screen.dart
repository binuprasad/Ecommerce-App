import 'package:ecommerce_app/features/blocs/products/products_bloc.dart';
import 'package:ecommerce_app/features/blocs/products/products_event.dart';
import 'package:ecommerce_app/features/blocs/products/products_state.dart';
import 'package:ecommerce_app/features/screens/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8) {
        context.read<ProductBloc>().add(LoadProductsEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Discover our exclusive \nProducts',
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'In this marketplace, you will find various\ntechnics in the cheapest price.',
                    style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Products',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Show All',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
          ),

          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading && state is! ProductLoaded) {
                return SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state is ProductError) {
                return SliverFillRemaining(
                  child: Center(child: Text(state.message)),
                );
              }

              if (state is ProductLoaded) {
                final products = state.products;

                return SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12.h,
                      crossAxisSpacing: 12.w,
                      childAspectRatio: 0.72,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index >= state.products.length) {
                          context.read<ProductBloc>().add(LoadProductsEvent());
                          return Center(child: CircularProgressIndicator());
                        }

                        final product = products[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailPage(id: product.id,),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 1.5,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.all(5.w),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10.r),
                                        child: AspectRatio(
                                          aspectRatio: 1.5,
                                          child: Image.network(
                                            product.thumbnail ?? "",
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Icon(
                                                      Icons.image,
                                                      size: 48,
                                                    ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        product.title ?? "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        product.description ?? "",
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 13.sp),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        "\$ ${product.price ?? 0}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 2.w,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.favorite_border_outlined),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: state.hasMore
                          ? state.products.length + 1
                          : state.products.length,
                    ),
                  ),
                );
              }

              return SliverToBoxAdapter(child: SizedBox());
            },
          ),
        ],
      ),
    );
  }
}
