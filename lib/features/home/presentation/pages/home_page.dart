import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    bloc = DependencyInjection.getIt<UnsplashImageBloc>();
    _fetchImageEvent();
  }

  void _fetchImageEvent() {
    bloc.add(FetchImageEvent(FetchImageParams(1, 30)));
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
          builder: (context, state) {
            if (state is UnsplashImageErrorState) {
              return ErrorTile(
                onTap: () {
                  _fetchImageEvent();
                },
                message: state.errorMessage,
              );
            } else if (state is UnsplashImageLoadedState) {
              return ImageGridViewWidget(images: state.images);
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
