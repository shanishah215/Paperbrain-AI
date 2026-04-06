import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paperbrain/src/features/home/presentation/widgets/home_screen_widgets.dart';
import 'package:paperbrain/src/features/pdf_viewer/presentation/controllers/pdf_controller.dart';
import 'package:paperbrain/src/features/pdf_viewer/presentation/widgets/pdf_viewer_widget.dart';
import 'package:paperbrain/src/features/chatbot/presentation/screens/chat_bottom_sheet.dart';

class HomeScreen extends GetView<PDFController> {
  const HomeScreen({super.key});

  void _openChatSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ChatBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Obx(() {
        final isPDFLoaded = controller.status.value == PDFStatus.loaded;

        return Stack(
          children: [
            // Background Gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                ),
              ),
            ),
            
            // Decorative background elements
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF6366F1).withAlpha(38),
                ),
              ),
            ),

            SafeArea(
              child: Column(
                children: [
                  const AppBarWidget(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E293B).withAlpha(153),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.white.withAlpha(51),
                                width: 1,
                              ),
                            ),
                            child: _buildContent(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  _buildBottomActions(context, isPDFLoaded),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildContent() {
    switch (controller.status.value) {
      case PDFStatus.initial:
        return const PDFEmptyViewWidget();
      case PDFStatus.loading:
        return const PDFLoadingViewWidget();
      case PDFStatus.loaded:
        return PdfViewerWidget(
          pdfBytes: controller.pdfBytes.value!,
          fileName: controller.pdfPath.value,
        );
      case PDFStatus.error:
        return PDFErrorView(errorMessage: controller.errorMessage.value);
    }
  }

  Widget _buildBottomActions(BuildContext context, bool isPDFLoaded) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A).withAlpha(204),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        border: Border.all(color: Colors.white.withAlpha(12)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: isPDFLoaded ? 1 : 2,
            child: const SelectPDFButton(),
          ),
          if (isPDFLoaded) ...[
            const SizedBox(width: 16),
            Expanded(
              child: AskAIButton(onTap: () => _openChatSheet(context)),
            ),
          ],
        ],
      ),
    );
  }
}
