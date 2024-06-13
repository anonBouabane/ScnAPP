import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

import '../../apis/api_exception.dart';
import '../../controllers/user_controller.dart';
import '../../models/invoice_model.dart';
import '../../models/lottery_history_model.dart';
import '../buy_lottery/animal_model.dart';
import 'invoice_result_service.dart';

class InvoiceResultController extends GetxController {
  final UserController userController = Get.find<UserController>();
  final invoiceLotteryService = Get.find<InvoiceResultService>();
  final PagingController<int, InvoiceItem> pagingInvoiceController =
      PagingController(firstPageKey: 0);
  final PagingController<int, DrawItem> pagingResultController =
      PagingController(firstPageKey: 0);
  RxInt currentTabIndex = 0.obs;
  RxBool invoiceLoading = false.obs;
  RxInt limitInvoice = 10.obs;
  RxInt offsetInvoice = 0.obs;
  RxInt pageSizeInvoice = 10.obs;
  RxBool resultLoading = false.obs;
  RxInt limitResult = 20.obs;
  RxInt offsetResult = 0.obs;
  RxInt pageSizeResult = 20.obs;
  RxString customerPhone = ''.obs;
  @override
  void onInit() async {
    super.onInit();
    customerPhone.value = userController.userInfoModel.phone!;
    paginate();
  }

  @override
  void onClose() {
    super.onClose();
    pagingInvoiceController.dispose();
  }

  loadInvoices(int pageKey) async {
    try {
      invoiceLoading.value = true;
      final response = await invoiceLotteryService.loadInvoices(
        phone: customerPhone.value,
        offset: offsetInvoice.value,
        limit: limitInvoice.value,
      );
      if (response.statusCode == 200) {
        InvoiceModel items = InvoiceModel.fromJson(response.data);
        List<InvoiceItem> newItems = [];

        if (items.totalSize! > 0) {
          for (InvoiceItem item in items.lotteryHistories!) {
            newItems.add(item);
          }
        }

        final isLastPage = newItems.length < pageSizeInvoice.value;
        if (kDebugMode) {
          Logger().i(
            'isLastPage: $isLastPage\n'
            'Length: ${newItems.length}\n'
            'PageSize: ${pageSizeInvoice.value}',
          );
        }
        if (isLastPage) {
          pagingInvoiceController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          offsetInvoice.value = offsetInvoice.value + limitInvoice.value;
          limitInvoice.value = limitInvoice.value + limitInvoice.value;
          pagingInvoiceController.appendPage(newItems, nextPageKey);
        }
      }
      invoiceLoading.value = false;
    } on DioException catch (error) {
      invoiceLoading.value = false;
      pagingInvoiceController.error = error;
      final apiException = ApiException.fromDioError(error);
      if (kDebugMode) {
        Logger().e('apiException: ${apiException.message}');
      }
    }
  }

  loadResults(int pageKey) async {
    try {
      resultLoading.value = true;
      final response = await invoiceLotteryService.loadResults(
        customerPhone: customerPhone.value,
        offset: offsetResult.value,
        limit: limitResult.value,
      );
      if (response.statusCode == 200) {
        LotteryHistoryModel items = LotteryHistoryModel.fromJson(response.data);
        List<DrawItem> newItems = [];

        if (items.totalSize! > 0) {
          for (DrawItem item in items.draws!) {
            newItems.add(item);
          }
        }

        final isLastPage = newItems.length < pageSizeResult.value;
        if (kDebugMode) {
          Logger().i(
            'isLastPage: $isLastPage\n'
            'Length: ${newItems.length}\n'
            'PageSize: ${pageSizeResult.value}',
          );
        }
        if (isLastPage) {
          pagingResultController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          offsetResult.value = offsetResult.value + limitResult.value;
          limitResult.value = limitResult.value + limitResult.value;
          pagingResultController.appendPage(newItems, nextPageKey);
        }
      }
      resultLoading.value = false;
    } on DioException catch (error) {
      resultLoading.value = false;
      pagingResultController.error = error;
      final apiException = ApiException.fromDioError(error);
      if (kDebugMode) {
        Logger().d('apiException: ${apiException.message}');
      }
    }
  }

  paginate() {
    pagingInvoiceController.addPageRequestListener((pageKey) {
      loadInvoices(pageKey);
    });

    pagingInvoiceController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: const Text(
              'ເກີດຂໍ້ຜິດພາດບາງຢ່າງ ກະລຸນາລອງໃໝ່',
            ),
            action: SnackBarAction(
              label: 'ລອງໃໝ່',
              onPressed: () => pagingInvoiceController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });

    pagingResultController.addPageRequestListener((pageKey) {
      loadResults(pageKey);
    });

    pagingResultController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong while fetching a new page.',
            ),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => pagingResultController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });
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
}
