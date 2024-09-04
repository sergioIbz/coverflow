import 'package:coverflow/slider_coverflow.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
          child: SliderCoverFlow(
              listWidgets: List.generate(
            6,
            (index) => Container(
              decoration: BoxDecoration(
                color: Colors.primaries[index],
                image: DecorationImage(
                    image: NetworkImage(
                        'https://picsum.photos/id/${80 + index}/200/300'),
                    fit: BoxFit.cover),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
