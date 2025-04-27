import 'package:flutter/material.dart';
import '../models/video_model.dart';
import '../utils/dummy_data.dart';
import '../widgets/video_player_item.dart';
import '../widgets/video_side_actions.dart';
import '../widgets/video_bottom_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fond noir pour l'arrière-plan
          Container(color: Colors.black),
          
          // PageView pour faire défiler les vidéos verticalement
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: dummyVideos.length,
            onPageChanged: (index) {
              // Pas besoin de stocker l'index actuel pour l'instant
              setState(() {});
            },
            itemBuilder: (context, index) {
              final VideoModel video = dummyVideos[index];
              return _buildVideoPage(video);
            },
          ),
          
          // En-tête avec "Pour toi" et "Abonnements"
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildHeaderTab(title: 'Pour toi', isSelected: true),
                  const SizedBox(width: 20),
                  _buildHeaderTab(title: 'Abonnements', isSelected: false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPage(VideoModel video) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Lecteur vidéo
        VideoPlayerItem(videoUrl: video.videoUrl),
        
        // Informations latérales (likes, commentaires, partages)
        Positioned(
          right: 10,
          bottom: 80,
          child: VideoSideActions(video: video),
        ),
        
        // Informations du bas (nom d'utilisateur, description, musique)
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: VideoBottomInfo(video: video),
        ),
      ],
    );
  }

  Widget _buildHeaderTab({required String title, required bool isSelected}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        if (isSelected)
          Container(
            margin: const EdgeInsets.only(top: 5),
            width: 30,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
      ],
    );
  }
}
