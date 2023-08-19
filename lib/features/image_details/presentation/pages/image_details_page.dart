import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unplash_sample/core/analytics/mixpanel_config.dart';
import 'package:unplash_sample/core/config/unleash_config.dart';
import 'package:unplash_sample/core/widgets/error_tile.dart';
import 'package:unplash_sample/core/widgets/like_button.dart';
import 'package:unplash_sample/dependency_injection.dart';
import 'package:unplash_sample/features/image_details/presentation/bloc/image_details_bloc.dart';
import 'package:unplash_sample/features/image_details/presentation/widgets/image_details_widget.dart';

@RoutePage()
class ImageDetailsPage extends StatefulWidget {
  final String id;

  const ImageDetailsPage({
    super.key,
    required this.id,
  });

  @override
  State<ImageDetailsPage> createState() => _ImageDetailsPageState();
}

class _ImageDetailsPageState extends State<ImageDetailsPage> {
  late final ImageDetailsBloc bloc;
  late final MixpanelConfig mixPanelConfig;
  late final ValueNotifier<bool> isLikedNotifier;
  late final UnleashConfig unleashConfig;

  @override
  void initState() {
    super.initState();
    bloc = DependencyInjection.getIt<ImageDetailsBloc>();
    mixPanelConfig = DependencyInjection.getIt<MixpanelConfig>();
    isLikedNotifier = ValueNotifier<bool>(false);
    unleashConfig = DependencyInjection.getIt<UnleashConfig>();
    _trackEvent();
    _fetchImageDetails();
  }

  void _trackEvent() {
    mixPanelConfig.trackImageDetaislsEvent(widget.id);
  }

  void _fetchImageDetails() {
    bloc.add(FetchImageDetailsEvent(widget.id));
  }

  bool get isLikeButtonVisible {
    return unleashConfig.isLikeOptionExperimentEnabled &&
        unleashConfig.likeButtonPosition == LikeButtonPosition.imageDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            CupertinoIcons.xmark,
          ),
        ),
        actions: [
          if (isLikeButtonVisible) ...[
            LikeButton(
              isLikedNotifier: isLikedNotifier,
              photoId: widget.id,
              likeButtonPosition: LikeButtonPosition.imageDetails,
            ),
          ]
        ],
      ),
      body: BlocBuilder<ImageDetailsBloc, ImageDetailsState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is ImageDetailsErrorState) {
            return ErrorTile(
              onTap: _fetchImageDetails,
              message: state.errorMessage,
            );
          } else if (state is ImageDetailsLoadedState) {
            return ImageDetailsWidget(imageDetails: state.imageDetails);
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }
}
