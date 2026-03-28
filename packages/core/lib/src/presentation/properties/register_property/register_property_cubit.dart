import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:core/lib.dart';

class RegisterPropertyCubit extends Cubit<RegisterPropertyState> {
  final ImageService _imageService = GetIt.I<ImageService>();
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SessionService _sessionService = GetIt.I<SessionService>();

  RegisterPropertyCubit() : super(RegisterPropertyInitialState());

  StreamSubscription? _stream;
  final ImagePicker _picker = ImagePicker();

  late RegisterPropertyFormState _formState;

  void initialize() {
    final community = GetCommunityById().call(_sessionService.communityId);
    if (community.canRegisterNewProperty == false) {
      emit(RegisterPropertyLimitReachedState());
      return;
    }

    _stream = WatchContractsByCommunity()
        .call(_sessionService.communityId)
        .listen(
          (contracts) {
            if (contracts.isEmpty) {
              emit(RegisterPropertyNoContractsFound());
              return;
            }

            final residents = GetResidentsByCommunity().call(_sessionService.communityId);

            _formState = RegisterPropertyFormState(residents: residents, contracts: contracts);
            emit(RegisterPropertyFormEditingState(_formState));
          },
          onError: (e, s) {
            _logger.error(
              exception: e,
              stackTrace: s,
              featureArea: 'RegisterPropertyCubit.initialize.WatchContractsByCommunity',
              metadata: {'community_id': _sessionService.communityId, 'device_time': DateTime.now().toIso8601String()},
            );
            emit(RegisterPropertyErrorState());
          },
        );
  }

  void onContractSelected(ContractEntity? newContract) {
    _formState = _formState.copyWith(contract: newContract);
    emit(RegisterPropertyFormEditingState(_formState));
  }

  void onResidentSelected(ResidentMemberEntity? newResident) {
    _formState = _formState.copyWith(resident: newResident);
    emit(RegisterPropertyFormEditingState(_formState));
  }

  void updateName(String newName) {
    _formState = _formState.copyWith(name: newName);
    emit(RegisterPropertyFormEditingState(_formState));
  }

  void updateDescription(String newDescription) {
    _formState = _formState.copyWith(name: newDescription);
    emit(RegisterPropertyFormEditingState(_formState));
  }

  void pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source, imageQuality: 70);

      if (image != null) {
        _formState = _formState.copyWith(receiptImage: image);
        emit(RegisterPropertyFormEditingState(_formState));
      }
    } catch (e, stack) {
      await _logger.error(
        exception: e,
        stackTrace: stack,
        featureArea: 'RegisterPropertyCubit.pickImage',
        metadata: {'source': source.toString(), 'device_time': DateTime.now().toIso8601String()},
      );

      emit(RegisterPropertyErrorState());
    }
  }

  void removeImage() {
    _formState = _formState.copyWith(receiptImage: null);
    emit(RegisterPropertyFormEditingState(_formState));
  }

  Future submit() async {
    try {
      if (_formState.canSubmit == false) {
        emit(RegisterPropertyErrorState());
        return;
      }

      emit(RegisterPropertyFormSubmittingState());
      final communityId = _sessionService.communityId;

      final propertyId = await RegisterProperty().call(
        communityId: communityId,
        residentId: _formState.resident?.user.id,
        contractId: _formState.contract?.id,
        name: _formState.name!,
        description: _formState.description,
      );

      await FetchPropertyById().call(propertyId);

      emit(RegisterPropertyFormSubmittedSuccessfullyState());
    } catch (e, s) {
      await _logger.error(
        exception: e,
        stackTrace: s,
        featureArea: 'RegisterPropertyCubit.submit',

        metadata: _formState.toMap(),
      );
      emit(RegisterPropertyErrorState());
    }
  }

  @override
  Future<void> close() {
    _stream?.cancel();
    return super.close();
  }
}
