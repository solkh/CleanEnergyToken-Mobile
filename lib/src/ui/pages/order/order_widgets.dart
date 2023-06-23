import 'package:app_jtak_delivery/src/config/constants/constants.dart';
import 'package:app_jtak_delivery/src/config/themes/colors.dart';
import 'package:app_jtak_delivery/src/core/controllers/order_provider.dart';
import 'package:app_jtak_delivery/src/core/enums/order_details_status_enum.dart';
import 'package:app_jtak_delivery/src/core/models/merchant_order_details.dart';
import 'package:app_jtak_delivery/src/core/models/order_details_model.dart';
import 'package:app_jtak_delivery/src/core/models/order_model.dart';
import 'package:app_jtak_delivery/src/ui/widgets/price_widgets.dart';
import 'package:app_jtak_delivery/src/utils/custom_widgets/button.dart';
import 'package:app_jtak_delivery/src/utils/custom_widgets/image_widgets.dart';
import 'package:app_jtak_delivery/src/utils/custom_widgets/messages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/utilities/global_var.dart';
import '../../../../main_imports.dart';

class OrderSingleItem extends StatelessWidget {
  final OrderModel item;
  const OrderSingleItem(this.item);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        // onTap: () {
        //   context.navigateName(OrderDetailsPage.routeName, data: item);
        // },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    var status = orderProvider.getOrderStatus(item);
    if (status == OrderDetailsStatus.delivered) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _orderInfo(context),
            if (status == OrderDetailsStatus.delivered)
              Text(
                'الطلب منتهي',
                style: context.textTheme.displaySmall?.copyWith(color: kAccentColor),
              ),
          ],
        ),
      );
    } else {
      return ExpansionTile(
        initiallyExpanded: status != OrderDetailsStatus.delivered,
        childrenPadding: EdgeInsets.symmetric(horizontal: 8),
        title: Column(
          children: [
            _orderInfo(context),
            if (status == OrderDetailsStatus.delivered)
              Text(
                'الطلب منتهي',
                style: context.textTheme.displaySmall?.copyWith(color: kAccentColor),
              ),
          ],
        ),
        children: <Widget>[
          _orderStatus(context),
          _orderItems(),
          _customerSection(context),
        ],
      );
    }
  }

  Widget _orderInfo(BuildContext context) {
    return Row(
      children: [
        PriceTextWidget.small(price: item.price),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              GlobalVar.dateForamt(item.purchaseDate, kDateTimeFormat) ?? '',
              style: context.textTheme.bodyLarge,
            ),
            Text(
              '#${item.id}',
              style: context.textTheme.headlineMedium,
            ),
          ],
        ),
      ],
    );
  }

  Widget _orderStatus(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    var status = orderProvider.getOrderStatus(item);

    return Row(
      children: [
        Text(orderProvider.getOrderStatus(item).value, style: context.textTheme.headlineSmall?.copyWith(color: kAccentColor)),
        const Spacer(),
        if (GlobalVar.checkString(item.mapsUrl) && status != OrderDetailsStatus.delivered)
          ElevatedButton.icon(
              label: Text('تتبع الموقع'),
              icon: Icon(Icons.location_on_sharp, size: 18),
              onPressed: () {
                try {
                  launch(item.mapsUrl ?? '');
                } catch (err) {
                  showDialog(context: context, builder: (context) => CustomDialog(message: err.toString()));
                }
              }),
      ],
    );
  }

  Widget _orderItems() {
    return Column(
      children: item.orderDetails!.map((e) => MerchentOrderDetails(e, item.id!)).toList(),
    );
  }

  Widget _customerSection(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    var status = orderProvider.getOrderStatus(item);
    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (status != OrderDetailsStatus.delivered)
                      IconButton(onPressed: () => launch("tel://${item.phonenumber}"), icon: Icon(Icons.call, color: kAccentColor)),
                    Text(item.user ?? '', style: context.textTheme.bodyLarge),
                  ],
                ),
                Text(item.address ?? '', style: context.textTheme.bodyLarge?.copyWith(fontFamily: '')),
              ],
            ),
          ),
          diliverToClient(context),
        ],
      ),
    );
  }

  Widget diliverToClient(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    var status = orderProvider.getOrderStatus(item);
    if (status == OrderDetailsStatus.delivered) {
      return Text('تم التسليم', style: context.textTheme.headlineMedium);
    }

    return Column(
      children: [
        ButtonWidget(
            text: 'تسليم',
            onPressed: status == OrderDetailsStatus.shipping
                ? () async {
                    try {
                      await Provider.of<OrderProvider>(context, listen: false).deliverOrder(item.id!);
                    } catch (err) {
                      showDialog(context: context, builder: (context) => CustomDialog(message: err.toString()));
                    }
                  }
                : null),
        // ButtonWidget(
        //     text: 'الغاء الطلب',
        //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        //     textStyle: GoogleFonts.tajawal(fontWeight: FontWeight.bold, fontSize: 13),
        //     onPressed: status == OrderDetailsStatus.shipping
        //         ? () async {
        //             try {
        //               showDialog(
        //                 context: context,
        //                 builder: (context) => CustomConfirmationDialog(
        //                   message: 'هل انت متأكد من الغاء الطلب ؟',
        //                   yesBTNCallBack: () async {
        //                     await Provider.of<OrderProvider>(context, listen: false).cancelOrder(item.id!);
        //                   },
        //                 ),
        //               );
        //             } catch (err) {
        //               showDialog(context: context, builder: (context) => CustomDialog(message: err.toString()));
        //             }
        //           }
        //         : null),
      ],
    );
  }
}

class MerchentOrderDetails extends StatelessWidget {
  final MerchentOrderDetailsModel item;
  final int OrderId;
  const MerchentOrderDetails(this.item, this.OrderId);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0.5,
      child: Column(
        children: [
          context.addHeight(8),
          _header(context),
          _orderItems(),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: [
        Text(item.merchantTitle ?? '', style: context.textTheme.bodyLarge),
        IconButton(onPressed: null, icon: Icon(Icons.info, size: 15)),
        Spacer(),
        _orderStatus(context),
      ],
    );
  }

  Widget _orderStatus(BuildContext context) {
    if (item.orderDetailStatus == OrderDetailsStatus.merchantAccepted) {
      return ButtonWidget(
        text: 'استلام',
        onPressed: () async {
          try {
            await Provider.of<OrderProvider>(context, listen: false).startShipping(OrderId, item.merchantId!);
          } catch (err) {
            showDialog(context: context, builder: (context) => CustomDialog(message: err.toString()));
          }
        },
        margin: EdgeInsets.zero,
      );
    }
    return Text('تم الاستلام', style: context.textTheme.bodyLarge?.copyWith(color: kAccentColor));
  }

  Widget _orderItems() {
    return Column(
      children: item.orderDetails!.map((e) => OrderDetailsSingleItem(e)).toList(),
    );
  }
}

class OrderDetailsSingleItem extends StatelessWidget {
  final OrderDetailsModel item;
  const OrderDetailsSingleItem(this.item);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _image(),
        context.addWidth(8),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${item.productTitle ?? ''}', style: context.textTheme.headlineSmall),
              // PriceTextWidget.small(price: item.singleFinalPrice, currencyIntegerStyle: context.textTheme.caption!),

              Text(item.productUnit ?? '', style: context.textTheme.bodyMedium),
            ],
          ),
        ),
        Text('${item.quantity} x', style: context.textTheme.displaySmall),
        context.addWidth(16),
      ],
    );
  }

  Widget _image() {
    double cardHeight = 75;
    double imageWidth = cardHeight * 1;
    if (GlobalVar.checkString(item.productImage)) {
      return ImageView(item.productImage?.split(',').first, height: cardHeight, width: imageWidth);
    }
    return Image.asset(kNoImage, height: cardHeight, width: imageWidth);
  }
}
