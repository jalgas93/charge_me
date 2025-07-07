import 'dart:async';

import '../../core/base_repository.dart';

class PaymentRepository extends BaseRepository {
  Future<dynamic> getBalance() async {
/*    var data = {
      "account_id": accountId,
      "balance": num,
      "last_updated": lastUpdated
    };*/
    final response =
        await client.post('api/v1/payment_app.cgi/create');
    return response.data;
  }

  Future<dynamic> topUpBalance({
    required String command,
    required String txnId,
    required int account,
    required num sum,
    required int txnDate,
  }) async {
    var data = {
      "command": command,
      "txn_id": txnId,
      "account": account,
      "sum": sum,
      "txn_date": txnDate,
    };
    final response =
        await client.get('api/v1/payment_app.cgi', queryParameters: data);
    return response.data;
  }
}
