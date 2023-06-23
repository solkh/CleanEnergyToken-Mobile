import 'package:app_jtak_delivery/src/core/controllers/app/base_provider.dart';
import 'package:app_jtak_delivery/src/core/enums/order_details_status_enum.dart';
import 'package:app_jtak_delivery/src/core/models/order_model.dart';
import 'package:app_jtak_delivery/src/core/services/location_service.dart';
import 'package:app_jtak_delivery/src/core/services/locator.dart';
import 'package:app_jtak_delivery/src/utils/providers/sol_api.dart';
import 'package:app_jtak_delivery/src/utils/utilities/global_var.dart';

class OrderProvider extends BaseProvider<OrderModel> {
  final SolApi _api = locator<SolApi>();
  OrderModel? order;

  Future refreshData() async {
    page = 0;
    await loadPagedData();
  }

  Future loadPagedData() async {
    await loadInfinityData(
      loadData: (page) async {
        Map body = {'pageNumber': page, "pageSize": 20, "sortField": "id", "sortOrder": "desc"};
        var res = await _api.postRequest('/Orders/Mine', body);
        List data = res['items'];
        return data.map((e) => OrderModel.fromMap(e)).toList();
      },
    );
  }

  Future loadOrder(int id) async {
    return await loadBaseData(
      loadBody: () async {
        var data = await _api.getRequest('/Orders/${order!.id}');
        order = OrderModel.fromMap(data);
      },
    );
  }

  void setOrderObject(OrderModel orderObject) async {
    order = orderObject;
    if (orderIsEmpty()) {
      await loadOrder(order!.id ?? -1);
    }
  }

  Future startShipping(int orderId, int merchentId) async {
    await loadBaseData(loadBody: () async {
      await _api.postRequest('/Orders/StartShipping/$orderId/$merchentId', {});
      await refreshData();
    });
  }

  Future deliverOrder(int orderId) async {
    await loadBaseData(loadBody: () async {
      var location = await LocationService().getCurrentLocation();
      GlobalVar.log(location.toString());
      await _api.postRequest('/Orders/DeliverOrder/$orderId', {});
      await refreshData();
    });
  }

  Future cancelOrder(int orderId) async {
    await loadBaseData(loadBody: () async {
      var location = await LocationService().getCurrentLocation();
      GlobalVar.log(location.toString());
      await _api.postRequest('/Orders/cancel/$orderId', {});
      await refreshData();
    });
  }

  bool orderIsEmpty() {
    return order == null || !GlobalVar.checkListNotEmpty(order!.orderDetails) || order!.id == null;
  }

  OrderDetailsStatus getOrderStatus(OrderModel order) {
    OrderDetailsStatus status = OrderDetailsStatus.pending;
    if (GlobalVar.checkListNotEmpty(order.orderDetails)) {
      status = order.orderDetails!.first.orderDetailStatus ?? OrderDetailsStatus.pending;
      for (var element in order.orderDetails!) {
        if (element.orderDetailStatus!.index < status.index) {
          status = element.orderDetailStatus ?? OrderDetailsStatus.pending;
        }
      }
    }
    return status;
  }
}
