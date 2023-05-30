import 'package:flutter_test/flutter_test.dart';
import 'package:jaijaoni/components/create/selected_friend.dart';
import 'package:jaijaoni/providers/create/create_debt_data_provider.dart';

void main() {
  CreateDebtData data = CreateDebtData();
  test("Change name", () {
    data.changeDeptInfo(
        name: "Frice", dueDate: DateTime(2023), totalPrice: 500);
    expect(data.name, "Frice");
  });

  test("Add Friends", () {
    data.changePeople(friendList: [
      SelectedFirend(
          id: '1', imagePath: '', name: 'mm', price: 250.0, username: 'tesst'),
      SelectedFirend(
          id: '2', imagePath: '', name: 'mm', price: 250.0, username: 'abcd')
    ]);
    expect(data.friendList.map((e) => e.price).toList(), [250.0, 250.0]);
  });

  test("Add Payment", () {
    data.addPayment(paymentList: [
      PaymentOption(channel: "Promptpay", number: "1234", isCheck: false),
      PaymentOption(channel: "KBank", number: "12345", isCheck: false),
      PaymentOption(channel: "Promptpay", number: "54215", isCheck: false),
      PaymentOption(channel: "NEXT", number: "123789", isCheck: false),
    ]);
    data.switchSelectPayment(
        PaymentOption(channel: "Promptpay", number: "1234", isCheck: true));
    expect(
        data.paymentList
            .where((element) =>
                element.channel == "Promptpay" && element.number == "1234")
            .first
            .isCheck,
        true);
    data.switchSelectPayment(
        PaymentOption(channel: "Promptpay", number: "54215", isCheck: false));
    expect(
        data.paymentList
            .where((element) =>
                element.channel == "Promptpay" && element.number == "1234")
            .first
            .isCheck,
        false);
  });
}
