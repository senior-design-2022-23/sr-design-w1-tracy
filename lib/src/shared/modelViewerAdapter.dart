import "package:webview_flutter/webview_flutter.dart";
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ModelViewerProxy {
  List<String> models = [
    'assets/models/human_head.glb',
    'assets/models/tension.glb'
  ];
  String currentAsset = 'assets/models/human_head.glb';
  late WebViewController _controller;
  late ModelViewer viewer;

  ModelViewer createModelView() {
    viewer = ModelViewer(
      id: "MainViewer",
      src: currentAsset,
      alt: "Base Head",
      autoRotate: true,
      cameraControls: true,
      // disableTap: true,
      disablePan: true,
      autoRotateDelay: 500,
      onWebViewCreated: (WebViewController controller) {
        _controller = controller;
      },
      relatedJs: """
            function setSrc(assetPath) {
              const modelViewer = document.querySelector('#MainViewer');
              modelViewer.src = assetPath;
            }""",
    );
    return viewer;
  }

  void prevModel() {
    var index = models.indexOf(currentAsset) - 1;
    index = index ~/ models.length;
    var nextModel = models[index];
    _controller.runJavaScript("""setSrc("$nextModel");""");
  }

  void nextModel() {
    var index = models.indexOf(currentAsset) + 1;
    index = index ~/ models.length;
    var nextModel = models[index];
    _controller.runJavaScript("""setSrc("$nextModel");""");
  }
}
