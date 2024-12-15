import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sesame/home_screen/srour.dart';
import 'package:sesame/shop_cart/cubit/cart_cubit.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const SROUR());
}

class SROUR extends StatelessWidget {
  const SROUR({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartCubit(),
        ),
      ],
      child: const MaterialApp(
        title: "SROUR",
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _greenWidth = 0.5; // عرض الجزء الأخضر يبدأ من النصف

  @override
  void initState() {
    super.initState();
    // تغيير العرض الأخضر بسرعة
    Future.delayed(const Duration(milliseconds: 500), _startAnimation);
  }

  // دالة لتغيير عرض الجزء الأخضر
  void _startAnimation() {
    setState(() {
      _greenWidth = 1.0; // تمدد الجزء الأخضر ليملأ الشريط
    });

    // إعادة تعيين الشريط إلى النصف بعد مرور فترة معينة
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _greenWidth = 0.0; // جعل الجزء الأخضر يختفي
      });
    });

    // تكرار الحركة كل 2 ثانية
    Future.delayed(const Duration(seconds: 2), _navigateToNextScreen);
  }

  // دالة للتنقل إلى الصفحة التالية بعد تأخير
  void _navigateToNextScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ConnectionCheckScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDC824), // اللون المطلوب
      body: Stack(
        children: [
          // الصورة في الوسط
          Center(
            child: Image.asset(
              'assets/icons/logo.png', // مسار الشعار
              width: 250, // العرض الثابت
              height: 250, // الارتفاع الثابت
              fit: BoxFit.contain, // المحافظة على نسبة الأبعاد
            ),
          ),
          // النص أسفل التطبيق
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                '1.1.6',
                style: TextStyle(
                  fontSize: 20, // حجم الخط
                  fontWeight: FontWeight.bold, // الخط عريض
                  color: Colors.white, // لون النص أبيض
                ),
              ),
            ),
          ),
          // شريط التحميل أسفل الشاشة
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 3, // ارتفاع شريط التحميل
              width: MediaQuery.of(context)
                  .size
                  .width, // عرض الشريط يغطي كامل الشاشة
              color: Colors.white, // خلفية بيضاء للشريط
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                width: MediaQuery.of(context).size.width * _greenWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green,
                      Colors.white
                    ], // تدرج لوني أخضر ثم أبيض
                    stops: [_greenWidth, _greenWidth], // اللون الأخضر في النصف
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ConnectionCheckScreen extends StatefulWidget {
  const ConnectionCheckScreen({super.key});

  @override
  _ConnectionCheckScreenState createState() => _ConnectionCheckScreenState();
}

class _ConnectionCheckScreenState extends State<ConnectionCheckScreen> {
  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkConnection();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        isConnected = result != ConnectivityResult.none;
      });
    });
  }

  Future<void> _checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      isConnected = connectivityResult != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isConnected ? Srour() : const OfflineScreen();
  }
}

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'لا يوجد اتصال بالشبكة ',
              style: TextStyle(fontSize: 24, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
