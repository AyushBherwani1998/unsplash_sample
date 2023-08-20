import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unplash_sample/core/analytics/mixpanel_config.dart';
import 'package:unplash_sample/core/config/unleash_config.dart';
import 'package:unplash_sample/core/widgets/error_tile.dart';
import 'package:unplash_sample/dependency_injection.dart';
import 'package:unplash_sample/features/home/domain/usecases/fetch_images.dart';
import 'package:unplash_sample/features/home/presentation/bloc/unsplash_image_bloc.dart';
import 'package:unplash_sample/features/home/presentation/widgets/image_gridview_widget.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final UnsplashImageBloc bloc;
  late final ScrollController controller;
  late int currentPage;

  @override
  void initState() {
    super.initState();
    bloc = DependencyInjection.getIt<UnsplashImageBloc>();
    controller = ScrollController();
    controller.addListener(_onScroll);
    _fetchImageEvent();
    _trackLikeExperimentationVariant();
  }

  void _trackLikeExperimentationVariant() {
    final unleashConfig = DependencyInjection.getIt<UnleashConfig>();
    final mixpanelConfig = DependencyInjection.getIt<MixpanelConfig>();
    if (unleashConfig.isLikeOptionExperimentEnabled) {
      mixpanelConfig.trackLikeVariant(unleashConfig.likeButtonPosition);
    }
  }

  void _onScroll() {
    final maxScrollExtent = controller.position.maxScrollExtent * 0.9;
    final isBottomReacehd = controller.position.pixels >= maxScrollExtent;
    if (isBottomReacehd) {
      _fetchImageEvent(currentPage + 1);
    }
  }

  void _fetchImageEvent([int page = 1]) {
    bloc.add(FetchImageEvent(FetchImageParams(page, 30)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unsplash Demo"),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          _fetchImageEvent();
        },
        child: BlocBuilder<UnsplashImageBloc, UnsplashImageState>(
          bloc: bloc,
          buildWhen: (context, state) {
            return state is UnsplashImageInitialState ||
                state is UnsplashImageErrorState ||
                state is UnsplashImageLoadedState ||
                state is UnsplashImageLoadingState;
          },
          builder: (context, state) {
            if (state is UnsplashImageErrorState) {
              return ErrorTile(
                onTap: () {
                  _fetchImageEvent();
                },
                message: state.errorMessage,
              );
            } else if (state is UnsplashImageLoadedState) {
              currentPage = state.currentPage;
              return ImageGridViewWidget(
                images: state.images,
                controller: controller,
              );
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ),
      ),
    );
  }
}
