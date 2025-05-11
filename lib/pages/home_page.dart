import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:venhanh/theme/pallete.dart';
import 'package:venhanh/widgets/threed_button.dart';
import 'package:venhanh/pages/prompt_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isGoogleTextHovered = false;
  bool _isGithubIconHovered = false;

  void _playButtonPressed() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PromptPage()),
        );
      }
    });
  }

  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Vẽ, nhanh!',
              style: GoogleFonts.gloriaHallelujah(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Pallete.primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Vẽ 5 hình, mỗi hình 20 giây.\n AI đoán thử, bạn vẽ gì đây?',
              textAlign: TextAlign.center,
              style: GoogleFonts.gloriaHallelujah(
                fontSize: 26,
                color: Pallete.textColor,
              ),
            ),
            const SizedBox(height: 40),
            ThreeDButton(
              onPressed: _playButtonPressed,
              height: 70,
              width: 200,
              child: Text(
                'Bắt đầu chơi!',
                style: GoogleFonts.gloriaHallelujah(
                  color: Pallete.textColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style.copyWith(
                  fontSize: 16,
                  color: Pallete.textColor,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
                children: <InlineSpan>[
                  const TextSpan(text: 'A clone of '),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: MouseRegion(
                      onEnter:
                          (_) => setState(() => _isGoogleTextHovered = true),
                      onExit:
                          (_) => setState(() => _isGoogleTextHovered = false),
                      child: InkWell(
                        onTap:
                            () =>
                                _launchURL('https://quickdraw.withgoogle.com'),
                        borderRadius: BorderRadius.circular(3),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow:
                                _isGoogleTextHovered
                                    ? [
                                      BoxShadow(
                                        color: Pallete.blackColor.withAlpha(40),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                      ),
                                    ]
                                    : [],
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            'Google Quick, Draw!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  _isGoogleTextHovered
                                      ? Pallete.primaryColor
                                      : Pallete.textColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            MouseRegion(
              onEnter: (_) => setState(() => _isGithubIconHovered = true),
              onExit: (_) => setState(() => _isGithubIconHovered = false),
              child: InkWell(
                onTap:
                    () =>
                        _launchURL('https://github.com/tueduong05-uit/venhanh'),
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow:
                        _isGithubIconHovered
                            ? [
                              BoxShadow(
                                color: Pallete.blackColor.withAlpha(40),
                                spreadRadius: 1,
                                blurRadius: 1,
                              ),
                            ]
                            : [],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    Icons.code,
                    color:
                        _isGithubIconHovered
                            ? Pallete.primaryColor
                            : Pallete.blackColor,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
