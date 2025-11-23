import 'package:ecommerce_app/data/Repository/product_repository.dart';
import 'package:ecommerce_app/data/datasource/remote_datasource.dart';
import 'package:ecommerce_app/features/blocs/Product_details/product_detail_bloc.dart';
import 'package:ecommerce_app/features/blocs/edit_product/edit_product_bloc.dart';
import 'package:ecommerce_app/features/blocs/products/products_bloc.dart';
import 'package:ecommerce_app/features/blocs/products/products_event.dart';
import 'package:ecommerce_app/features/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ProductRemoteDataSource>(
            create: (_) => ProductRemoteDataSource(),
          ),
          RepositoryProvider(
            create: (context) =>
                ProductRepository(context.read<ProductRemoteDataSource>()),
          ),
          BlocProvider(
            create: (context) =>
                EditProductBloc(context.read<ProductRepository>()),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  ProductBloc(ProductRepository(ProductRemoteDataSource()))
                    ..add(LoadProductsEvent(isInitialLoad: true)),
            ),
            BlocProvider<ProductDetailBloc>(
              create: (context) =>
                  ProductDetailBloc(context.read<ProductRepository>()),
            ),
          ],
          child: MaterialApp(
            title: 'Ecommerce App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            home: ProductListScreen(),
          ),
        ),
      ),
    );
  }
}
