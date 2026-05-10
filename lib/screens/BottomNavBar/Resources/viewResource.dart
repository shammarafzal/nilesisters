import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_plus/share_plus.dart';
import 'package:nilesisters/Settings/ngo_ui.dart';

class PDFScreen extends StatefulWidget {
  final String path;

  const PDFScreen({super.key, required this.path});

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller = Completer<PDFViewController>();
  int pages = 0;
  int currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NgoPalette.sky,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 74,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        flexibleSpace: Container(decoration: const BoxDecoration(gradient: NgoPalette.heroGradient)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Document Viewer', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
            if (isReady)
              Text(
                'Page ${currentPage + 1} of $pages',
                style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.8), fontWeight: FontWeight.w500),
              ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: const Icon(Icons.share_rounded),
              onPressed: () {
                final box = context.findRenderObject() as RenderBox?;
                if (box != null) {
                  Share.shareXFiles(
                    [XFile(widget.path)],
                    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
                  );
                }
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                    )
                  ],
                ),
                child: PDFView(
                  filePath: widget.path,
                  enableSwipe: true,
                  swipeHorizontal: false,
                  autoSpacing: true,
                  pageFling: true,
                  pageSnap: true,
                  defaultPage: currentPage,
                  fitPolicy: FitPolicy.BOTH,
                  onRender: (int? _pages) {
                    setState(() {
                      pages = _pages ?? 0;
                      isReady = true;
                    });
                  },
                  onError: (error) {
                    setState(() {
                      errorMessage = error.toString();
                    });
                  },
                  onPageError: (page, error) {
                    setState(() {
                      errorMessage = '$page: ${error.toString()}';
                    });
                  },
                  onViewCreated: (PDFViewController pdfViewController) {
                    _controller.complete(pdfViewController);
                  },
                  onPageChanged: (int? page, int? total) {
                    setState(() {
                      currentPage = page ?? currentPage;
                    });
                  },
                ),
              ),
            ),
          ),
          if (errorMessage.isNotEmpty)
            Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline_rounded, color: Colors.red, size: 48),
                    const SizedBox(height: 16),
                    Text(errorMessage, textAlign: TextAlign.center, style: const TextStyle(color: NgoPalette.ink)),
                  ],
                ),
              ),
            )
          else if (!isReady)
            const Center(
              child: CircularProgressIndicator(color: NgoPalette.primary),
            ),
        ],
      ),
      floatingActionButton: isReady
          ? FloatingActionButton.extended(
              onPressed: () {
                final box = context.findRenderObject() as RenderBox?;
                if (box != null) {
                  Share.shareXFiles(
                    [XFile(widget.path)],
                    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
                  );
                }
              },
              backgroundColor: NgoPalette.primary,
              icon: const Icon(Icons.share_rounded, color: Colors.white),
              label: const Text('Share Document', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
            )
          : null,
    );
  }
}
