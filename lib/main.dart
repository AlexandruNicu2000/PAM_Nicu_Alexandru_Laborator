import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repositories/product_repository.dart';
import 'cubit/product_cubit.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductCubit>(
          create: (context) => ProductCubit(ProductRepository())..loadProducts(),
        ),
      ],
      child: MaterialApp(
        title: 'GemStore',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepOrange, // Culoarea de bază
            primary: Colors.deepOrange.shade700, // Portocaliu închis/roșiatic pentru elemente principale
            secondary: Colors.amber.shade700, // Galben/chihlimbar pentru accente
            surface: const Color(0xFFFFF8E1), // Crem/gălbui foarte deschis pentru fundalul general
          ),
          scaffoldBackgroundColor: const Color(0xFFFFF8E1), // Fundalul ecranelor
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.deepOrange.shade700,
            foregroundColor: Colors.white, // Text alb pe bara de sus
            elevation: 2,
          ),
          cardTheme: CardThemeData(
            color: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}