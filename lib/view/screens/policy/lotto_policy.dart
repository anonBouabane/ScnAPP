import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:scn_easy/util/styles.dart';

import '../../../util/dimensions.dart';

class LottoPolicy extends StatelessWidget {
  const LottoPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    String html = """<body>
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
          title: Text("ຂໍ້ກຳນົດ ແລະ ເງື່ອນໄຂ",
              style:
                  robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
          backgroundColor: Colors.redAccent.shade700,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text("ເງື່ອນໄຂຂອງເງິນແນະນຳຫມູ່",
                    style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeOverLarge)),
              )),
              Html(
                data: html,
                style: {
                  "p": Style(fontFamily: "Roboto"),
                },
              ),
            ],
          ),
        ));
  }
}
