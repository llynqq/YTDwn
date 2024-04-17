import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double boxWidth = MediaQuery.of(context).size.width * 0.85;

    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/warning.svg',
            height: 200,
          ),
          SizedBox(height: 30),
          Text('Warning: Downloading copyrighted content is illegal',
              style: TextStyle(color: Colors.yellow)),
          SizedBox(height: 30),
          Container(
            width: boxWidth,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.4,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[300], // Gray box color
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Terms of Use Agreement\n\nLast Updated: 11.2. 2024\n\nWelcome to YTDwn!\n\nPlease read these Terms of Use (\"Agreement\") carefully before using YTDwn (\"the Application\"). By using the Application, you agree to be bound by these terms. If you do not agree to these terms, please do not use the Application.\n\n1. Acceptance of Terms\n\nBy using the Application, you acknowledge that you have read, understood, and agree to be bound by these Terms of Use. We reserve the right to update or change these terms at any time, and your continued use of the Application after such changes constitutes your acceptance of the new terms.\n\n2. Use of the Application\n\n2.1 Educational Purpose Only: YTDwn is intended for educational purposes only. The application is designed to download YouTube videos for offline viewing solely for educational use. Any other use of the Application may violate copyright and other laws.\n\n2.2 Compliance with YouTube Terms of Service: Users are required to comply with YouTube's Terms of Service (https://www.youtube.com/t/terms) while using the Application. We are not responsible for any violations of YouTube's terms by the users.\n\n3. Copyright and Intellectual Property\n\n3.1 Ownership: We do not claim ownership of the videos downloaded through the Application. The copyrights and intellectual property rights of the videos remain with the respective content creators.\n\n3.2 Fair Use: Users are advised to use the downloaded content in accordance with the principles of fair use as defined by copyright law. We are not responsible for any misuse or copyright infringement by the users.\n\n4. Prohibited Activities\n\n4.1 Illegal Use: Users are prohibited from using the Application for any illegal or unauthorized purpose. This includes but is not limited to violating copyright laws, distributing inappropriate content, or engaging in any illegal activity.\n\n4.2 Modification or Reverse Engineering: Users are not allowed to modify, adapt, translate, reverse engineer, decompile, or disassemble the Application or any part thereof.\n\n5. Limitation of Liability\n\nWe shall not be liable for any direct, indirect, incidental, special, consequential, or exemplary damages, including but not limited to damages for loss of profits, goodwill, use, data, or other intangible losses resulting from the use or inability to use the Application.\n\n6. Termination\n\nWe reserve the right to terminate or suspend access to the Application at any time, with or without cause, and with or without notice.\n\n7. Governing Law\n\nThis Agreement shall be governed by and construed in accordance with the laws of the Czech Republic, without regard to its conflict of law principles.\n\nContact Information:\n\nIf you have any questions or concerns about these Terms of Use, please contact me at \“tomko.fi.2020@skola.ssps.cz\”.\n\nThank you for using YTDwn for educational purposes!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
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
