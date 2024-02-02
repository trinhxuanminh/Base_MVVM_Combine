//
//  CameraManager.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import UIKit
import AVFoundation
import Combine

class CameraManager: NSObject {
  static let shared = CameraManager()
  
  enum CameraError: Error {
    case setup
    case position
  }
  
  @Published private(set) var captureImage: UIImage?
  @Published private(set) var flashState = false
  private let queue = DispatchQueue(label: "Capture")
  private var captureSession: AVCaptureSession?
  private var captureDevice: AVCaptureDevice?
  private var captureDeviceInput: AVCaptureDeviceInput?
  private var positionState: AVCaptureDevice.Position = .front
  private var currentBrightness = UIScreen.main.brightness
}

extension CameraManager {
  func start() {
    switch AVCaptureDevice.authorizationStatus(for: .video) {
    case .authorized:
      capture()
    case .notDetermined:
      request()
    default:
      denied()
    }
  }
  
  func switchPosition() {
    do {
      offFlash()
      self.positionState = positionState == .front ? .back : .front
      self.captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                   for: .video,
                                                   position: positionState)
      guard let captureDevice else {
        throw CameraError.position
      }
      let newCaptureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
      
      guard let captureSession else {
        throw CameraError.position
      }
      captureSession.beginConfiguration()
      if let captureDeviceInput {
        captureSession.removeInput(captureDeviceInput)
      }
      captureSession.addInput(newCaptureDeviceInput)
      captureSession.commitConfiguration()
      
      self.captureDeviceInput = newCaptureDeviceInput
      resetFlash()
    } catch let error {
      showError(error)
    }
  }
  
  func switchFlash() {
    self.flashState.toggle()
    resetFlash()
  }
  
  func stopCamera() {
    offFlash()
    self.flashState = false
    captureSession?.stopRunning()
    self.captureSession = nil
    self.captureDevice = nil
    self.captureDeviceInput = nil
  }
}

extension CameraManager {
  private func offFlash() {
    switch positionState {
    case .front:
      switchFrontFlash(state: false)
    case .back:
      switchBackFlash(state: false)
    default:
      return
    }
  }
  
  private func resetFlash() {
    switch positionState {
    case .front:
      switchFrontFlash(state: flashState)
    case .back:
      switchBackFlash(state: flashState)
    default:
      return
    }
  }
  
  private func switchFrontFlash(state: Bool) {
    switch state {
    case false:
      UIScreen.main.brightness = currentBrightness
    case true:
      self.currentBrightness = UIScreen.main.brightness
      UIScreen.main.brightness = 1.0
    }
  }
  
  private func switchBackFlash(state: Bool) {
    guard let captureDeviceInput else {
      return
    }
    let device = captureDeviceInput.device
    
    guard device.hasTorch, device.isTorchAvailable else {
      print("Can't turn on/off tourch!")
      return
    }
    
    do {
      try device.lockForConfiguration()
      device.torchMode = state ? .on : .off
      device.unlockForConfiguration()
    } catch {
      print("Something went wrong!")
    }
  }
  
  private func denied() {
    DispatchQueue.main.async {
      guard
        let topVC = UIApplication.topViewController(),
        let settingURL = URL(string: UIApplication.openSettingsURLString)
      else {
        return
      }
      let message = "The app needs access to the camera to function. Please grant camera access in the settings"
      let alert = UIAlertController(title: "Camera Access",
                                    message: message,
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Setting", style: .destructive, handler: { _ in
        UIApplication.shared.open(settingURL)
        topVC.navigationController?.pop(animated: false)
      }))
      alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
        topVC.navigationController?.pop(animated: false)
      }))
      topVC.present(alert, animated: true)
    }
  }
  
  private func request() {
    App.shared.setShowAppOpen(allow: false)
    AVCaptureDevice.requestAccess(for: .video) { [weak self] status in
      guard let self = self else {
        return
      }
      switch status {
      case true:
        capture()
      default:
        denied()
      }
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
        App.shared.setShowAppOpen(allow: true)
      })
    }
  }
  
  private func showError(_ error: Error) {
    switch error {
    case CameraError.setup:
      DispatchQueue.main.async {
        guard let topVC = UIApplication.topViewController() else {
          return
        }
        let message = "Unable to start using the camera. Try later"
        let alert = UIAlertController(title: "Camera Error",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak self] _ in
          guard let self else {
            return
          }
          stopCamera()
          topVC.navigationController?.pop(animated: false)
        }))
        topVC.present(alert, animated: true)
      }
    default:
      return
    }
  }
  
  private func capture() {
    do {
      self.captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                   for: .video,
                                                   position: positionState)
      guard let captureDevice else {
        throw CameraError.setup
      }
      
      self.captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
      guard let captureDeviceInput else {
        throw CameraError.setup
      }
      
      self.captureSession = AVCaptureSession()
      guard let captureSession else {
        throw CameraError.setup
      }
      captureSession.addInput(captureDeviceInput)
      captureSession.sessionPreset = .hd1920x1080
      
      let captureVideoDataOutput = AVCaptureVideoDataOutput()
      captureSession.addOutput(captureVideoDataOutput)
      captureVideoDataOutput.setSampleBufferDelegate(self, queue: queue)
      
      DispatchQueue.global(qos: .userInitiated).async {
        captureSession.startRunning()
      }
    } catch let error {
      showError(error)
    }
  }
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate, AVCapturePhotoCaptureDelegate {
  func fileOutput(_ output: AVCaptureFileOutput,
                  didStartRecordingTo fileURL: URL,
                  from connections: [AVCaptureConnection]
  ) {}
  
  func captureOutput(_ output: AVCaptureOutput,
                     didOutput sampleBuffer: CMSampleBuffer,
                     from connection: AVCaptureConnection
  ) {
    guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
      return
    }
    guard let captureDevice else {
      return
    }
    let orientation: CGImagePropertyOrientation = captureDevice.position == .front ? .leftMirrored : .right
    let ciImage = CIImage(cvPixelBuffer: pixelBuffer).oriented(orientation)
    self.captureImage = UIImage(ciImage: ciImage)
  }
}
