//
//  ScannerViewController.swift
//  Kosmos
//
//  Created by MAIN on 04.27.17.
//  Copyright © 2017 Zhao Tianai. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    var session: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        session = AVCaptureSession()
        
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        let inputDevice: AVCaptureDeviceInput?
        
        do {
            inputDevice = try AVCaptureDeviceInput(device: captureDevice)
        } catch {
            return
        }
        
        if session.canAddInput(inputDevice) {
            session.addInput(inputDevice)
        }
        
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session);
        previewLayer.frame = view.layer.bounds;
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        view.layer.addSublayer(previewLayer);
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        session.startRunning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        if let barcodeData = metadataObjects.first {
            // Turn it into machine readable code
            let barcodeReadable = barcodeData as? AVMetadataMachineReadableCodeObject;
            if let readableCode = barcodeReadable {
                // Send the barcode as a string to barcodeDetected()
//                barcodeDetected(readableCode.stringValue);
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))

                let alert = UIAlertController(title: "Found a Barcode!", message: readableCode.stringValue, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                self.present(alert, animated: true, completion: nil)

            }
            
            // Vibrate the device to give the user some feedback.
            
            // Avoid a very buzzy device.
//            session.stopRunning()
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
