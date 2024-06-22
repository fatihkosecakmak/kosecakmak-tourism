import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamukkale_app/ui/cubits/home_cubit.dart';
import 'package:pamukkale_app/ui/cubits/login_cubit.dart';
import 'package:pamukkale_app/ui/cubits/my_profile_cubit.dart';
import 'package:pamukkale_app/ui/cubits/signup_cubit.dart';
import 'package:pamukkale_app/ui/cubits/trip_detail_cubit.dart';
import 'package:pamukkale_app/ui/cubits/trips_cubit.dart';
import 'package:pamukkale_app/ui/views/home.dart';
import 'package:pamukkale_app/ui/views/login.dart';
import 'package:pamukkale_app/ui/views/my_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit(),),
        BlocProvider(create: (context) => LoginCubit(),),
        BlocProvider(create: (context) => MyProfileCubit(),),
        BlocProvider(create: (context) => SignUpCubit(),),
        BlocProvider(create: (context) => TripDetailCubit(),),
        BlocProvider(create: (context) => TripCubit(),),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Home(),
      ),
    );
  }
}