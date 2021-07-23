import 'package:favorite_restaurant_app/common/style.dart';
import 'package:favorite_restaurant_app/provider/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuCard extends StatelessWidget {
  final String urlImage;
  final String name;

  MenuCard(this.urlImage, this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color:
              Provider.of<SettingsProvider>(context, listen: false).isDarkTheme
                  ? Colors.grey[700]
                  : mainColor,
          borderRadius: BorderRadius.circular(8)),
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              image: DecorationImage(
                  image: NetworkImage(urlImage), fit: BoxFit.cover),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              name,
              style: titleStyle.copyWith(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
