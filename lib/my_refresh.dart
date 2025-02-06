import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';

/// 通用的 EasyRefresh 封装组件
class MyRefresh extends StatefulWidget {
  /// 刷新时的回调函数
  final Future<void> Function()? onRefresh;

  /// 加载更多时的回调函数
  final Future<void> Function()? onLoad;

  /// 刷新区域的子组件（一般为 ListView、GridView 或 CustomScrollView 等）
  final Widget child;

  /// 可选的内边距配置
  final EdgeInsetsGeometry? padding;

  /// 自定义的 Header 组件（默认使用 ClassicHeader）
  final Header? header;

  /// 自定义的 Footer 组件（默认使用 ClassicFooter）
  final Footer? footer;

  /// 是否开启下拉刷新
  final bool enableRefresh;

  /// 是否开启上拉加载
  final bool enableLoad;

  const MyRefresh({
    super.key,
    required this.child,
    this.onRefresh,
    this.onLoad,
    this.padding,
    this.header,
    this.footer,
    this.enableRefresh = true, // 默认启用刷新
    this.enableLoad = true, // 默认启用加载更多
  });

  @override
  State<MyRefresh> createState() => _MyRefreshState();
}

class _MyRefreshState extends State<MyRefresh> {
  /// 创建 EasyRefresh 控制器，用于控制刷新和加载状态
  final EasyRefreshController _controller = EasyRefreshController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: _controller,
      header: widget.header ?? const ClassicHeader(), // 默认 ClassicHeader
      footer: widget.footer ?? const ClassicFooter(), // 默认 ClassicFooter
      onRefresh: widget.enableRefresh ? widget.onRefresh : null,
      onLoad: widget.enableLoad ? widget.onLoad : null,
      child: Padding(
        padding: widget.padding ?? EdgeInsets.zero,
        child: widget.child,
      ),
    );
  }
}
