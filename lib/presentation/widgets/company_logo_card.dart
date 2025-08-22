import 'package:flutter/material.dart';

class CompanyLogoCard extends StatelessWidget {
  final String imageUrl;
  final bool isAsset;

  const CompanyLogoCard({
    super.key,
    required this.imageUrl,
    this.isAsset = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 150,
        maxWidth: double.infinity,
      ),
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: isAsset
            ? Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // 이미지 로드 실패시 기본 아이콘 표시
                  return const Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                    size: 40,
                  );
                },
              )
            : Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // 이미지 로드 실패시 기본 아이콘 표시
                  return const Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                    size: 40,
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
