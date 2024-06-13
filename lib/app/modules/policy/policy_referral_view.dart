import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:scn_easy/app/languages/translates.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';

class PolicyReferralView extends StatelessWidget {
  const PolicyReferralView({super.key});

  @override
  Widget build(BuildContext context) {
    String html = """
    <body>
      <p>ໃນໜ້າຈໍຊຳລະເງິນ: ຈະມີຫ້ອງໃຫ້ທ່ານປ້ອນ (ຕີ) ເລກຂອງຜູ້ແນະນຳໃສ່ , ແນະນຳຫມູ່ເພື່ອນຂອງທ່ານປ້ອນ (ຕີ) ເລກແນະນຳຂອງທ່ານໃສ່ຊ່ອງດັ່ງກ່າວ.</p>
      <ul style="list-style-type: disc;">
        <li>ທ່ານຈະໄດ້ຮັບເງິນຈຳນວນ 6% ຈາກຫມູ່ເພື່ອນໃນເວລາທີ່ຊື້ຫວຍໃນແອບ.</li>
        <li>ພາຍໃນ 6 ເດືອນທຳອິດ ຫມູ່ເພື່ອນຂອງທ່ານຈະບໍ່ສາມາດປ່ຽນເລກແນະນຳຂອງທ່ານໄດ້, ຫລັງຈາກສີ້ນສຸດກຳນົດຫມູ່ເພື່ອນຂອງທ່ານຈຶ່ງຈະສາມາດປ່ຽນເລກຜູ້ແນະນຳຂອງຄົນອື່ນແທນ.</li>
        <li>ທ່ານຈະໄດ້ຮັບເງິນແນະນຳ ທຸກໆຕົ້ນເດືອນ ຂອງເດືອນຕໍ່ໄປ.</li>
        <li>ເງິນແນະນຳຂອງທ່ານ ຈະຖຶກໂອນເຂົ້າທະນາຄານການຄ້າ (BCEL) ທີ່ທາງທ່ານໃຊ້ໃນຄັ້ງທຳອິດ.</li>
        <li>ທາງບໍລິສັດຂໍສະຫງວນສິດໃນການປ່ຽນແປງເງື່ອນໄຂ ໂດຍທາງບໍລິສັດຈະບໍ່ໄດ້ແຈ້ງໃຫ້ທາງທ່ານຮັບຊາບລ່ວງຫນ້າ.</li>
      </ul>
    </body>
    """;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Translates.APP_TITLE_TERM_AND_CONDITION_REFERRAL.tr,
          style: robotoBold.copyWith(
            fontSize: Dimensions.fontSizeExtraLarge,
          ),
        ),
        backgroundColor: Colors.redAccent.shade700,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Html(
              data: html,
              style: {"p": Style(fontFamily: "Roboto")},
            ),
          ],
        ),
      ),
    );
  }
}
