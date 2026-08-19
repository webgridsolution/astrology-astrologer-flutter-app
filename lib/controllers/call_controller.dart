import 'dart:async';
import 'package:flutter/material.dart';

enum CallKind { audio, video }
enum CallPhase { idle, incoming, calling, connecting, connected, ended }

class CallController extends ChangeNotifier {
  CallKind kind = CallKind.audio;
  CallPhase phase = CallPhase.idle;
  String clientId = 'c1';
  String clientName = 'Aman Verma';
  String clientImage = 'assets/images/aman.png';
  int seconds = 0;
  bool muted = false;
  bool speaker = false;
  bool cameraOn = true;
  Timer? _timer;

  void startOutgoing({
    required CallKind kind,
    required String clientId,
    required String clientName,
    required String clientImage,
  }) {
    this.kind = kind;
    this.clientId = clientId;
    this.clientName = clientName;
    this.clientImage = clientImage;
    phase = CallPhase.calling;
    seconds = 0;
    muted = false;
    speaker = false;
    cameraOn = true;
    notifyListeners();
    Future.delayed(const Duration(seconds: 2), () {
      if (phase == CallPhase.calling) {
        phase = CallPhase.connecting;
        notifyListeners();
      }
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (phase == CallPhase.connecting || phase == CallPhase.calling) {
        connect();
      }
    });
  }

  void startIncoming({
    required CallKind kind,
    required String clientId,
    required String clientName,
    required String clientImage,
  }) {
    this.kind = kind;
    this.clientId = clientId;
    this.clientName = clientName;
    this.clientImage = clientImage;
    phase = CallPhase.incoming;
    seconds = 0;
    notifyListeners();
  }

  void accept() {
    phase = CallPhase.connecting;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 800), connect);
  }

  void connect() {
    phase = CallPhase.connected;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      seconds++;
      notifyListeners();
    });
    notifyListeners();
  }

  void decline() {
    end();
  }

  void end() {
    _timer?.cancel();
    phase = CallPhase.ended;
    notifyListeners();
  }

  void toggleMute() {
    muted = !muted;
    notifyListeners();
  }

  void toggleSpeaker() {
    speaker = !speaker;
    notifyListeners();
  }

  void toggleCamera() {
    cameraOn = !cameraOn;
    notifyListeners();
  }

  String get timerLabel {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
