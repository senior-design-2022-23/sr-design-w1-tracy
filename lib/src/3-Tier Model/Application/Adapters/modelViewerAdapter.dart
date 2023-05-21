import 'dart:io';

import 'package:flutter/material.dart';
import "package:webview_flutter/webview_flutter.dart";
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'dart:ui' as ui;

final List<String> models = [
  'assets/models/human_head.glb',
  'assets/models/tension.glb',
  'assets/models/Cluster.glb',
  'assets/models/Migraine.glb',
  'assets/models/Post_Tramatic.glb'
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
      skyboxImage: "assets/images/Background.png",
      alt: "Base Head",
      exposure: 1,
      autoRotate: true,
      cameraControls: true,
      // disableTap: true,
      disablePan: true,
      autoRotateDelay: 500,
      onWebViewCreated: (WebViewController controller) {
        _controller = controller;
      },
      relatedJs: """
            const modelViewer = document.querySelector('#MainViewer');
            function setSrc(assetPath) {
              modelViewer.src = assetPath;
            }
            """,
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
