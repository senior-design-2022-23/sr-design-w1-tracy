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
      exposure: .5,
      autoRotate: true,
      cameraControls: true,
      // disableTap: true,
      disablePan: true,
      autoRotateDelay: 500,
      onWebViewCreated: (WebViewController controller) {
        _controller = controller;
      },
      innerModelViewerHtml: generateModelViewerScript(
          getHotSpot("assets/models/Post_Tramatic.glb")),
      relatedJs: """
            const modelViewer = document.querySelector('#MainViewer');
            
            function setSrc(assetPath) {
              modelViewer.src = assetPath;
            }

            const lines = modelViewer.querySelectorAll('line');
            let baseRect;
            let hotspotsRect;
            
            function onResize(){
              baseRect = modelViewer.getBoundingClientRect();
              hotspotsRect = document.querySelector('#hotspots').getBoundingClientRect();
            }

            modelViewer.addEventListener('load', () => {
              onResize();
              // update svg
              function drawLine(svgLine, name) {
                const hotspot = modelViewer.queryHotspot('hotspot-' + name);
                svgLine.setAttribute('x1', hotspot.canvasPosition.x);
                svgLine.setAttribute('y1', hotspot.canvasPosition.y);
                svgLine.setAttribute('x2', (hotspotsRect.left + hotspotsRect.right) / 2 - baseRect.left);
                svgLine.setAttribute('y2', hotspotsRect.top - baseRect.top);
              }

              // use requestAnimationFrame to update with renderer
              const startSVGRenderLoop = () => {
                drawLine(lines[0], '1');
                requestAnimationFrame(startSVGRenderLoop);
              };

              startSVGRenderLoop();
            });
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

  List<Map<String, String>> getHotSpot(String model) {
    var hotspots = <Map<String, String>>[];
    switch (model) {
      case 'assets/models/Post_Tramatic.glb':
        return [
          {
            "name": "1",
            "dataPosition":
                "0.0020184038193305177m 0.11406095620031625m 0.11953454203314201m"
          }
        ];
      default:
        return hotspots;
    }
  }

  String generateModelViewerScript(List<Map<String, String>> hotspots) {
    var anchorTags = hotspots.map((hotspot) {
      return '<div slot="${hotspot['name']}" class="anchor" data-position="${hotspot['dataPosition']}"></div>';
    }).join();

    var lines =
        List.generate(hotspots.length, (index) => '<line class="line"></line>')
            .join();

    var drawLines = hotspots.asMap().entries.map((entry) {
      var index = entry.key;
      var hotspot = entry.value;
      return 'drawLine(lines[$index], \'${hotspot['name']}\');';
    }).join();

    return '''
      $anchorTags
      <svg id="lines" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" class="lineContainer">
        $lines
      </svg>
      <div id="container">
        <button id="hotspots" class="label">Hotspots</button>
      </div>
      ''';
  }
}
