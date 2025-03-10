import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifb_loan/core/utils/url_utils.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:core/utils/url_utils.dart';

class PdfDialog extends StatefulWidget {
  final String pdfUrl;
  final String? token;
  final Function()? onAccept;
  final Function()? onReject;

  const PdfDialog(
      {super.key,
      required this.pdfUrl,
      this.onAccept,
      this.onReject,
      this.token});

  @override
  State<PdfDialog> createState() => _PdfDialogState();
}

class _PdfDialogState extends State<PdfDialog> {
  bool _isLoading = true;
  bool _isDownloading = false;
  @override
  void initState() {
    super.initState();
    print("widget.pdfUrl");
    final modifiedUrl = formatPdfUrl(widget.pdfUrl);
    print(modifiedUrl);
  }

  Future<void> _downloadPdf() async {
    try {
      setState(() {
        _isDownloading = true;
      });

      // Get the downloads directory
      Directory? downloadsDir;
      if (Platform.isAndroid) {
        downloadsDir = Directory('/storage/emulated/0/Download');
      } else if (Platform.isIOS) {
        final dir = await getApplicationDocumentsDirectory();
        downloadsDir = Directory('${dir.path}/Download');
      }

      if (downloadsDir == null) {
        throw Exception('Could not access downloads directory');
      }

      // Create ifb directory if it doesn't exist
      final ifbDir = Directory('${downloadsDir.path}/ifb');
      if (!await ifbDir.exists()) {
        await ifbDir.create(recursive: true);
      }

      // Create a filename from the URL and timestamp to avoid duplicates
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final originalFileName = widget.pdfUrl.split('/').last;
      final fileName = '${timestamp}_$originalFileName';
      final filePath = '${ifbDir.path}/$fileName';

      // Download the file
      final dio = Dio();
      await dio.download(
        formatPdfUrl(widget.pdfUrl),
        // widget.pdfUrl,
        filePath,
        options: Options(headers: {'Authorizaton': 'Bearer ${widget.token}'}),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = (received / total * 100).toStringAsFixed(0);
            debugPrint('Download progress: $progress%');
          }
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF saved'.tr),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to download PDF'.tr),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      // debugPrint('Error downloading PDF: $e');
    } finally {
      setState(() {
        _isDownloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  // PDF Viewer
                  SfPdfViewer.network(
                    formatPdfUrl(widget.pdfUrl),
                    // widget.pdfUrl,
                    onDocumentLoaded: (_) {
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    onDocumentLoadFailed: (_) {
                      setState(() {
                        _isLoading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to load PDF.".tr)),
                      );
                    },
                  ),
                  // Loading Indicator
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
            // Action Buttons
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _isDownloading ? null : _downloadPdf,
                    icon: _isDownloading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(Icons.download, size: 16),
                    label: Text(
                      _isDownloading ? '...' : '',
                      style: const TextStyle(fontSize: 12),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: widget.onReject,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    icon: const Icon(Icons.close, size: 16),
                    label: Text(
                      'Reject'.tr,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: widget.onAccept,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    icon: const Icon(Icons.check, size: 16),
                    label: Text(
                      'Accept'.tr,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> _showPdfDialog(BuildContext context, String pdfUrl) async {
  final modifiedUrl = formatPdfUrl(pdfUrl);
  print('Original URL: $pdfUrl');
  print('Modified URL: $modifiedUrl');

  final result = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return PdfDialog(
        pdfUrl: modifiedUrl,
        onAccept: () {
          Navigator.pop(context, true);
        },
        onReject: () {
          Navigator.pop(context, false);
        },
      );
    },
  );

  return result ?? false;
}
