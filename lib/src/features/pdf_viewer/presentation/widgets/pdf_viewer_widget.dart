import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

class PdfViewerWidget extends StatefulWidget {
  final Uint8List pdfBytes;
  final String? fileName;

  const PdfViewerWidget({
    super.key,
    required this.pdfBytes,
    this.fileName,
  });

  @override
  State<PdfViewerWidget> createState() => _PdfViewerWidgetState();
}

class _PdfViewerWidgetState extends State<PdfViewerWidget> {
  final PdfViewerController _pdfViewerController = PdfViewerController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Generate a key based on bytes hash to force a re-load if the same bytes are re-uploaded
    final hashCode = widget.pdfBytes.length + (widget.fileName?.hashCode ?? 0);

    return Container(
      color: const Color(0xFFF1F5F9),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: PdfViewer.data(
            widget.pdfBytes,
            sourceName: widget.fileName ?? 'document.pdf',
            key: ValueKey('pdf_viewer_$hashCode'),
            controller: _pdfViewerController,
            params: PdfViewerParams(
              maxScale: 5.0,
              scrollPhysics: const BouncingScrollPhysics(),
              errorBannerBuilder: (context, error, stackTrace, documentRef) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
                      const SizedBox(height: 16),
                      Text(
                        'Failed to load PDF\n$error',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
