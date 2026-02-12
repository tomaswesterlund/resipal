import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/cards/default_card.dart';
import 'package:resipal/core/ui/my_app_bar.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/core/ui/views/error_state_view.dart';
import 'package:resipal/core/ui/views/loading_view.dart';
import 'package:resipal/core/ui/views/success_view.dart';
import 'package:resipal/core/ui/views/unknown_state_view.dart';
import 'package:resipal/domain/entities/community_entity.dart';
import 'package:resipal/presentation/users/user_onboarding/community/join_community/user_onboarding_join_community_cubit.dart';
import 'package:resipal/presentation/users/user_onboarding/community/join_community/user_onboarding_join_community_state.dart';

class UserOnboardingJoinCommunityPage extends StatelessWidget {
  final List<CommunityEntity> communities;
  final Function(CommunityEntity) onCommunityJoined;
  const UserOnboardingJoinCommunityPage({required this.communities, required this.onCommunityJoined, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => UserOnboardingJoinCommunityCubit()..initialize(),
      child: BlocBuilder<UserOnboardingJoinCommunityCubit, UserOnboardingJoinCommunityState>(
        builder: (ctx, state) {
          if (state is InitialState || state is LoadingState) {
            return const LoadingView();
          }

          if (state is LoadedState) {
            return _Loaded(communities: state.communities);
          }

          if (state is JoinedCommunitySuccessfully) {
            return SuccessView(
              title: '¡Solicitud Enviada!',
              subtitle:
                  'Te has unido a ${state.community.name}. Un administrador revisará tu solicitud para darte acceso completo.',
              actionButtonLabel: 'IR AL INICIO',
              onActionButtonPressed: () => onCommunityJoined,
            );
          }

          if (state is ErrorState) {
            return ErrorStateView();
          }

          return const UnknownStateView();
        },
      ),
    );
  }
}

class _Loaded extends StatefulWidget {
  final List<CommunityEntity> communities;
  const _Loaded({required this.communities});

  @override
  State<_Loaded> createState() => _LoadedState();
}

class _LoadedState extends State<_Loaded> {
  final TextEditingController _searchController = TextEditingController();
  late List<CommunityEntity> _filteredCommunities;

  @override
  void initState() {
    super.initState();
    _filteredCommunities = widget.communities;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _filteredCommunities = widget.communities
          .where((c) => c.name.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MyAppBar(title: 'Unirse a una Comunidad'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TextInputField(
            //   //
            //   label: 'Buscar comunidad o fraccionamiento',
            // ),
            // const SizedBox(height: 24),
            Expanded(
              child: _filteredCommunities.isEmpty
                  ? Center(child: BodyText.medium('No se encontraron comunidades.'))
                  : ListView.builder(
                      itemCount: _filteredCommunities.length,
                      itemBuilder: (context, index) {
                        final community = _filteredCommunities[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: DefaultCard(
                            onTap: () =>
                                context.read<UserOnboardingJoinCommunityCubit>().onCommunitySelected(community),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.group_add_outlined, size: 40),
                                  SizedBox(width: 12.0),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      HeaderText.five(community.name),
                                      // const SizedBox(height: 12),
                                      // BodyText.medium(community.description ?? ''),
                                      // const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                                          const SizedBox(width: 4),
                                          BodyText.small(community.location ?? 'Ubicación no disponible'),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Icon(Icons.arrow_forward_ios),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
