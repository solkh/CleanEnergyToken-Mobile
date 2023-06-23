import 'package:app_jtak_delivery/src/core/controllers/order_provider.dart';
import 'package:app_jtak_delivery/src/core/enums/order_status_enum.dart';
import 'package:app_jtak_delivery/src/core/models/order_model.dart';
import 'package:app_jtak_delivery/src/ui/widgets/app_widgets.dart';
import 'package:app_jtak_delivery/src/ui/widgets/price_widgets.dart';
import 'package:app_jtak_delivery/src/utils/custom_widgets/dotted_separater.dart';
import 'package:app_jtak_delivery/src/utils/custom_widgets/messages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../main_imports.dart';
import '../../../config/themes/app_theme.dart';
import '../../../utils/utilities/global_var.dart';

class OrderDetailsPage extends StatefulWidget {
  static const String routeName = '/OrderDetailsPage';
  final OrderModel order;
  const OrderDetailsPage(this.order);
  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  late OrderProvider provider;
  @override
  void initState() {
    super.initState();
    Provider.of<OrderProvider>(context, listen: false).setOrderObject(widget.order);
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(str.app.orderDetails),
      ),
      body: FullScreenLoading(
        inAsyncCall: provider.isBusy,
        child: SafeArea(child: _pageBody()),
      ),
    );
  }

  Widget _pageBody() {
    if (provider.orderIsEmpty()) {
      if (provider.isBusy) return const SizedBox();
      return const NoDataAvailableWidget();
    }
    return ListView(
      children: [
        _orderCard(),
        // ...provider.order!.orderDetails?.map((e) => OrderDetailsSingleItem(e)).toList() ?? [],
      ],
    );
  }

  Widget _orderCard() {
    return Card(
      child: Padding(
        padding: AppTheme.standardPadding,
        child: Column(
          children: [
            _singleRowItem(str.app.orderNumber, provider.order!.id.toString()),
            _singleRowItem(str.app.orderDate, GlobalVar.dateForamt(provider.order!.purchaseDate) ?? ''),
            _singleRowItem(str.main.description, provider.order!.description ?? ''),
            _singleRowItem(str.formAndAction.phone, provider.order!.phonenumber ?? ''),
            _singleRowItem(str.formAndAction.address, provider.order!.address ?? ''),
            _singleRowItem(str.app.orderStatus, provider.order!.orderStatus?.value ?? ''),
            _singleRowItem(str.app.total, PriceTextWidget.small(price: provider.order!.price)),
          ],
        ),
      ),
    );
  }

  Widget _singleRowItem(String title, dynamic text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
      child: Row(
        children: [
          Expanded(child: Text(title, style: context.textTheme.headlineSmall)),
          if (text is Widget) Expanded(child: text),
          if (text is String) Expanded(child: Text(text, style: context.textTheme.bodyLarge)),
        ],
      ),
    );
  }

  void reqFun(Future Function() function) async {
    try {
      await function();
    } catch (err) {
      showDialog(context: context, builder: (context) => CustomDialog(message: err.toString()));
    }
  }
}
