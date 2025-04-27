class VideoModel {
  final String id;
  final String username;
  final String caption;
  final String songName;
  final String videoUrl;
  final String profileImageUrl;
  final int likes;
  final int comments;
  final int shares;

  VideoModel({
    required this.id,
    required this.username,
    required this.caption,
    required this.songName,
    required this.videoUrl,
    required this.profileImageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
  });

  // Factory method to create a VideoModel from a map (for future API integration)
  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] as String,
      username: json['username'] as String,
      caption: json['caption'] as String,
      songName: json['songName'] as String,
      videoUrl: json['videoUrl'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      likes: json['likes'] as int,
      comments: json['comments'] as int,
      shares: json['shares'] as int,
    );
  }

  // Convert VideoModel to a map (for future API integration)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'caption': caption,
      'songName': songName,
      'videoUrl': videoUrl,
      'profileImageUrl': profileImageUrl,
      'likes': likes,
      'comments': comments,
      'shares': shares,
    };
  }
}
