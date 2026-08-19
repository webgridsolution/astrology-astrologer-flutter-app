import 'package:flutter_test/flutter_test.dart';
import 'package:astroguide_astrologer/utils/constants.dart';

void main() {
  test('mock OTP is 123456', () {
    expect(AppConstants.mockOtp, '123456');
  });
}
