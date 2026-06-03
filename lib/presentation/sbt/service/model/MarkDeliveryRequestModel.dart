class MarkDeliveryRequestModel {
  final String? order_deal_id;
  List<int>? inventory_id;

  MarkDeliveryRequestModel(this.inventory_id, this.order_deal_id);
}
