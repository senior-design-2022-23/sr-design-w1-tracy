import "package:webview_flutter/webview_flutter.dart";
import 'package:model_viewer_plus/model_viewer_plus.dart';

final List<String> models = [
  'assets/models/human_head.glb',
  'assets/models/tension.glb'
];

class ModelViewerProxy {
  String currentAsset = models[0];
  late WebViewController _controller;
  late ModelViewer viewer;

  ModelViewer init() {
    viewer = createModelView(currentAsset);
    return viewer;
  }

  ModelViewer createModelView(String src) {
    return ModelViewer(
      id: "MainViewer",
      src: src,
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
  }

  void loadModel(int index) {
    index = index % models.length;
    currentAsset = models[index];
    viewer = createModelView(currentAsset);
    _controller.runJavaScript("""setSrc("$currentAsset");""");
  }

  String getModelName(int index) {
    index = index % models.length;
    currentAsset = models[index];
    currentAsset = currentAsset.split("/").last;
    return currentAsset;
  }
}
