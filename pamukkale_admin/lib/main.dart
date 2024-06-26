import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamukkale_admin/ui/cubits/add_trip_cubit.dart';
import 'package:pamukkale_admin/ui/cubits/login_cubit.dart';
import 'package:pamukkale_admin/ui/cubits/panel_cubit.dart';
import 'package:pamukkale_admin/ui/cubits/trip_detail_cubit.dart';
import 'package:pamukkale_admin/ui/login.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
  return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddTripCubit(),),
        BlocProvider(create: (context) => LoginCubit(),),
        BlocProvider(create: (context) => PanelCubit(),),
        BlocProvider(create: (context) => TripDetailCubit(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Login(),
      ),
    );
  
  }
}
