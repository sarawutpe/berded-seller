import 'package:berded_seller/src/constants/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.lightPrimary,
        title: Text("สตูดิโอ"),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: _buildBackgroundList(),
      ),
    );
  }

  _buildBackgroundList() {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        _buildBackground(),
        _buildBackground(),
        _buildBackground(),
        _buildBackground(),
      ],
    );
  }

  _buildBackground() {
    return Stack(
      children: [
        Container(
          child: Material(
            color: Colors.white,
            elevation: 8,
            borderRadius: BorderRadius.circular(8),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: InkWell(
              splashColor: Colors.black26,
              onTap: () => {},
              child: Ink.image(
                image: AssetImage('assets/images/studio_bg_01.jpg'),
                width: 170,
                height: 170,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          child: SizedBox(
            width: 170,
            height: 170,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'XXX-XXX-XXX',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
          ),
        ),
        Positioned(
          left: 90,
          bottom: -110,
          child: Container(
            child: SizedBox(
              width: 170,
              height: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ราคา',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    'XXX.-',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
