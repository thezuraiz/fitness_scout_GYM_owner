import 'package:fitness_scout_owner_v1/data/repositories/upcoming_event/upcoming_events_repository.dart';
import 'package:fitness_scout_owner_v1/features/gym/model/upcoming_events.dart';
import 'package:fitness_scout_owner_v1/utils/popups/loader.dart';
import 'package:get/get.dart';

import '../../../utils/helpers/logger.dart';

class UpcomingEventsController extends GetxController {
  static UpcomingEventsController get instance => Get.find();
  final upcomingEvents = Get.put(UpcomingEventsRepository());
  RxList<GymEvent> gymEvents = <GymEvent>[].obs;
  RxBool isEventsLoading = false.obs;

  @override
  void onInit() {
    fetchUpcomingEventRecords();
  }

  Future<void> fetchUpcomingEventRecords() async {
    try {
      ZLogger.info('Fetching Upcoming Events User Profile');
      isEventsLoading.value = true;
      final events = await upcomingEvents.fetchEvents();
      this.gymEvents(events);
      ZLogger.info('Fetching Upcoming Events: ${events.length}');
    } catch (e) {
      ZLoaders.errorSnackBar(
          title: 'Something went wrong ',
          message: 'While fetching Upcoming Events');
    } finally {
      isEventsLoading.value = false;
    }
  }
}
