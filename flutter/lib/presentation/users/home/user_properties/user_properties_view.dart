import 'package:flutter/material.dart';
import 'package:resipal/core/ui/cards/shimmer_card.dart';
import 'package:resipal/domain/entities/user_property_entity.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/presentation/properties/no_properties_found_view.dart';
import 'package:resipal/presentation/properties/property_list_view.dart';

class UserPropertiesView extends StatelessWidget {
  final UserEntity user;
  const UserPropertiesView({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    if (user.properties.isEmpty) {
      return NoPropertiesFoundView();
    } else {
      return PropertyListView(user.properties);
    }
    // return BlocProvider(
    //   create: (ctx) => UserPropertiesCubit()..intialize(user.id),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       const HeaderText.three('Mis propiedades'),
    //       const SizedBox(height: 16), // Spacing between header and content
    //       BlocBuilder<UserPropertiesCubit, UserPropertiesState>(
    //         builder: (ctx, state) {
    //           if (state is InitialState || state is LoadingState) {
    //             return const _Loading();
    //           }

    //           if (state is LoadedState) {
    //             return _Loaded(state.properties);
    //           }

    //           if (state is ErrorState) {
    //             return const ErrorStateView();
    //           }

    //           return UnknownStateView();
    //         },
    //       ),
    //     ],
    //   ),
    // );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [ShimmerCard(), ShimmerCard(), ShimmerCard()],
    );
  }
}

class _Loaded extends StatelessWidget {
  final List<PropertyEntity> properties;
  const _Loaded(this.properties, {super.key});

  @override
  Widget build(BuildContext context) {
    if (properties.isEmpty) {
      return NoPropertiesFoundView();
    } else {
      return PropertyListView(properties);
    }
  }
}
