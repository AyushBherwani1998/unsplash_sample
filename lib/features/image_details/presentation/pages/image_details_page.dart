import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unplash_sample/core/widgets/error_tile.dart';
import 'package:unplash_sample/dependency_injection.dart';
import 'package:unplash_sample/features/image_details/presentation/bloc/image_details_bloc.dart';
import 'package:unplash_sample/features/image_details/presentation/widgets/image_details_widget.dart';

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

  @override
  void initState() {
    super.initState();
    bloc = DependencyInjection.getIt<ImageDetailsBloc>();
    _fetchImageDetails();
  }

  void _fetchImageDetails() {
    bloc.add(FetchImageDetailsEvent(widget.id));
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
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}