import 'package:app_cet/src/core/controllers/app/base_provider.dart';
import '../services/locator.dart';
import '../services/authentication_service.dart';

class InitialDataProvider extends BaseProvider {
  Future<void> getInitData() async {
    try {
      await locator<AuthenticationService>().loadUserData();
    } catch (error) {
      rethrow;
    }
  }
}
