import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:core/src/domain/use_cases/applications/watch_applications_by_email.dart';
import 'package:core/src/domain/use_cases/applications/watch_applications_by_user_id.dart';
import 'package:core/src/presentation/residents/resident_applications/resident_application_state.dart';

class ResidentApplicationCubit extends Cubit<ResidentApplicationState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final AuthService _auth = GetIt.I<AuthService>();
  final SessionService _session = GetIt.I<SessionService>();

  ResidentApplicationCubit() : super(ResidentApplicationInitialState());

  StreamSubscription? _stream;

  initialize(UserEntity user) {
    try {
      emit(ResidentApplicationLoadingState());

      _stream = WatchApplicationsByEmail()
          .call(email: user.email)
          .listen(
            (applications) {
              emit(ResidentApplicationLoadedState(applications: applications));
            },
            onError: (e, s) {
              emit(ResidentApplicationErrorState());
              _logger.error(featureArea: 'ResidentApplicationCubit', exception: e, stackTrace: s);
            },
          );
    } catch (e, s) {
      emit(ResidentApplicationErrorState());
      _logger.error(featureArea: 'ResidentApplicationCubit', exception: e, stackTrace: s);
    }
  }

  Future acceptApplication(ApplicationEntity application) async {
    try {
      emit(ResidentApplicationLoadingState());
      final userId = _auth.getSignedInUserId();
      await AcceptApplication().call(application: application, userId: userId);
      
      final community = GetCommunityById().call(application.community.id);
      await _session.startCommunityWatchers(app: ResipalApplication.resident, userId: userId, communityId: community.id);
      final resident = GetResidentByCommunityIdAndUserId().call(communityId: application.community.id, userId: userId);

      

      emit(ResidentApplicationJoinedSuccessfullyState(community: community, resident: resident));
    } catch (e, s) {
      emit(ResidentApplicationErrorState());
      _logger.error(featureArea: 'ResidentApplicationCubit', exception: e, stackTrace: s);
    }
  }

  @override
  Future<void> close() {
    _stream?.cancel();
    return super.close();
  }
}
