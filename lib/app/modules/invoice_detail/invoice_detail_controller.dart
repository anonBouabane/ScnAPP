import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

import '../../models/invoice_model.dart';
import '../buy_lottery/animal_model.dart';

class InvoiceDetailController extends GetxController {
  final GlobalKey captureGlobalKey = GlobalKey();
  ScreenshotController screenshotController = ScreenshotController();
  Rx<InvoiceItem> invoiceItem = InvoiceItem().obs;

  @override
  void onInit() {
    super.onInit();
    invoiceItem.value = Get.arguments;
  }

  List<AnimalModel> animalList = [
    AnimalModel(
      name: 'small_fish',
      lotteryNo: '01,41,81',
      img: 'assets/lotto/img/goldfish.png',
    ),
    AnimalModel(
      name: 'snail',
      lotteryNo: '02,42,82',
      img: 'assets/lotto/img/snail.png',
    ),
    AnimalModel(
      name: 'goose',
      lotteryNo: '03,43,83',
      img: 'assets/lotto/img/goose.png',
    ),
    AnimalModel(
      name: 'peacock',
      lotteryNo: '04,44,84',
      img: 'assets/lotto/img/poem.png',
    ),
    AnimalModel(
      name: 'lion',
      lotteryNo: '05,45,85',
      img: 'assets/lotto/img/lion.png',
    ),
    AnimalModel(
      name: 'tiger',
      lotteryNo: '06,46,86',
      img: 'assets/lotto/img/tiger.png',
    ),
    AnimalModel(
      name: 'pig',
      lotteryNo: '07,47,87',
      img: 'assets/lotto/img/pig.png',
    ),
    AnimalModel(
      name: 'rabbit',
      lotteryNo: '08,48,88',
      img: 'assets/lotto/img/rabit.png',
    ),
    AnimalModel(
      name: 'buffalo',
      lotteryNo: '09,49,89',
      img: 'assets/lotto/img/buffalo.png',
    ),
    AnimalModel(
      name: 'otter',
      lotteryNo: '10,50,90',
      img: 'assets/lotto/img/seal.png',
    ),
    AnimalModel(
      name: 'dog',
      lotteryNo: '11,51,91',
      img: 'assets/lotto/img/dog.png',
    ),
    AnimalModel(
      name: 'horse',
      lotteryNo: '12,52,92',
      img: 'assets/lotto/img/horse.png',
    ),
    AnimalModel(
      name: 'elephant',
      lotteryNo: '13,53,93',
      img: 'assets/lotto/img/elephant.png',
    ),
    AnimalModel(
      name: 'cat',
      lotteryNo: '14,54,94',
      img: 'assets/lotto/img/cat.png',
    ),
    AnimalModel(
      name: 'rat',
      lotteryNo: '15,55,95',
      img: 'assets/lotto/img/rat.png',
    ),
    AnimalModel(
      name: 'bee',
      lotteryNo: '16,56,96',
      img: 'assets/lotto/img/bee.png',
    ),
    AnimalModel(
      name: 'egret',
      lotteryNo: '17,57,97',
      img: 'assets/lotto/img/bird3.png',
    ),
    AnimalModel(
      name: 'bobcat',
      lotteryNo: '18,58,98',
      img: 'assets/lotto/img/eurasian.png',
    ),
    AnimalModel(
      name: 'butterfly',
      lotteryNo: '19,59,99',
      img: 'assets/lotto/img/buterfly.png',
    ),
    AnimalModel(
      name: 'centipede',
      lotteryNo: '20,60,00',
      img: 'assets/lotto/img/chinese_red_headed.png',
    ),
    AnimalModel(
      name: 'swallow',
      lotteryNo: '21,61',
      img: 'assets/lotto/img/swallow.png',
    ),
    AnimalModel(
      name: 'pigeon',
      lotteryNo: '22,62',
      img: 'assets/lotto/img/bird1.png',
    ),
    AnimalModel(
      name: 'monkey',
      lotteryNo: '23,63',
      img: 'assets/lotto/img/monkey.png',
    ),
    AnimalModel(
      name: 'frog',
      lotteryNo: '24,64',
      img: 'assets/lotto/img/fog.png',
    ),
    AnimalModel(
      name: 'falcon',
      lotteryNo: '25,65',
      img: 'assets/lotto/img/bird2.png',
    ),
    AnimalModel(
      name: 'flying_otter',
      lotteryNo: '26,66',
      img: 'assets/lotto/img/dragon.png',
    ),
    AnimalModel(
      name: 'turtle',
      lotteryNo: '27,67',
      img: 'assets/lotto/img/turtle.png',
    ),
    AnimalModel(
      name: 'rooster',
      lotteryNo: '28,68',
      img: 'assets/lotto/img/chicken.png',
    ),
    AnimalModel(
      name: 'eel',
      lotteryNo: '29,69',
      img: 'assets/lotto/img/eel.png',
    ),
    AnimalModel(
      name: 'big_fish',
      lotteryNo: '30,70',
      img: 'assets/lotto/img/fish.png',
    ),
    AnimalModel(
      name: 'praw',
      lotteryNo: '31,71',
      img: 'assets/lotto/img/shrimps.png',
    ),
    AnimalModel(
      name: 'snake',
      lotteryNo: '32,72',
      img: 'assets/lotto/img/snack.png',
    ),
    AnimalModel(
      name: 'spider',
      lotteryNo: '33,73',
      img: 'assets/lotto/img/spider.png',
    ),
    AnimalModel(
      name: 'deer',
      lotteryNo: '34,74',
      img: 'assets/lotto/img/deer.png',
    ),
    AnimalModel(
      name: 'goat',
      lotteryNo: '35,75',
      img: 'assets/lotto/img/goat.png',
    ),
    AnimalModel(
      name: 'palm_civet',
      lotteryNo: '36,76',
      img: 'assets/lotto/img/pngtree_civet.png',
    ),
    AnimalModel(
      name: 'pangolin',
      lotteryNo: '37,77',
      img: 'assets/lotto/img/ecad.png',
    ),
    AnimalModel(
      name: 'hedgehog',
      lotteryNo: '38,78',
      img: 'assets/lotto/img/exhibition.png',
    ),
    AnimalModel(
      name: 'crab',
      lotteryNo: '39,79',
      img: 'assets/lotto/img/blue-crab.png',
    ),
    AnimalModel(
      name: 'eagle',
      lotteryNo: '40,80',
      img: 'assets/lotto/img/orel.png',
    ),
  ];

  List<String> getChoiceList() {
    List<String> choiceList = [];
    for (int i = 0; i < animalList.length; i++) {
      choiceList.add(animalList[i].lotteryNo!);
    }
    return choiceList;
  }

  List<String> getChoiceListImg() {
    List<String> choiceList = [];
    for (int i = 0; i < animalList.length; i++) {
      choiceList.add(animalList[i].img!);
    }
    return choiceList;
  }

  List<String> getNameList() {
    List<String> choiceNameList = [];
    for (int i = 0; i < animalList.length; i++) {
      choiceNameList.add(animalList[i].name.toString());
    }
    return choiceNameList;
  }

  void captureScreenShoot() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      //Start Capture long images
      final RenderRepaintBoundary boundary = captureGlobalKey.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      final ui.Image image1 = await boundary.toImage();
      final ByteData? byteData =
          await image1.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();
      //End Capture long images

      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        final imagePath1 = await File('${directory.path}/image1.png').create();
        await imagePath.writeAsBytes(image);
        await imagePath1.writeAsBytes(pngBytes);

        await Share.shareFiles(
          [imagePath.path],
          text: 'Share bill detail',
          subject: 'Bill Detail',
        );
      }
    });
  }
}
