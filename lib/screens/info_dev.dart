import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoDeveloper extends StatelessWidget {
  const InfoDeveloper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          'About Me',
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 37, color: Colors.black),
        ),
      ),
      backgroundColor: Color(0xFFBFD7EA),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 90,
                  backgroundImage: NetworkImage(
                      'https://media-exp1.licdn.com/dms/image/C5603AQH95LCm_KXhZw/profile-displayphoto-shrink_800_800/0/1617766896549?e=1634774400&v=beta&t=mIHsEs4NwDiqRGGIKet9ugiHVm1J93E4wLO72I6JTdU'),
                ),
                Text(
                    'My name is Shreyans Jain. I am currently pursuing my B.Tech in CSE at NIIT University. I have been into Flutter App development professionally in my previous internship at TMHM Hyderabad and worked for around 11 months, from August 2020 to July 2021.'),
                Text(
                    'I had developed quite few apps in this period, in which 2 were publised on the Play store and 1 of them also on the App Store. Unfortunately, one of the apps had to be shut down a few months back. Apart from those, I created an app for NIIT University as well and it is currently live on both Play Store and App Store.'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await launch('https://github.com/shreyansja1n');
                      },
                      iconSize: 40,
                      icon: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue[300],
                        backgroundImage: NetworkImage(
                          "https://img.icons8.com/material-sharp/250/000000/github.png",
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Center(
                                        child: Text(
                                      'App Store and Play Store links',
                                    )),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await launch(
                                            'https://play.google.com/store/apps/details?id=com.instils.instilsvirtualexhibition');
                                      },
                                      child: Text(
                                          'NU-Instils Exhibition App - Play Store'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await launch('https://cutt.ly/dQePe4u');
                                      },
                                      child: Text(
                                          'NU-Instils Exhibition App - App Store'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await launch(
                                            'https://play.google.com/store/apps/details?id=com.plumsoft.bizybee');
                                      },
                                      child: Text('SSR Daili - Play Store'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await launch(
                                            'https://apps.apple.com/in/app/plumerp/id1575521579');
                                      },
                                      child: Text('SSR Daili - Play Store'),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      iconSize: 40,
                      icon: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue[300],
                        backgroundImage: NetworkImage(
                            "https://img.icons8.com/ios-filled/150/000000/google-play.png",
                            scale: 90),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50.0, vertical: 30),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ContactButtons('Name', 'Shreyans Jain',
                                        'https://shreyansjain18.wixsite.com/shreyansjain'),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ContactButtons('Phone', '+91 958 200 3523',
                                        'tel://+919582003523'),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ContactButtons(
                                        'Email',
                                        'shreyansja1n@outlook.com',
                                        'mailto:shreyansja1n@outlook.com'),
                                  ],
                                ),
                              );
                            });
                      },
                      iconSize: 40,
                      icon: CircleAvatar(
                        radius: 20,
                        child: Icon(
                          Icons.phone,
                          color: Colors.black,
                          size: 30,
                        ),
                        backgroundColor: Colors.blue[300],
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await launch(
                            'https://www.linkedin.com/in/shreyans-jain-318337103/');
                      },
                      iconSize: 40,
                      icon: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue[300],
                        backgroundImage: NetworkImage(
                            "https://img.icons8.com/ios-glyphs/240/000000/linkedin-circled--v1.png"),
                      ),
                    ),
                  ],
                ),
                Text('Made with ❤️ by Shreyans Jain')
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContactButtons extends StatelessWidget {
  String title;
  String content;
  String url;

  ContactButtons(this.title, this.content, this.url);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        await launch(url);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            content,
            style: TextStyle(fontFamily: 'Default'),
          ),
        ],
      ),
    );
  }
}
