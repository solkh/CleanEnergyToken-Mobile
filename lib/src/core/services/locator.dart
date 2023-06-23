import 'package:app_cet/src/core/controllers/app_parameters_provider.dart';
import 'package:app_cet/src/core/controllers/cet_data_provider.dart';
import 'package:app_cet/src/core/controllers/user_provider.dart';
import 'package:app_cet/src/core/services/authentication_service.dart';
import 'package:app_cet/src/utils/providers/sol_api.dart';
import 'package:get_it/get_it.dart';

import '../controllers/app/app_state_manager.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(AppStateManager());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => SolApi());
  locator.registerLazySingleton(() => AppParametersProvider());
  locator.registerLazySingleton(() => CetDataProvider());
  locator.registerLazySingleton(() => UserProvider());
}
