import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/video_model.dart';

class VideoSideActions extends StatelessWidget {
  final VideoModel video;

  const VideoSideActions({
    Key? key,
    required this.video,
  }) : super(key: key);

  // Fonction pour formater les nombres (ex: 12500 -> 12.5K)
  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Avatar de l'utilisateur
        _buildProfileAvatar(),
        const SizedBox(height: 20),
        
        // Bouton Like
        _buildActionButton(
          icon: Icons.favorite,
          label: _formatNumber(video.likes),
        ),
        const SizedBox(height: 15),
        
        // Bouton Commentaires
        _buildActionButton(
          icon: FontAwesomeIcons.comment,
          label: _formatNumber(video.comments),
        ),
        const SizedBox(height: 15),
        
        // Bouton Partage
        _buildActionButton(
          icon: FontAwesomeIcons.share,
          label: _formatNumber(video.shares),
        ),
        const SizedBox(height: 15),
        
        // Disque rotatif (simulant le disque de musique TikTok)
        _buildMusicDisc(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildProfileAvatar() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: video.profileImageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(color: Colors.white),
              errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          bottom: -5,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add,
              size: 15,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({required IconData icon, required String label}) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildMusicDisc() {
    return Container(
      width: 45,
      height: 45,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: ClipOval(
        child: Image.network(
          video.profileImageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
