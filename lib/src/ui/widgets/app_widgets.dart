import 'package:flutter/material.dart';

import '../../../main_imports.dart';
import '../../config/constants/constants.dart';
import '../../config/themes/colors.dart';
import '../../utils/utilities/global_var.dart';

class AppBarWidget {
  static PreferredSizeWidget getAppBar({Widget? leading}) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Image.asset(kLogo),
      ),
      centerTitle: true,
      leading: leading,
    );
  }
}

class NoDataAvailableWidget extends StatelessWidget {
  final String? msg;
  final String? imageName;
  const NoDataAvailableWidget({this.msg, this.imageName});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(kAssetsImageBase + (imageName ?? 'no_data_available.png'), color: kAccentColor, height: 100),
          context.addHeight(16),
          Center(child: Text(msg ?? str.msg.noDataAvailable, style: context.textTheme.bodyLarge!.copyWith(color: kAccentColor.withOpacity(0.7)))),
        ],
      ),
    );
  }
}
