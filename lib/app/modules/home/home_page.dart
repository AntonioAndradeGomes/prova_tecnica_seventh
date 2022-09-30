import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_seventh/app/modules/home/home_store.dart';
import 'package:teste_seventh/app/modules/home/widgets/video_item.dart';
import 'package:teste_seventh/app/modules/home/widgets/video_not_found_widget.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _store = Modular.get<HomeStore>();

  @override
  void initState() {
    _store.getUrlVideo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vídeo',
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
            splashRadius: 25,
            tooltip: 'Sair',
            onPressed: () {
              _store.logoff();
            },
            icon: const Icon(
              Icons.logout_rounded,
            ),
          )
        ],
      ),
      body: Observer(
        builder: (_) {
          if (_store.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!_store.isLoading && _store.urlVideo == null) {
            return VideoNotFoundWidget(
              onPressed: () {
                _store.getUrlVideo();
              },
            );
          }
          return VideoItem(
            videoPlayerController: VideoPlayerController.network(
              _store.urlVideo!,
            ),
            looping: true,
            autoPlay: true,
          );
        },
      ),
    );
  }
}
