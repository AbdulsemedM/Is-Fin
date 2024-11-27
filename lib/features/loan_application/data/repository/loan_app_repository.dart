import 'dart:convert';

import 'package:ifb_loan/features/loan_application/data/data_provider/loan_app_provider.dart';
import 'package:ifb_loan/features/loan_application/models/products_request_model.dart';

class LoanAppRepository {
  final LoanAppProvider loanAppProvider;

  LoanAppRepository(this.loanAppProvider);
  Future<List<Map<String, String>>> fetchSectors() async {
    try {
      // print("here we gooooo");
      final sectorsData = await loanAppProvider.fetchSectors();
      final data = jsonDecode(sectorsData);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      if (data['response'] is List) {
        List<Map<String, String>> sectors = [];

        for (var item in data['response']) {
          sectors.add({
            "sectorName": item['sectorName'].toString(),
          });
        }

        return sectors;
      } else {
        throw "Invalid response format: Expected a list";
      }
    } catch (e) {
      // print(e.toString());
      rethrow; // This will throw only the `message` part if thrown from above
    }
  }

  Future<List<Map<String, String>>> fetchRepayment() async {
    try {
      // print("here we gooooo");
      final sectorsData = await loanAppProvider.fetchRepayment();
      final data = jsonDecode(sectorsData);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      if (data['response'] is List) {
        List<Map<String, String>> repayments = [];

        for (var item in data['response']) {
          repayments.add({
            "duration": item['duration'].toString(),
          });
        }

        return repayments;
      } else {
        throw "Invalid response format: Expected a list";
      }
    } catch (e) {
      // print(e.toString());
      rethrow; // This will throw only the `message` part if thrown from above
    }
  }

  Future<List<Map<String, String>>> fetchtUnitofMeasurement() async {
    try {
      // print("here we gooooo");
      final unitofMeasurementData =
          await loanAppProvider.fetchtUnitofMeasurement();
      final data = jsonDecode(unitofMeasurementData);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      if (data['response'] is List) {
        List<Map<String, String>> unitofMeasurements = [];

        for (var item in data['response']) {
          unitofMeasurements.add({
            "unitOfMeasurement": item['unitOfMeasurement'].toString(),
          });
        }

        return unitofMeasurements;
      } else {
        throw "Invalid response format: Expected a list";
      }
    } catch (e) {
      // print(e.toString());
      rethrow; // This will throw only the `message` part if thrown from above
    }
  }

  Future<String> sendProductRequest(ProductsRequestModel product) async {
    try {
      // print("here we gooooo");
      final productRequest = await loanAppProvider.sendProductRequest(product);
      final data = jsonDecode(productRequest);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }

      return data['message'];
    } catch (e) {
      // print(e.toString());
      rethrow; // This will throw only the `message` part if thrown from above
    }
  }
}
