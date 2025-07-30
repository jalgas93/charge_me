class CalculateResult {
  num? result(
      {required num? cost, required num? bookingCost, required num? tariff}) {
    if (bookingCost != null && bookingCost > 0 && tariff!=null && cost!=null) {
      return (tariff * cost) + bookingCost;
    } else if(cost!=null && tariff!=null){
      return tariff * cost;
    }
    return null;
  }
}
