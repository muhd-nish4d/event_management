import 'package:flutter/material.dart';

class ScreenPrivacyPolicy extends StatelessWidget {
  const ScreenPrivacyPolicy({super.key, required this.isAbout});
  final bool isAbout;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_rounded)),
            Center(
              child: SizedBox(
                width: screenSize.width * .8,
                height: screenSize.height * .8,
                child: Card(
                    elevation: 2,
                    child: isAbout
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: ,
                            children: const [
                              Text('EventHub'),
                              Text('Developed by Muhammed Nishad'),
                              Text('Version 1.0.0')
                            ],
                          )
                        : const SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("""Introduction:
      
a. "Event Hub" respects the privacy of its users and is committed to protecting their personal information.
b. This Privacy Policy outlines the types of personal data collected, how it is used, and the rights and choices users have regarding their information.

Information Collection:

a. "Event Hub" collects personal information such as name, email address, profile picture, and location during the registration process.
b. Users may voluntarily provide additional information such as a biography, work experience, or event preferences.

Usage of Personal Data:

a. "Event Hub" uses the provided personal information to facilitate the app's features and functionality, including user authentication, profile creation, and event booking.
b. User data, including posts, likes, and follows, may be used to enhance the user experience, provide personalized recommendations, and improve the app's services.
c. "Event Hub" may use email addresses to send important updates, notifications, or marketing materials. Users can opt out of marketing communications.

Sharing of Personal Data:

a. Personal data, such as user profiles and posts, may be visible to other users within the app.
b. "Event Hub" may share personal information with third-party service providers to support app functionality, analytics, and security.
c. User data will not be sold, rented, or disclosed to third parties for their marketing purposes without explicit consent, except as required by law.

Data Security:

a. "Event Hub" takes reasonable measures to protect personal information from unauthorized access, loss, or alteration.
b. Users should also take precautions to protect their account information and choose strong passwords.

Data Retention:

a. "Event Hub" retains personal information for as long as necessary to provide the app's services and comply with legal obligations.
b. Users can request the deletion of their account and associated data through the app's settings or by contacting support.

Children's Privacy:

a. "Event Hub" is not intended for children under the age of 13. Users under 13 must obtain parental consent to use the app.

Changes to the Privacy Policy:

a. "Event Hub" may update the Privacy Policy periodically. Users will be notified of any material changes.

Contact Information:

a. Users can contact "Event Hub" for any questions, concerns, or requests related to their personal data."""),
                            ),
                          )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
