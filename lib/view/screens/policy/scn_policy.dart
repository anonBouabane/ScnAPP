import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';
import 'package:simple_html_css/simple_html_css.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String htmlContent = """
   <body>
   <p align="center"><strong>ຂໍ້ກຳນົດ ແລະ ເງື່ອນໄຂ </strong><strong>SCN EASY</strong></p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SCN EASY ແມ່ນຜະລິດຕະພັນຂອງ ກຸ່ມບໍລິສັດ ສົມໃຈນຶກ ຊຶ່ງເປັນແອບພລີເຄຊັນທີ່ອໍານວຍຄວາມສະດວກຫຼາຍດ້ານໃຫ້ແກ່ບັນດາທ່ານລູກຄ້າ ເພື່ອນຳໃຊ້ບໍລິການສ່ຽງໂຊກຊິງລາງວັນ (ຊື້ຫວຍ). ນໍາໃຊ້ບໍລິການການກູ້ຢືມເງີນ ແລະ ເຮັດທຸລະກຳທາງການເງີນຜ່ານລະບົບສະຖາບັນການເງີນອອນລາຍ ແລະ ການໃຫ້ບໍລິການອື່ນໆ ທີ່ຫຼາກຫຼາຍພ້ອມທັງຮັບຂໍ້ມູນຂ່າວສານກ່ຽວກັບ ກຸ່ມບໍລິສັດ ສົມໃຈນຶກ.</p>
<ol>
<li><strong>1.&nbsp;&nbsp;&nbsp; </strong><strong>ຂໍ້ມູນສວນຕົວຂອງຜູ້ນຳໃຊ້</strong></li>
</ol>
<p>SCN EASY ຈຳເປັນຈະຕ້ອງເກັບຂໍ້ມູນພື້ນຖານທີ່ກົງກັບ ຂໍ້ມູນສ່ວນຕົວ, ເບີໂທ ແລະອື່ນໆ ຂອງບັນດາທ່ານທີ່ໃຊ້ບໍລິການໂດຍເກັບໄວ້ໃນລະບົບແຕ່ລະຄັ້ງ ເພື່ອອໍານວຍໃຫ້ແກ່ການເຮັດທຸລະກໍາທຸກຮູບແບບ, ການແກ້ໄຂບັນຫາຕ່າງໆທີ່ອາດຈະເກີດຂື້ນ ພ້ອມທັງນຳໄປໃຊ້ໃນການປັບປຸງການໃຫ້ບໍລິການຂອງ SCN EASY ໃຫ້ ແທດ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ເໝາະກັບສະພາບຄວາມເປັນຈິງຕາມຄວາມຮຽກຮ້ອງຕ້ອງການທາງດ້ານການນຳໃຊ້ແຕ່ລະໄລຍະ ຊຶ່ງທຸກໆການບັນທຶກຂໍ້ມູນຈະຖືກເກັບຮັກສາໄວ້ເປັນຄວາມລັບ ແລະ ຈະບໍ່ຖືກເປີດເຜີຍໃຫ້ກັບທຸກພາກສ່ວນທີ່ບໍ່ກ່ຽວຂ້ອງຢ່າງເດັດຂາດ.</p>
<ol>
<li><strong>2.&nbsp;&nbsp;&nbsp; </strong><strong>ເງື່ອນໄຂການໃຫ້ບໍລິການ</strong></li>
</ol>
<p>ຜູ້ໃຊ້ບໍລິການສາມາດແນະນຳໃຫ້ຫມູ່ນຳໃຊ້ SCN EASY ເພື່ອຮັບສ່ວນຫລຸດ ຫຼື ເງີນລາງວັນ 0,5-5% ໂດຍອີງຕາມກາເຮັດທຸລະກຳ ແລະ ຈະຖືກໂອນເຂົ້າເລກບັນຊີຂອງຜູ້ໃຊ້ບໍລິການບໍ່ເກີນວັນທີ 05 ຂອງເດືອນທັດໄປ ຊື່ງການແນະນຳໃຫ້ຫມູ່ເພື່ອນໃຊ້ບໍລິການ ລະບົບຈະບັນທຶກລະຫັດໄວ້ຈົນກວ່າຈະຄົບ 01 ປີ ຈຶ່ງສາມາດປ່ຽນແປງລະຫັດແນະນຳໃໝ່ອີກຄັ້ງເພື່ອຮັບສ່ວນຫຼຸດ ຫຼື ເງິນລາງວັນ.</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp; ຜູ້ໃຊ້ບໍລິການ SCN EASY ຕ້ອງປະຕິບັດຕາມຂໍ້ກຳນົດ ແລະ ເງື່ອນໄຂຂອງແຕ່ລະການໃຫ້ບໍລິການ ຊື່ງລາຍລະອຽດດັ່ງນີ້:</p>
<p>ກ) ບໍລິການຊື້ຫວຍ</p>
<p>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ບໍລິການຊື້ຫວຍ ເພື່ອສ່ຽງໂຊກ ແລະ ຊິງລາງວັນກັບລັດວິສາຫະກິດ ຫວຍພັດທະນາລາວ ຜູ້ໃຊ້ບໍລິການຕ້ອງປະຕິບັດຕາມກົດໝາຍ, ຂໍ້ກຳນົດ, ເງື່ອນໄຂຂອງ SCN EASY ແລະ ລະບຽບການຂອງຫວຍພັດທະນາລາວຢ່າງເຂັ້ມງວດ;</p>
<p>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ມີເລກສຸ່ມ ແລະ ເລກ 1 ຫາ 6 ໂຕ ໃຫ້ບໍລິການຜ່ານ SCN EASY;</p>
<p>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ຜູ້ໃຊ້ບໍລິການຕ້ອງມີແອັບບັນຊີທະນາຄານເພື່ອຊຳລະຄ່າບໍລິການຊື້ຫວຍ ແລະ ຮັບເງີນລາງວັນ;</p>
<p>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ຜູ້ໂຊກດີແຕ່ລະງວດຈະໄດ້ຮັບເງິນລາງວັນຜ່ານແອັບບັນຊີທະນາຄານທີ່ເຮັດການຊຳລະເງິນ ທັນທີ ຫຼື ບໍ່ເກີນ 1 ຊົ່ວໂມງຫຼັງຈາກຜົນການການແຈ້ງລາວວັນອອກຢ່າງເປັນທາງການ;</p>
<p>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ສໍາລັບການແນະນໍາໃນແອັບບໍລິການຊື້ຫວຍ ແມ່ນທາງ ບໍລິສັດ ໄດ້ມີການກຳນົດເງື່ອນໄຂ, ນະໂຍບາຍ ແລະ ຂໍ້ກຳນົດສະເພາະຕ່າງຫາກ ໃນການນຳໃຊ້ບໍລິການ;</p>
<p>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ບໍລິການອື່ນໆ</p>
<p>ຂ) ບໍລິການສະຖາບັນການເງິນ</p>
<p>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ຜູ້ໃຊ້ບໍລິການສາມາດປະກອບຂໍ້ມູນຜ່ານ SCN EASY ເພື່ອລົງທະບຽນຂໍກູ້ຢືມເງີນອອນລາຍເບື້ອງຕົ້ນ ສ່ວນລາຍລະອຽດອື່ນໆ ລູກຄ້າຕ້ອງເຂົ້າມາພົວພັນຕື່ມຕາມຂັ້ນຕອນ ແລະ ລະບຽບຫຼັກການຂອງສະຖາບັນການເງິນ;</p>
<p>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ລູກຄ້າທີ່ລົງທະບຽນຂໍກູ້ຢືມເງິນຜ່ານແອັບ ຈະໄດ້ຮັບສ່ວນຫຼຸດພິເສດ ຊຶ່ງໄດ້ກຳນົໄວ້ໃນເງື່ອນໄຂ ແລະ ນະໂຍບາຍການນຳໃຊ້ສະເພາະ;</p>
<p>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SCN EASY ອຳນວຍຄວາມສະດວກຫຼາຍດ້ານ ໂດຍສະເພາະແມ່ນໃຫ້ວົງເງີນສູງ, ອະນຸມັດໄວ, ດອກເບຍຕ່ຳ, ໄລຍະເວລາການກູ້ຢືມຍາວ;</p>
<p>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ສາມາດເລື່ອນການຮັບ ແລະ ການຊຳລະໃນຮູບແບບເງີນສົດ ຫຼື ຜ່ານລະບົບທະນາຄານ.</p>
<p>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ບໍລິສັດ ໄດ້ມີການກຳນົດເງື່ອນໄຂ, ນະໂຍບາຍ ແລະ ຂໍ້ກຳນົດສະເພາະຕ່າງຫາກ ໃນການນຳໃຊ້ບໍລິການສະຖາບັນການເງິນອອນລາຍ (Online Financial Institution Services);</p>
<p>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ບໍລິການອື່ນໆ.</p>
<ol>
<li><strong>3.&nbsp;&nbsp;&nbsp; </strong><strong>ຄວາມຮັບຜິດຊອບ</strong></li>
</ol>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ກ) ຄວາມຮັບຜິດຊອບຂອງຜູ້ໃຊ້ບໍລິການ</p>
<p>ຜູ້ໃຊ້ບໍລິການຕ້ອງຮັບຜິດຊອບຕໍ່ຄວາມເສຍຫາຍທີ່ເກີດຈາກຄວາມຜິດພາດຂອງຕົນ ຫຼື ຢູ່ໃນການຄຸ້ມຄອງຂອງຕົນເອງໂດຍອີງຕາມຂໍ້ກຳນົດ, ນະໂຍບາຍ, ເງື່ຶອນໄຂຂອງແຕ່ລະບໍລິການ, ລະບຽບການ ແລະ ກົດໝາຍຕ່າງໆ ຂອງ ສປປລາວ ທີ່ມີຜົນບັງຄັບໃຊ້ໃນແຕ່ລະໄລຍະ.</p>
<p>ຂ) ຄວາມຮັບຜິດຊອບຂອງ SCN EASY</p>
<p>SCN EASY ຈະຮັບຜິດຊອບໃຊ້ແທ່ນຄ່າເສຍຫາຍທີ່ເກີດຈາກຂອດການບໍລິການໂດຍອີງຕາມຂໍ້ກຳນົດ, ເງື່ອນໄຂຂອງແຕ່ລະບໍລິການ, ກົດໝາຍ ແລະ ລະບຽບການຕ່າງໆຂອງ ສປປລາວ.</p>
<ol>
<li><strong>4.&nbsp;&nbsp;&nbsp; </strong><strong>ຂໍ້ຫ້າມ</strong></li>
</ol>
<p>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ຫ້າມຜູ້ໃຊ້ບໍລິການ SCN EASY ມີພຶດຕິກຳສໍ້ໂກງຊັບ ແລະ ຍັກຍອກຊັບ;</p>
<p>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ຫ້າມໃຊ້ SCN EASY ເປັນສາກບັງຫນ້າໃນການເຄື່ອນຍ້າຍສິງຜິດກົດຫມາຍ ແລະ ພົວພັນກັບຫວຍເຖື່ອນ;</p>
<p>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ຂໍ້ຫ້າມອື່ນໆເພີ່ມເຕີມແມ່ນ ໄດ້ກຳນົດໄວ້ລະອຽດໃນແຕ່ລະການໃຫ້ບໍລິການ.</p>
<ol>
<li><strong>5.&nbsp;&nbsp;&nbsp; </strong><strong>ກົດໝາຍ </strong><strong>SCN EASY</strong></li>
</ol>
<p>SCN EASY ຂໍສະຫງວນສິດໃນການປ່ຽນແປງບັນດາຂໍ້ກຳນົດ, ນະໂຍບາຍ ແລະ ເງື່ອນໄຂຕ່າງໆໂດຍບໍ່ແຈ້ງໃຫ້ຜູ້ໃຊ້ບໍລິການຊາບລ່ວງຫນ້າ ເຊິ່ງເນື້ອໃນເອກະສານນີ້ແມ່ນໃຫ້ຖືເອົາ ລະບຽບ, ນິຕິກຳ ແລະ ບັນດາກົດໝາຍຕ່າງໆທີ່ກ່ຽວຂ້ອງຂອງ ສປປ ລາວ ທີ່ໄດ້ປະກາດໃຊ້ໃນແຕ່ລະໄລຍະເປັນບ່ອນອີງໃນການຈັດຕັ້ງປະຕີບັດ.</p>
<p>&nbsp;</p>
	</body>
    """;
    return Scaffold(
      appBar: AppBar(elevation: 2, title: Text("terms_conditions".tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)), backgroundColor: Colors.redAccent.shade700),
      body: Builder(builder: (context) {
        return ListView(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: HTML.toTextSpan(context, htmlContent,defaultTextStyle: robotoRegular),
            ),
          )
        ]);
      }),
    );
  }
}
