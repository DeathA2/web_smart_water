import 'package:flutter/material.dart';
import 'package:web_smart_water/config/theme_config.dart';

class FooterItem extends StatelessWidget{
  const FooterItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: ThemeConfig.greyColor.withOpacity(0.5)))
      ),
      alignment: Alignment.center,
      height: 50,
      child: Text(
        'Copyright © 2022 STVG CO., LTD. All rights reserved.',
        style: ThemeConfig.smallStyle.copyWith(
          color: ThemeConfig.greyColor
        ),
      ),
    );
  }
}