import 'package:app_cet/src/core/controllers/app/base_provider.dart';
import 'package:app_cet/src/core/models/phone_number_model.dart';
import 'package:app_cet/src/utils/providers/sol_api.dart';
import 'package:flutter/foundation.dart' show debugPrint;

import '../models/user_model.dart';
import '../services/authentication_service.dart';
import '../services/locator.dart';

class UserProvider extends BaseProvider {
  final SolApi _api = locator<SolApi>();
  AuthenticationService authService = locator<AuthenticationService>();
  String apiPrefex = SolApi.apiVersionPrefex + '/Authorization';
  String? fullName, email, oldPassword, newPassword;
  PhoneNumberModel? phoneNumber;

  void loadUserDataProfile() async {
    if (authService.user == null) {
      await loadUserData();
    }
    fullName = authService.user?.fullName;
    email = authService.user?.email;
  }

  Future<void> loadUserData() async {
    await loadBaseData(
      loadBody: () async {
        await authService.loadUserData();
      },
    );
  }

  Future<void> loginByPhone(String phoneNumber, String code) async {
    await loadBaseData(
      loadBody: () async {
        await authService.loginByPhone(phoneNumber, code);
      },
    );
  }

  Future<UserModel?> loginByMnemonic(String mnemonic) async {
    return await loadBaseData(
      loadBody: () async {
        await authService.loginByMnemonic(mnemonic);
      },
    );
  }
  Future<UserModel?> loginOrRegisterByMnemonic(String mnemonic, String username) async {
    return await loadBaseData(
      loadBody: () async {
        await authService.loginOrRegisterByMnemonic(mnemonic, username);
      },
    );
  }

  Future<void> registerOrSignInByPhoneNumber(String phoneNumber) async {
    await loadBaseData(
      loadBody: () async {
        Map<String, String> body = {"phoneNumber": phoneNumber};
        var res = await _api.postRequest('/Account/RegisterOrSignInByPhoneNumber', body, apiPrefex: apiPrefex);
        debugPrint('registerOrSignInByPhoneNumber : $res');
      },
    );
  }

  Future resendSmsCode(String phoneNumber) async {
    await loadBaseData(
      loadBody: () async {
        Map<String, String> body = {"phoneNumber": phoneNumber};
        await _api.postRequest('/Account/ResendSmsCode', body, apiPrefex: apiPrefex);
      },
    );
  }

  Future<void> login(String email, String password) async {
    await loadBaseData(
      loadBody: () async {
        await authService.login(email, password);
      },
    );
  }

  Future<void> update() async {
    await loadBaseData(
      loadBody: () async {
        Map body = {
          "fullName": fullName,
          "email": email
        };
        await _api.postRequest('/Account/UpdateUser', body, apiPrefex: apiPrefex);
        authService.user?.fullName = fullName;
        authService.user?.email = email;
      },
    );
  }

  Future<void> changePassword() async {
    await loadBaseData(
      loadBody: () async {
        Map body = {
          "oldPassword": oldPassword,
          "newPassword": newPassword,
          "confirmPassword": newPassword,
        };
        await _api.postRequest('/Account/ChangePassword', body, apiPrefex: apiPrefex);
      },
    );
  }

  Future setLang(String lang) async {
    await loadBaseData(
      loadBody: () async {
        Map body = {"lang": lang};
        await _api.postRequest('/Account/SetLang', body, apiPrefex: apiPrefex);
      },
    );
  }
}
