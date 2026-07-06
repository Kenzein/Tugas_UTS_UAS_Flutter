import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final Widget page;
  const MenuItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = theme.cardColor;
    final borderColor = theme.dividerColor;
    final textColor =
        theme.textTheme.bodyMedium?.color ??
        (isDark ? Colors.white : const Color(0xFF1F3A4C));

    return LayoutBuilder(
      builder: (context, constraints) {
        final tileWidth = constraints.maxWidth;
        final iconCircleSize = (tileWidth * 0.54).clamp(58.0, 74.0);
        final imageSize = (iconCircleSize * 0.6).clamp(36.0, 44.0);

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => page));
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: tileWidth >= 124 ? 14 : 12,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: borderColor, width: 1.1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.28 : 0.08),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: iconCircleSize,
                    height: iconCircleSize,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFEEF6FF), Color(0xFFDCEFFF)],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF2F5274,
                          ).withValues(alpha: 0.12),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      imagePath,
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: tileWidth >= 124 ? 13.5 : 12.5,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
