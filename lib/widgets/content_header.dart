import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../models/content_model.dart';
import 'widgets.dart';

class ContentHeader extends StatelessWidget {
  const ContentHeader({Key? key, required this.featuredContent})
      : super(key: key);
  final Content featuredContent;

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _ContentHeaderMobile(featuredContent: featuredContent),
      desktop: _ContentHeaderDesktop(featuredContent: featuredContent),
    );
  }
}

class _ContentHeaderMobile extends StatelessWidget {
  final Content featuredContent;

  const _ContentHeaderMobile({super.key, required this.featuredContent});
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
        height: 500,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(featuredContent.imageUrl), fit: BoxFit.cover),
        ),
      ),
      Container(
        height: 500,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.black, Colors.transparent],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        )),
      ),
      Positioned(
        bottom: 110,
        child: SizedBox(
          width: 250,
          child: Image.asset(featuredContent.titleImageUrl!),
        ),
      ),
      Positioned(
        left: 0,
        right: 0,
        bottom: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            VerticalIconButton(
              icon: Icons.add,
              title: "List",
              onTap: () {},
            ),
            const _PlayButton(),
            VerticalIconButton(
              icon: Icons.info_outline,
              title: "Info",
              onTap: () {},
            ),
          ],
        ),
      ),
    ]);
  }
}

class _ContentHeaderDesktop extends StatefulWidget {
  final Content featuredContent;

  const _ContentHeaderDesktop({super.key, required this.featuredContent});

  @override
  State<_ContentHeaderDesktop> createState() => _ContentHeaderDesktopState();
}

class _ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {
  late VideoPlayerController _videoPlayerController;
  bool _isMuted = true;
  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.network(widget.featuredContent.videoUrl!)
          ..initialize().then(
            (value) => setState(() {}),
          )
          ..setVolume(0)
          ..play();
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _videoPlayerController.value.isPlaying
          ? _videoPlayerController.play()
          : _videoPlayerController.pause(),
      child: Stack(alignment: Alignment.bottomLeft, children: [
        AspectRatio(
          aspectRatio: _videoPlayerController.value.isInitialized
              ? _videoPlayerController.value.aspectRatio
              : 2.77,
          child: _videoPlayerController.value.isInitialized
              ? VideoPlayer(_videoPlayerController)
              : Image.asset(widget.featuredContent.imageUrl),
        ),
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.black, Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )),
        ),
        Positioned(
          bottom: 150.0,
          left: 60.0,
          right: 60.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 250,
                child: Image.asset(widget.featuredContent.titleImageUrl!),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.featuredContent.description!,
                style: const TextStyle(
                  color: Color.fromARGB(255, 128, 61, 61),
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(2.0, 4.0),
                      blurRadius: 6.0,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const _PlayButton(),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.info_outline,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {},
                    label: const Text(
                      "More Info",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(25, 10, 30, 10),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black),
                  ),
                  const SizedBox(width: 20),
                  if (_videoPlayerController.value.isInitialized)
                    IconButton(
                      onPressed: () => setState(() {
                        _isMuted
                            ? _videoPlayerController.setVolume(100)
                            : _videoPlayerController.setVolume(0);
                        _isMuted = _videoPlayerController.value.volume == 0;
                      }),
                      icon: Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
                      color: Colors.white,
                      iconSize: 30,
                    ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(
        Icons.play_arrow,
        color: Colors.black,
        size: 30,
      ),
      onPressed: () {},
      label: const Text(
        "Play",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: !Responsive.isDesktop(context)
            ? const EdgeInsets.fromLTRB(15, 5, 20, 5)
            : const EdgeInsets.fromLTRB(25, 10, 30, 10),
      ),
    );
  }
}
