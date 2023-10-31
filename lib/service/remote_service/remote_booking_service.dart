import 'package:get/get.dart';
import 'package:p3l_gah_android/model/booking.dart';

class BookingService extends GetConnect {
  Future<List<BookingHistory>> fetchBookingHistory(
      String page, String id, String size, String token) async {
    final response = await get(
      'http://10.0.2.2:3000/api/customer/$id/booking-history?page=$page&size=$size',
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    print(response.statusCode.toString() + " Status Code");
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> responseData = response.body['data'];
      print(responseData);
      return responseData
          .map<BookingHistory>((json) => BookingHistory.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load booking history');
    }
  }

  Future<BookingResponse> getDetailBooking(String id, String token) async {
    final response = await get(
      'http://10.0.2.2:3000/api/api/customer/booking/$id',
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    return BookingResponse.fromJson(response.body);
  }
}
