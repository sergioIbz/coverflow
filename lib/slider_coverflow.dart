import 'package:flutter/material.dart';

class SliderCoverFlow extends StatefulWidget {
  final int initialPage;
  final List<Widget> listWidgets;

  const SliderCoverFlow({
    required this.listWidgets,
    this.initialPage = 0,
    super.key,
  });

  @override
  State<SliderCoverFlow> createState() => _SliderCoverFlowState();
}

class _SliderCoverFlowState extends State<SliderCoverFlow> {
  late PageController controller;
  double page = 0.0;

  @override
  void initState() {
    controller = PageController(
      initialPage: widget.initialPage,
      viewportFraction: 0.8,
    );

    controller.addListener(() {
      setState(() {
        page = controller.page ?? 0;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemCount: widget.listWidgets.length,
      itemBuilder: (BuildContext context, int index) {
        double porcentaje = (page - index).abs();
        final double cub = (index < page) ? 1 : -1;
        double scale = 0.8 + (0.2 * (1 - porcentaje));
        const recorte = 150;
        return Center(
          child: Transform.translate(
            offset: Offset(
              (recorte * cub) * porcentaje,
              0,
            ),
            child: ClipRect(
              clipper: LeftClipper(
                cub == -1 ? ((recorte) * (porcentaje)) : 0.0,
              ),
              child: Transform.scale(
                alignment:
                    cub == -1 ? Alignment.centerLeft : Alignment.centerRight,
                scale: scale,
                child: LayoutBuilder(
                  builder: (
                    BuildContext context,
                    BoxConstraints constraints,
                  ) {
                    final width = constraints.maxWidth;
                    final height = (width * 9) / 16;
                  
                    return SizedBox(
                      width: width,
                      height: height,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: widget.listWidgets[index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class LeftClipper extends CustomClipper<Rect> {
  final double clipAmount;

  LeftClipper(this.clipAmount);

  @override
  Rect getClip(Size size) {


    return Rect.fromLTWH(
      clipAmount,
      0,
      size.width - clipAmount,
      size.height,
    );
  }

  @override
  bool shouldReclip(LeftClipper oldClipper) {
    return oldClipper.clipAmount != clipAmount;
  }
}
