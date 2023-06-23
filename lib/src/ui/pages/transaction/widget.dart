import 'package:app_jtak_delivery/src/config/constants/constants.dart';
import 'package:app_jtak_delivery/src/core/enums/payment_method_enum.dart';
import 'package:app_jtak_delivery/src/core/models/bill_model.dart';
import 'package:app_jtak_delivery/src/core/models/payment_model.dart';
import 'package:app_jtak_delivery/src/ui/widgets/price_widgets.dart';
import 'package:app_jtak_delivery/src/utils/utilities/global_var.dart';
import 'package:flutter/material.dart';
import '../../../../main_imports.dart';

class PaymentSingleItem extends StatelessWidget {
  final PaymentModel item;
  const PaymentSingleItem(this.item);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                PriceTextWidget.small(price: item.amount ?? 0.0),
                const Spacer(),
                Text('#${item.id}', style: context.textTheme.bodySmall),
              ],
            ),
            Row(
              children: [
                Text(GlobalVar.dateForamt(item.handoverDate, kDateTimeFormat) ?? '', style: context.textTheme.bodyLarge),
                const Spacer(),
                _status(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _status(BuildContext context) {
    String status = 'جاري تسليم ${item.toUser} ';
    if (item.handoverDate != null) {
      status = 'تم تسليم ${item.toUser} ';
    }
    return Text(status, style: context.textTheme.titleLarge);
  }
}

class BillSingleItem extends StatelessWidget {
  final BillModel item;
  const BillSingleItem(this.item);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                PriceTextWidget.small(price: item.totalAmount ?? 0.0),
                const Spacer(),
                Text('#${item.id}', style: context.textTheme.bodySmall),
              ],
            ),
            Row(
              children: [
                Text(GlobalVar.dateForamt(item.dueDate, kDateTimeFormat) ?? '', style: context.textTheme.bodySmall),
                const Spacer(),
                _paymentMethod(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentMethod(BuildContext context) {
    if (item.paymentMethod == PaymentMethod.creditCardPayment) {
      return Row(
        children: [
          Icon(Icons.credit_card, size: 15),
          Text(item.paymentMethod?.value ?? ''),
        ],
      );
    } else if (item.paymentMethod == PaymentMethod.payOnDelivery) {
      return Row(
        children: [
          Icon(Icons.money, size: 15),
          Text(item.paymentMethod?.value ?? ''),
        ],
      );
    }
    return const SizedBox();
  }
}
