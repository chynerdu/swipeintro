import 'dart:async';
import 'package:flutter/material.dart';
import 'package:swipeintro/intro/slider_item.dart';

class Intro extends StatefulWidget {
  final List<String>? sliderImages;
  final List<String> header;
  final TextStyle? headerStyle;
  final TextStyle? subtitleStyle;
  final List<String>? subtitle;
  final List<Color> colors;
  final int count;
  final bool? sliderColorForHeaderColor;
  final Widget? actions;

  const Intro(
      {this.sliderImages,
      required this.header,
      this.subtitle,
      this.headerStyle,
      this.sliderColorForHeaderColor = true,
      this.subtitleStyle,
      required this.colors,
      required this.count,
      this.actions,
      super.key});

  @override
  State<StatefulWidget> createState() {
    return IntroState();
  }
}

class IntroState extends State<Intro> {
  String title = '';
  String subtitle = '';
  Color activeColor = Colors.white;
  final PageController controller = PageController();
  int currentIndex = 0;

  BoxShadow hsiBoxShadow = BoxShadow(
      color: const Color(0xFF000000).withOpacity(0.15),
      spreadRadius: 1,
      blurRadius: 15);

  @override
  void initState() {
    checkProps();
    title = widget.header[0];
    subtitle = widget.subtitle != null && widget.subtitle!.isNotEmpty
        ? widget.subtitle![0]
        : '';
    activeColor = widget.colors[0];
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (currentIndex < widget.count - 1) {
        currentIndex++;
        controller.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      } else if (currentIndex == widget.count - 1) {
        currentIndex = 0;
        controller.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      } else {
        currentIndex = widget.count - 1;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  checkProps() {
    if (widget.count != widget.colors.length) {
      throw UnimplementedError(
          '${widget.colors.length} colors provided while the count is ${widget.count}. Ensure both colors and count have the same length');
    } else if (widget.count != widget.header.length) {
      throw UnimplementedError(
          '${widget.header.length} header(s) provided while the count is ${widget.count}. Ensure both header and count have the same length');
    }
  }

  List<Widget> pages() {
    List<Widget> pageList = [];
    for (final (index, item) in widget.colors.indexed) {
      pageList.add(
        SlideItem(
          color: item,
          slideImage:
              widget.sliderImages != null ? widget.sliderImages![index] : '',
        ),
      );
    }
    return pageList;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle introTitle = widget.headerStyle ??
        const TextStyle(fontSize: 24, fontWeight: FontWeight.w700);
    TextStyle introSubtitle = widget.subtitleStyle ??
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
    String activeTitle() {
      return widget.header[currentIndex];
    }

    String activeSubtitle() {
      return widget.subtitle![currentIndex];
    }

    return Scaffold(
        body: Stack(children: [
      // top
      PageView(
        controller: controller,
        scrollDirection:
            Axis.horizontal, // Set the scrolling direction to vertical
        // reverse: true, // Enable reverse scrolling
        children: pages(),
        onPageChanged: (int index) {
          setState(() {
            currentIndex = index;
            title = widget.header[currentIndex];
            subtitle = widget.subtitle != null && widget.subtitle!.isNotEmpty
                ? widget.subtitle![currentIndex]
                : '';
            activeColor = widget.colors[currentIndex];
          });
        },
      ),

      Positioned(
          bottom: 0,
          child: Container(
              margin: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
              padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 24),
              width: MediaQuery.of(context).size.width - 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [hsiBoxShadow]),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(activeTitle(),
                      textAlign: TextAlign.center,
                      style: widget.sliderColorForHeaderColor == true
                          ? introTitle.copyWith(
                              color: widget.colors[currentIndex])
                          : introTitle),
                  const SizedBox(height: 16),
                  widget.subtitle != null &&
                          widget.subtitle!.length == widget.count
                      ? Text(activeSubtitle(),
                          textAlign: TextAlign.center, style: introSubtitle)
                      : const SizedBox.shrink(),
                  const SizedBox(height: 32),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [widget.actions ?? const SizedBox.shrink()])
                ],
              )))
      // bottom
    ]));
  }
}
