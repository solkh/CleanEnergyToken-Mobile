import 'package:app_jtak_delivery/src/core/controllers/order_provider.dart';
import 'package:app_jtak_delivery/src/ui/pages/order/order_widgets.dart';
import 'package:app_jtak_delivery/src/utils/custom_widgets/infinite_listview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  static const String routeName = '/OrdersPage';
  const OrdersPage();
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late OrderProvider provider;

  @override
  void initState() {
    loadinitData();
    super.initState();
  }

  void loadinitData() async {
    OrderProvider provider = Provider.of<OrderProvider>(context, listen: false);
    provider.refreshData();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<OrderProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: _pageBody(context, provider),
      ),
    );
  }

  Widget _pageBody(BuildContext context, OrderProvider provider) {
    return InfiniteListview(
      modelProvider: provider,
      loadDataFun: provider.loadPagedData,
      listItemWidget: (item) => OrderSingleItem(item),
    );
  }
}
