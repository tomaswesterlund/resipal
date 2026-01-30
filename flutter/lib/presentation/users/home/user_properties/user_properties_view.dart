import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal/core/ui/cards/shimmer_card.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/core/ui/views/error_state_view.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/presentation/properties/no_properties_found_view.dart';
import 'package:resipal/presentation/properties/property_list_view.dart';
import 'package:resipal/presentation/users/home/user_properties/user_properties_cubit.dart';
import 'package:resipal/presentation/users/home/user_properties/user_properties_state.dart';

class UserPropertiesView extends StatelessWidget {
  final UserEntity user;
  const UserPropertiesView({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => UserPropertiesCubit()..intialize(user.id),
      child: BlocBuilder<UserPropertiesCubit, UserPropertiesState>(
        builder: (ctx, state) {
          if (state.isError) {
            return ErrorStateView(
              errorMessage: state.errorMessage,
              exception: state.exception,
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderText.four('Mis Propiedades'),
              const SizedBox(height: 12),

              if (state.isFetching) ...[
                ShimmerCard(),
                ShimmerCard(),
                ShimmerCard(),
              ] else if (state.properties.isEmpty)
                NoPropertiesFoundView()
              else
                PropertyListView(state.properties),
            ],
          );
        },
      ),
    );
  }
}
