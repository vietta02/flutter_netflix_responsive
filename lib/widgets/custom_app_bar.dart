import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/widgets/widgets.dart';

import '../assets.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, this.scrollOffeset = 0}) : super(key: key);
  final double scrollOffeset;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
        color: Colors.black
            .withOpacity((scrollOffeset / 350).clamp(0, 1).toDouble()),
        child: const Responsive(
            mobile: _CustomAppBarMobile(), desktop: _CustomAppBarDesktop()));
  }
}

class _CustomAppBarMobile extends StatelessWidget {
  const _CustomAppBarMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo0),
          const SizedBox(
            width: 28,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(title: "TV Show", onTap: () {}),
                _AppBarButton(title: "Movies", onTap: () {}),
                _AppBarButton(title: "My List", onTap: () {}),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomAppBarDesktop extends StatelessWidget {
  const _CustomAppBarDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(Assets.netflixLogo1),
          const SizedBox(
            width: 28,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(title: "Home", onTap: () {}),
                _AppBarButton(title: "TV Show", onTap: () {}),
                _AppBarButton(title: "Movies", onTap: () {}),
                _AppBarButton(title: "Latest", onTap: () {}),
                _AppBarButton(title: "My List", onTap: () {}),
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.search),
                  iconSize: 28,
                  color: Colors.white,
                  onPressed: () {},
                ),
                _AppBarButton(title: "KIDS", onTap: () {}),
                _AppBarButton(title: "DVD", onTap: () {}),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.card_giftcard),
                  iconSize: 28,
                  color: Colors.white,
                  onPressed: () {},
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.notifications),
                  iconSize: 28,
                  color: Colors.white,
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _AppBarButton extends StatelessWidget {
  const _AppBarButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function(),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
