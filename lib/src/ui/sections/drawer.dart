import 'package:app_cet/src/config/constants/constants.dart';
import 'package:app_cet/src/config/themes/colors.dart';
import 'package:app_cet/src/core/services/authentication_service.dart';
import 'package:app_cet/src/ui/pages/account/profile_page.dart';
import 'package:app_cet/src/ui/pages/home_page.dart';
import 'package:app_cet/src/utils/utilities/global_var.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../main_imports.dart';
import '../pages/app_page.dart';

class HomeDrawer extends StatefulWidget {
  final Function drawerHandler;

  HomeDrawer(this.drawerHandler);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            _headerSection(),
            _accountSection(),
            _divider(height: 4),
            context.addHeight(16),
            _singleItem(
                text: 'Home',
                onTap: () {
                  Navigator.pop(context);
                  widget.drawerHandler(HomePage(), 'Home');
                }),
            _singleItem(text: str.app.privecyAndUsage, onTap: () => appPageNavigation(context, 'TermsAndConditions', str.app.privecyAndUsage)),
            _singleItem(text: str.main.about, onTap: () => appPageNavigation(context, 'About', str.main.about)),
          ],
        ),
      ),
    );
  }

  Widget _singleItem({required String text, void Function()? onTap}) {
    return ListTile(
      leading: const SizedBox(),
      title: Text(text, style: context.textTheme.headlineMedium?.copyWith(fontSize: 14)),
      onTap: () {
        if (onTap != null) onTap();
      },
      visualDensity: VisualDensity.compact,
    );
  }

  void appPageNavigation(BuildContext context, String pageType, String pageTitle) {
    Navigator.pop(context);
    context.navigatePage(AppPage(pageType: pageType, pageTitle: pageTitle));
  }

  Widget _divider({double height = 1}) {
    return Container(width: double.infinity, height: height, color: Colors.grey.shade100);
  }

  Widget _headerSection() {
    return Container(
      height: 150,
      width: double.infinity,
      child: Image.asset(kLogo),
    );
  }

  Widget _accountSection() {
    return Consumer<AuthenticationService>(
      builder: (context, value, child) {
        return ListTile(
          leading: Icon(Icons.person, color: kPrimaryColor),
          title: Text(
            value.user?.fullName ?? '',
            style: context.textTheme.headlineMedium,
          ),
          onTap: () {
            Navigator.pop(context);
            context.navigateName(ProfilePage.routeName);
          },
        );
      },
    );
  }
}
