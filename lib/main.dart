import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Add this import
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:recipe_project/data_layer/services/auth_service.dart';
import 'package:recipe_project/domain_layer/bloc/bloc_post/bloc_post.dart'; // Import your BLoCs
import 'package:recipe_project/domain_layer/bloc/bloc_post/bloc_post_event.dart';
import 'package:recipe_project/domain_layer/bloc/bloc_user/bloc_user.dart';
import 'package:recipe_project/domain_layer/bloc/bloc_user/bloc_user_event.dart';
import 'package:recipe_project/domain_layer/change_notifiers/registration_controller.dart';
import 'package:recipe_project/firebase_options.dart';
import 'package:recipe_project/presentation_layer/ui/recipe_main_ui.dart';
import 'package:recipe_project/presentation_layer/ui/recipe_register_ui.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PostBloc()..add(GetPosts(false)),
        ),
        BlocProvider(
          create: (_) => UserBloc()..add(LoadUser()),
        ),
        BlocProvider(
          create: (_) => SavedPostBloc(),
        ),
        BlocProvider(
          create: (_) => LikePostBloc(),
        ),
        BlocProvider(
          create: (_) => CommentBloc(),
        )
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => RegistrationController(),
          ),
        ],
        child: MaterialApp(
          title: 'Recipe Melayu',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: TextTheme(
              bodyLarge: TextStyle(fontFamily: 'lifeIsGoofy', fontSize: 29),
              bodyMedium: TextStyle(fontFamily: 'lifeIsGoofy', fontSize: 29),
              bodySmall: TextStyle(fontFamily: 'lifeIsGoofy', fontSize: 29),
              displayLarge: TextStyle(fontFamily: 'lifeIsGoofy', fontSize: 29),
              displayMedium: TextStyle(fontFamily: 'lifeIsGoofy', fontSize: 29),
              displaySmall: TextStyle(fontFamily: 'lifeIsGoofy', fontSize: 29),
              headlineLarge: TextStyle(fontFamily: 'lifeIsGoofy', fontSize: 29),
              headlineMedium:
                  TextStyle(fontFamily: 'lifeIsGoofy', fontSize: 29),
              headlineSmall: TextStyle(fontFamily: 'lifeIsGoofy', fontSize: 29),
              titleLarge: TextStyle(fontFamily: 'lifeIsGoofy', fontSize: 29),
              titleMedium: TextStyle(fontFamily: 'lifeIsGoofy', fontSize: 29),
              titleSmall: TextStyle(fontFamily: 'lifeIsGoofy', fontSize: 29),
              labelLarge: TextStyle(fontFamily: 'lifeIsGoofy', fontSize: 29),
              labelMedium: TextStyle(fontFamily: 'lifeIsGoofy', fontSize: 29),
              labelSmall: TextStyle(fontFamily: 'lifeIsGoofy', fontSize: 29),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: StreamBuilder<User?>(
            stream: AuthService.userStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Something went wrong!'));
              } else if (snapshot.hasData && AuthService.isEmailVerified) {
                return const MainPage();
              } else {
                return const RegisterPage();
              }
            },
          ),
        ),
      ),
    );
  }
}
