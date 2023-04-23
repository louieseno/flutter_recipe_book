import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  const CachedImage(
      {required this.url, this.width = 80.0, this.height = 80.0, super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: url,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(
              value: downloadProgress.progress, strokeWidth: 2.0),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
