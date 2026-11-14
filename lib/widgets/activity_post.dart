
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ActivityPost extends StatefulWidget {
  final String title;
  final String employeeName;
  final bool isTime;
  final ValueChanged<bool>? onPhotoChanged;

  const ActivityPost({
    super.key,
    required this.title,
    required this.employeeName,
    this.isTime = false,
    this.onPhotoChanged,
  });

  @override
  State<ActivityPost> createState() => _ActivityPostState();
}

class _ActivityPostState extends State<ActivityPost> {
  Uint8List? photoBytes;
  TimeOfDay? selectedTime;
  bool loading = true;

  String get photoKey => 'photo_${widget.title}';

  @override
  void initState() {
    super.initState();
    loadSavedPhoto();
  }

  Future<void> loadSavedPhoto() async {
    if (widget.isTime) {
      if (mounted) {
        setState(() => loading = false);
      }
      return;
    }

    try {
      final box = Hive.box<String>('archon_photos');
      final savedPhoto = box.get(photoKey);

      if (savedPhoto != null) {
        photoBytes = base64Decode(savedPhoto);
      }
    } catch (e) {
      debugPrint('Photo loading error: $e');
    } finally {
      if (mounted) {
        setState(() => loading = false);
        widget.onPhotoChanged?.call(photoBytes != null);
      }
    }
  }

  Future<void> uploadPhoto() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 1200,
      );

      if (image == null) return;

      final bytes = await image.readAsBytes();

      final box = Hive.box<String>('archon_photos');

      await box.put(photoKey, base64Encode(bytes));

      if (!mounted) return;

      setState(() {
        photoBytes = bytes;
      });

      widget.onPhotoChanged?.call(true);
    } catch (e) {
      debugPrint('Photo upload error: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Photo upload failed')),
        );
      }
    }
  }

  Future<void> deletePhoto() async {
    try {
      final box = Hive.box<String>('archon_photos');
      await box.delete(photoKey);

      if (!mounted) return;

      setState(() {
        photoBytes = null;
      });

      widget.onPhotoChanged?.call(false);
    } catch (e) {
      debugPrint('Photo delete error: $e');
    }
  }

  Future<void> selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (time != null && mounted) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.employeeName,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 15),

            if (widget.isTime) ...[
              OutlinedButton.icon(
                onPressed: selectTime,
                icon: const Icon(Icons.access_time),
                label: const Text('Select Time'),
              ),
              if (selectedTime != null)
                Text(
                  'Selected Time: ${selectedTime!.format(context)}',
                ),
            ] else if (loading) ...[
              const Center(
                child: CircularProgressIndicator(),
              ),
            ] else ...[
              if (photoBytes != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.memory(
                    photoBytes!,
                    width: double.infinity,
                    height: 230,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text('Unable to display this photo');
                    },
                  ),
                ),
                const SizedBox(height: 12),
              ],

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: uploadPhoto,
                      icon: Icon(
                        photoBytes == null
                            ? Icons.add_a_photo
                            : Icons.edit,
                      ),
                      label: Text(
                        photoBytes == null
                            ? 'Upload Photo'
                            : 'Change Photo',
                      ),
                    ),
                  ),
                  if (photoBytes != null) ...[
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: deletePhoto,
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
