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
        await client.post('payment_app.cgi/create');
    return response.data;
  }

  Future<dynamic> check({
    required String command,
    required String txnId,
    required int account,
    required num sum,
  }) async {
    var data = {
      "command": command,
      "txn_id": txnId,
      "account": account,
      "sum": sum,
    };
    final response =
        await client.get('payment_app.cgi', queryParameters: data);
    return response.data;
  }
  Future<dynamic> pay({
    required String command,
    required String txnId,
    required int account,
    required num sum,
    required int txnDate,
  }) async {
    var data = {
      "command": command,
      "txn_id": txnId,
      "txn_date": txnDate,
      "account": account,
      "sum": sum,
    };
    final response =
    await client.get('payment_app.cgi', queryParameters: data);
    return response.data;
  }
}
