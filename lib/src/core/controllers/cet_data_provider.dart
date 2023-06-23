import 'package:app_cet/src/core/controllers/app/base_provider.dart';
import 'package:app_cet/src/core/models/home_model.dart';
import 'package:app_cet/src/core/services/locator.dart';
import 'package:app_cet/src/utils/providers/sol_api.dart';

class CetDataProvider extends BaseProvider<HomeModel> {
  final SolApi _api = locator<SolApi>();

  Future refreshData() async {
    await loadIncentive();
  }

  Future<HomeModel> load() async {
    var res = await _api.getRequest('/Home');
    return HomeModel.fromMap(res);
  }

  Future<List<String>> generateMnemonic() async {
    var res = await _api.getRequest('/BlockChain/GenerateMnemonic');
    return (res as List).map((item) => item as String).toList();
  }

  Future loadIncentive() async {
    var res = await _api.getRequest('/Incentives');
    return res as int;
  }
}
