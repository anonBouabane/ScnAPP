import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'package:scn_easy/app/apis/api_exception.dart';
import 'package:scn_easy/data/model/body/lotto_animal_book.dart';

import 'lottery_result_history_model.dart';
import 'lottery_result_history_service.dart';

class LotteryResultHistoryController extends GetxController {
  final lotteryResultHistoryService = Get.put(LotteryResultHistoryService());

  final PagingController<int, DrawItem> pagingController =
      PagingController(firstPageKey: 0);

  RxInt limit = 20.obs;
  RxInt offset = 0.obs;
  RxInt pageSize = 20.obs;
  RxBool invoiceLoading = false.obs;
  RxList<DrawItem> lstDrawItem = RxList([]);

  @override
  void onInit() async {
    super.onInit();
    paginate();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    pagingController.dispose();
  }

  loadLotteryResultHistories(int pageKey) async {
    try {
      invoiceLoading.value = true;
      final response = await lotteryResultHistoryService
          .loadLotteryResultHistoryForPagination(
        offset: offset.value,
        limit: limit.value,
      );
      if (response.statusCode == 200) {
        LotteryResultHistoryModel items =
            LotteryResultHistoryModel.fromJson(response.data);
        List<DrawItem> newItems = [];

        if (items.totalSize! > 0) {
          for (DrawItem item in items.draws!) {
            newItems.add(item);
          }
        }

        final isLastPage = newItems.length < pageSize.value;
        if (kDebugMode) {
          Logger().i(
            'isLastPage: $isLastPage\n'
            'Length: ${newItems.length}\n'
            'PageSize: ${pageSize.value}',
          );
        }
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          offset.value = offset.value + limit.value;
          limit.value = limit.value + limit.value;
          pagingController.appendPage(newItems, nextPageKey);
        }
      }
      invoiceLoading.value = false;
    } on DioException catch (error) {
      invoiceLoading.value = false;
      pagingController.error = error;
      final apiException = ApiException.fromDioError(error);
      if (kDebugMode) {
        Logger().d('apiException: ${apiException.message}');
      }
    }
  }

  paginate() {
    pagingController.addPageRequestListener((pageKey) {
      loadLotteryResultHistories(pageKey);
    });

    pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong while fetching a new page.',
            ),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });
  }

  List<LottoAnimalBookModel> animalList = [
    LottoAnimalBookModel(
      name: 'small_fish',
      lotteryNo: '01,41,81',
      img: 'assets/lotto/img/goldfish.png',
    ),
    LottoAnimalBookModel(
      name: 'snail',
      lotteryNo: '02,42,82',
      img: 'assets/lotto/img/snail.png',
    ),
    LottoAnimalBookModel(
      name: 'goose',
      lotteryNo: '03,43,83',
      img: 'assets/lotto/img/goose.png',
    ),
    LottoAnimalBookModel(
      name: 'peacock',
      lotteryNo: '04,44,84',
      img: 'assets/lotto/img/poem.png',
    ),
    LottoAnimalBookModel(
      name: 'lion',
      lotteryNo: '05,45,85',
      img: 'assets/lotto/img/lion.png',
    ),
    LottoAnimalBookModel(
      name: 'tiger',
      lotteryNo: '06,46,86',
      img: 'assets/lotto/img/tiger.png',
    ),
    LottoAnimalBookModel(
      name: 'pig',
      lotteryNo: '07,47,87',
      img: 'assets/lotto/img/pig.png',
    ),
    LottoAnimalBookModel(
      name: 'rabbit',
      lotteryNo: '08,48,88',
      img: 'assets/lotto/img/rabit.png',
    ),
    LottoAnimalBookModel(
      name: 'buffalo',
      lotteryNo: '09,49,89',
      img: 'assets/lotto/img/buffalo.png',
    ),
    LottoAnimalBookModel(
      name: 'otter',
      lotteryNo: '10,50,90',
      img: 'assets/lotto/img/seal.png',
    ),
    LottoAnimalBookModel(
      name: 'dog',
      lotteryNo: '11,51,91',
      img: 'assets/lotto/img/dog.png',
    ),
    LottoAnimalBookModel(
      name: 'horse',
      lotteryNo: '12,52,92',
      img: 'assets/lotto/img/horse.png',
    ),
    LottoAnimalBookModel(
      name: 'elephant',
      lotteryNo: '13,53,93',
      img: 'assets/lotto/img/elephant.png',
    ),
    LottoAnimalBookModel(
      name: 'cat',
      lotteryNo: '14,54,94',
      img: 'assets/lotto/img/cat.png',
    ),
    LottoAnimalBookModel(
      name: 'rat',
      lotteryNo: '15,55,95',
      img: 'assets/lotto/img/rat.png',
    ),
    LottoAnimalBookModel(
      name: 'bee',
      lotteryNo: '16,56,96',
      img: 'assets/lotto/img/bee.png',
    ),
    LottoAnimalBookModel(
      name: 'egret',
      lotteryNo: '17,57,97',
      img: 'assets/lotto/img/bird3.png',
    ),
    LottoAnimalBookModel(
      name: 'bobcat',
      lotteryNo: '18,58,98',
      img: 'assets/lotto/img/eurasian.png',
    ),
    LottoAnimalBookModel(
      name: 'butterfly',
      lotteryNo: '19,59,99',
      img: 'assets/lotto/img/buterfly.png',
    ),
    LottoAnimalBookModel(
      name: 'centipede',
      lotteryNo: '20,60,00',
      img: 'assets/lotto/img/chinese_red_headed.png',
    ),
    LottoAnimalBookModel(
      name: 'swallow',
      lotteryNo: '21,61',
      img: 'assets/lotto/img/swallow.png',
    ),
    LottoAnimalBookModel(
      name: 'pigeon',
      lotteryNo: '22,62',
      img: 'assets/lotto/img/bird1.png',
    ),
    LottoAnimalBookModel(
      name: 'monkey',
      lotteryNo: '23,63',
      img: 'assets/lotto/img/monkey.png',
    ),
    LottoAnimalBookModel(
      name: 'frog',
      lotteryNo: '24,64',
      img: 'assets/lotto/img/fog.png',
    ),
    LottoAnimalBookModel(
      name: 'falcon',
      lotteryNo: '25,65',
      img: 'assets/lotto/img/bird2.png',
    ),
    LottoAnimalBookModel(
      name: 'flying_otter',
      lotteryNo: '26,66',
      img: 'assets/lotto/img/dragon.png',
    ),
    LottoAnimalBookModel(
      name: 'turtle',
      lotteryNo: '27,67',
      img: 'assets/lotto/img/turtle.png',
    ),
    LottoAnimalBookModel(
      name: 'rooster',
      lotteryNo: '28,68',
      img: 'assets/lotto/img/chicken.png',
    ),
    LottoAnimalBookModel(
      name: 'eel',
      lotteryNo: '29,69',
      img: 'assets/lotto/img/eel.png',
    ),
    LottoAnimalBookModel(
      name: 'big_fish',
      lotteryNo: '30,70',
      img: 'assets/lotto/img/fish.png',
    ),
    LottoAnimalBookModel(
      name: 'praw',
      lotteryNo: '31,71',
      img: 'assets/lotto/img/shrimps.png',
    ),
    LottoAnimalBookModel(
      name: 'snake',
      lotteryNo: '32,72',
      img: 'assets/lotto/img/snack.png',
    ),
    LottoAnimalBookModel(
      name: 'spider',
      lotteryNo: '33,73',
      img: 'assets/lotto/img/spider.png',
    ),
    LottoAnimalBookModel(
      name: 'deer',
      lotteryNo: '34,74',
      img: 'assets/lotto/img/deer.png',
    ),
    LottoAnimalBookModel(
      name: 'goat',
      lotteryNo: '35,75',
      img: 'assets/lotto/img/goat.png',
    ),
    LottoAnimalBookModel(
      name: 'palm_civet',
      lotteryNo: '36,76',
      img: 'assets/lotto/img/pngtree_civet.png',
    ),
    LottoAnimalBookModel(
      name: 'pangolin',
      lotteryNo: '37,77',
      img: 'assets/lotto/img/ecad.png',
    ),
    LottoAnimalBookModel(
      name: 'hedgehog',
      lotteryNo: '38,78',
      img: 'assets/lotto/img/exhibition.png',
    ),
    LottoAnimalBookModel(
      name: 'crab',
      lotteryNo: '39,79',
      img: 'assets/lotto/img/blue-crab.png',
    ),
    LottoAnimalBookModel(
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
