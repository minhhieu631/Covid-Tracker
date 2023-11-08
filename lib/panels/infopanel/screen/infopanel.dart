import 'package:covid_19/datasource/datasorce.dart';
import 'package:covid_19/panels/faqs/screen/faqs.dart';
import 'package:covid_19/widget/web_view/web_view_screen.dart';
import 'package:flutter/material.dart';

class InfoPanel extends StatelessWidget {
  const InfoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        containerTap(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FAQS()));
            },
            title: 'THÔNG TIN'),
        containerTap(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebViewScreen(
                        url: 'https://covid19responsefund.org/en/',
                        callbackUrl: (_) {},
                        title: 'ỦNG HỘ QUỸ CHỐNG DỊCH',
                        isShowButtonBack: true,
                        isCallback: false,
                      )));
            },
            title: 'ỦNG HỘ QUỸ CHỐNG DỊCH'),
        containerTap(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebViewScreen(
                        url:
              'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/myth-busters',
                        callbackUrl: (_) {},
                        title: 'MYTH BUSTERS',
                        isShowButtonBack: true,
                        isCallback: false,
                      )));
            },
            title: 'MYTH BUSTERS'),
      ],
    );
  }

  Widget containerTap({required Function onTap, required String title}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        color: primaryBlack,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
