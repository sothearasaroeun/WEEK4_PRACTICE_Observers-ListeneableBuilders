import 'package:flutter/material.dart';
import 'download_controler.dart';
import '../../../theme/theme.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        IconData iconData;
        Color iconColor = AppColors.neutral;
        String progressText;

        if (controller.status == DownloadStatus.downloaded) {
          iconData = Icons.folder;
          progressText =
              '100.0 % completed - ${controller.ressource.size}.0 of ${controller.ressource.size} MB';
        } else if (controller.status == DownloadStatus.downloading) {
          iconData = Icons.downloading;
          progressText =
              '${(controller.progress * 100).toStringAsFixed(1)} % completed - ${(controller.ressource.size * controller.progress).toStringAsFixed(1)} of ${controller.ressource.size} MB';
        } else {
          iconData = Icons.arrow_downward_rounded;
          progressText =
              '0.0 % completed - 0.0 of ${controller.ressource.size} MB';
        }

        Widget iconArea;
        if (controller.status == DownloadStatus.notDownloaded) {
          iconArea = IconButton(
            icon: Icon(iconData, color: iconColor, size: 28),
            onPressed: controller.startDownload,
            padding: EdgeInsets.zero,
          );
        } else {
          iconArea = Icon(iconData, color: iconColor, size: 28);
        }

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.ressource.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.neutralDark,
                    ),
                  ),

                  Text(
                    progressText,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.neutralLight,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              iconArea,
            ],
          ),
        );
      },
    );
  }
}
