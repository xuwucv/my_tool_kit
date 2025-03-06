import 'package:flutter/material.dart';
import 'package:my_tool_kit/my_tool_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Network Image Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Network Image Test"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 使用自定义的 CustomImage 组件
            MyImage(
              imagePath: 'https://loremflickr.com/400/200', // 替换为有效的网络图片 URL
              width: 200,
              height: 200,
              fit: BoxFit.contain,
              placeholder: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Icon(
                  Icons.image,
                ),
              ), // 自定义占位图
            ),
            SizedBox(height: 20),
            Text("Network Image Test"),
          ],
        ),
      ),
    );
  }
}
