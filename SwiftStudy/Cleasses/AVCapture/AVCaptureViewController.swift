//
//  AVCaptureViewController.swift
//  Swift4
//
//  Created by ZhangChunPeng on 2018/1/30.
//  Copyright © 2018年 zhcpeng. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMedia
import CoreVideo

class AVCaptureViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    private let captureSession: AVCaptureSession = AVCaptureSession()
    private let output: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private let previewView: UIView = UIView()


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        captureSession.startRunning()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        captureSession.stopRunning()
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        previewView.clipsToBounds = true
        view.addSubview(previewView)
        previewView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(300)
        }
        setupCamera()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupCamera() {
        guard let device = AVCaptureDevice.default(for: .video),
            let input = try? AVCaptureDeviceInput(device: device) else {
                return
        }

        if captureSession.canAddInput(input) {
            captureSession.addInput(input)
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        previewView.layer.addSublayer(previewLayer)

//        captureSession.startRunning()


    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {

    }

}

