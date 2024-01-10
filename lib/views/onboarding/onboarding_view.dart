import 'package:flutter/material.dart';
import 'package:myfitwizz/constants/constants.dart';
import 'package:myfitwizz/constants/routes.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: scaffoldPaddingVar,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'images/get_started_background_image.png'), // Replace with your image asset path
              fit: BoxFit.cover, // This will cover the entire container space
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Aligns children vertically at the start and end of the column
            crossAxisAlignment:
                CrossAxisAlignment.center, // Centers children horizontally

            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    // Image of the muscular person
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset('images/get_started.png'),
                    ),
                    // Welcome text
                    const Padding(
                      padding: EdgeInsets.only(top: 120),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Welcome to MyFitWizz',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white, // Text color
                            fontWeight: FontWeight.bold, // Bold text
                            fontSize: 30, // Font size
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 125),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text('Elevate yourself\nOne Exercise at a time.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black, // Text color
                              fontWeight: FontWeight.w500,

                              fontSize: 24,
                            )),
                      ),
                    ),
                    // Get Started button
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              signInUpRoute,
                            );
                            // Button click event
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.yellow, // Background color of the button
                            foregroundColor:
                                Colors.black, // Text color of the button
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50.0,
                              vertical: 12.0,
                            ), // Padding inside the button
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              fontWeight: FontWeight.bold, // Bold text
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
