import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(98, 206, 60, 1),
        title: const Text(
          'رجوع',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.green,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        'assets/logo.png',
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.width * 0.6,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'حسابات شركة سرور -',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    _buildImageWithText(
                      imageUrl: 'assets/fac.png',
                      label: 'فيسبوك',
                      width: 60,
                      height: 60,
                      url: 'https://web.facebook.com/Sroursrour2',
                    ),
                    const SizedBox(height: 25),
                    _buildImageWithText(
                      imageUrl: 'assets/inst.webp',
                      label: 'انستغرام',
                      width: 60,
                      height: 60,
                      url:
                          'https://www.instagram.com/srour__company?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==',
                    ),
                    const SizedBox(height: 25),
                    _buildImageWithText(
                      imageUrl: 'assets/what.png',
                      label: 'واتساب',
                      width: 60,
                      height: 60,
                      url:
                          'https://api.whatsapp.com/send/?phone=962780272000&text&type=phone_number&app_absent=0',
                    ),
                    const SizedBox(height: 20),
                    const Divider(
                      color: Colors.white,
                      thickness: 1,
                      height: 20,
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'اصدار : 1.1.6',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageWithText({
    required String imageUrl,
    required String label,
    required double width,
    required double height,
    required String url,
  }) {
    return GestureDetector(
      onTap: () => launch(url),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                imageUrl,
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    try {
      await launch(url);
    } catch (e) {
      throw 'Could not launch $url: $e';
    }
  }
}
