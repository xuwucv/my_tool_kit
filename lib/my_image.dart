import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BoxFit fit;

  const MyImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.errorWidget,
    this.placeholder,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    // 判断是否是网络图片
    bool isNetworkImage =
        imagePath.startsWith('http://') || imagePath.startsWith('https://');

    // 判断是否是SVG图片
    bool isSvg = imagePath.endsWith('.svg');

    // SVG 图片的加载方式
    if (isSvg) {
      return SvgPicture.network(
        imagePath,
        width: width,
        height: height,
        fit: fit,
      );
    }

    // 网络图片的加载方式
    if (isNetworkImage) {
      return CachedNetworkImage(
        imageUrl: imagePath,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) =>
            placeholder ?? const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) =>
            errorWidget ?? const Icon(Icons.error, color: Colors.black),
      );
    }

    // 默认本地图片的加载方式
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
