import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              'Discover our exclusive \nProducts',
              style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
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
                  style: TextStyle(fontSize: 18.sp, color: Colors.blueAccent),
                ),
              ],
            ),

            SizedBox(height: 5.h),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12.h,
                  crossAxisSpacing: 12.w,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 1.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: AspectRatio(
                                aspectRatio: 1.5,
                                child: Image.network(
                                  '',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.image, size: 48),
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              'Sony WH-1000xM4',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              'Sony is the leading headphone in india Leading noice ',
                              textAlign: TextAlign.center,
                              style: TextStyle(),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              '\$ 800',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
