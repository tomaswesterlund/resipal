import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';

class ApplicationDetailsCubit extends Cubit<ApplicationDetailsState> {
  final LoggerService _logger = GetIt.I<LoggerService>();

  final WatchApplicationById _watchApplicationById = WatchApplicationById();
  StreamSubscription? _streamSubscription;

  ApplicationDetailsCubit() : super(ApplicationDetailsInitialState());

  Future initialize(ApplicationEntity application) async {
    try {
      emit(ApplicationDetailsLoadedState(application));

      _streamSubscription = _watchApplicationById
          .call(id: application.id)
          .listen(
            (application) async {
              emit(ApplicationDetailsLoadedState(application));
            },
            onError: (e, s) {
              _logger.error(
                featureArea: 'ApplicationDetailsCubit.initialize',
                exception: e,
                stackTrace: s,
                metadata: {'application': application.toMap()},
              );

              emit(ApplicationDetailsErrorState());
            },
          );
    } catch (e, s) {
      _logger.error(
        exception: e,
        featureArea: 'ApplicationDetailsCubit.initialize',
        stackTrace: s,
        metadata: {'application': application.toMap()},
      );

      emit(ApplicationDetailsErrorState());
    }
  }

  Future sendInvitationWhatsApp(ApplicationEntity application) async {
    try {
      await SendInvitationWhatsappMessage().call(
        phoneNumber: application.phoneNumber,
        personName: application.name,
        communityName: application.community.name,
      );
    } catch (e, s) {
      _logger.error(featureArea: 'ApplicationDetailsCubit', exception: e, stackTrace: s);
      emit(ApplicationDetailsErrorState());
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
