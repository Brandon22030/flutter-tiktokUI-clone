import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/video_model.dart';

class VideoBottomInfo extends StatelessWidget {
  final VideoModel video;

  const VideoBottomInfo({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, bottom: 15, right: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Nom d'utilisateur
          Text(
            video.username,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          
          // Description/Légende
          Text(
            video.caption,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          
          // Informations sur la musique
          Row(
            children: [
              const Icon(
                FontAwesomeIcons.music,
                color: Colors.white,
                size: 15,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  video.songName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Icône de marqueur de musique animé (simulé avec un Container)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Text(
                      'Original',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.music_note,
                      color: Colors.white.withOpacity(0.9),
                      size: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
