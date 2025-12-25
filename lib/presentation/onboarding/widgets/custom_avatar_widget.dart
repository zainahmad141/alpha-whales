import 'package:flutter/material.dart';

class OverlappingAvatars extends StatelessWidget {
  final List<String> imageUrls;
  final double avatarSize;
  final double overlapFactor;
  final Color borderColor;
  final double borderWidth;
  final int? maxAvatars;
  final TextStyle? counterTextStyle;

  const OverlappingAvatars({
    super.key,
    required this.imageUrls,
    this.avatarSize = 79.0,
    this.overlapFactor = 0.7,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0.3,
    this.maxAvatars,
    this.counterTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) return const SizedBox.shrink();

    final int displayCount = maxAvatars != null
        ? (maxAvatars! < imageUrls.length ? maxAvatars! - 1 : imageUrls.length)
        : imageUrls.length;

    final int remainingCount = maxAvatars != null && imageUrls.length > maxAvatars!
        ? imageUrls.length - maxAvatars! + 1
        : 0;

    final double spacing = avatarSize * overlapFactor;
    final double totalWidth = (displayCount - 1) * spacing + avatarSize +
        (remainingCount > 0 ? spacing : 0);

    return SizedBox(
      width: totalWidth,
      height: avatarSize,
      child: Stack(
        children: [
          // Display avatars
          for (int i = 0; i < displayCount; i++)
            Positioned(
              left: i * spacing,
              child: _buildAvatar(imageUrls[i]),
            ),
          if (remainingCount > 0)
            Positioned(
              left: displayCount * spacing,
              child: _buildCounterAvatar(remainingCount),
            ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String imageUrl) {
    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: ClipOval(
        child: imageUrl.startsWith('http')
            ? Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildPlaceholderAvatar();
          },
        )
            : Image.asset(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildPlaceholderAvatar();
          },
        ),
      ),
    );
  }

  Widget _buildCounterAvatar(int count) {
    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: Center(
        child: Text(
          '+$count',
          style: counterTextStyle ??
              TextStyle(
                fontSize: avatarSize * 0.25,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderAvatar() {
    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
      ),
      child: Icon(
        Icons.person,
        size: avatarSize * 0.6,
        color: Colors.grey[600],
      ),
    );
  }
}
