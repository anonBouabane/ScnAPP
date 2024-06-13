import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'package:scn_easy/app/apis/api_exception.dart';
import 'package:scn_easy/controller/auth_controller.dart';

import 'lottery_invoice_history_model.dart';
import 'lottery_invoice_history_service.dart';

class LotteryInvoiceHistoryController extends GetxController {
  final lotteryHistoryService = Get.put(LotteryInvoiceHistoryService());

  final PagingController<int, LotteryInvoiceHistoryItem> pagingController =
      PagingController(firstPageKey: 0);

  RxInt limit = 10.obs;
  RxInt offset = 0.obs;
  RxInt pageSize = 10.obs;
  RxBool invoiceLoading = false.obs;

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

  loadLotteryHistories(int pageKey) async {
    try {
      invoiceLoading.value = true;
      final response =
          await lotteryHistoryService.loadLotteryInvoiceHistoryForPagination(
        phone: Get.find<AuthController>().getUserNumber(),
        offset: offset.value,
        limit: limit.value,
      );
      if (response.statusCode == 200) {
        LotteryInvoiceHistoryModel items =
            LotteryInvoiceHistoryModel.fromJson(response.data);
        List<LotteryInvoiceHistoryItem> newItems = [];

        if (items.totalSize! > 0) {
          for (LotteryInvoiceHistoryItem item in items.lotteryHistories!) {
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
        Logger().e('apiException: ${apiException.message}');
      }
    }
  }

  paginate() {
    pagingController.addPageRequestListener((pageKey) {
      loadLotteryHistories(pageKey);
    });

    pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: const Text(
              'ເກີດຂໍ້ຜິດພາດບາງຢ່າງ ກະລຸນາລອງໃໝ່',
            ),
            action: SnackBarAction(
              label: 'ລອງໃໝ່',
              onPressed: () => pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });
  }
}
