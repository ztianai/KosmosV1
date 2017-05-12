//
//  ScannerViewController.swift
//  Kosmos
//
//  Created by MAIN on 04.27.17.
//  Copyright © 2017 Zhao Tianai. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseDatabase

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    var session: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var ref: FIRDatabaseReference?
    var scannedItem = [String]()
    
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
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                
                processCode(barcode: readableCode.stringValue)
                
//                let alert = UIAlertController(title: "Found a Barcode!", message: readableCode.stringValue, preferredStyle: UIAlertControllerStyle.alert)
//                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
//                self.present(alert, animated: true, completion: nil)

            }
            
            session.stopRunning()
        }
    }
    
    func processCode(barcode: String) {
        let barcodeInt = Int(barcode)
        ref = FIRDatabase.database().reference()
        print("scanned")
        ref?.child("Products").queryOrdered(byChild: "barcode").queryEqual(toValue: barcodeInt).observe(FIRDataEventType.value, with: { (snapshot) in
            if snapshot.hasChildren() {
                print("found a match!")
                for snap in snapshot.children {
                    let snapDataSnapshot = snap as! FIRDataSnapshot
                    let snapValues = snapDataSnapshot.value as? [String: AnyObject]
                    let brandValue = snapValues?["brand"]
                    let nameValue = snapValues?["name"]
                    let typeValue = snapValues?["type"]
                    self.scannedItem.append(brandValue as! String)
                    self.scannedItem.append(nameValue as! String)
                    self.scannedItem.append(typeValue as! String)
                    self.performSegue(withIdentifier: "scannerToAddItem", sender: nil)
                }
            } else {
                print("product not found")
                let alert = UIAlertController(title: "Item not found", message: "The item scanned was not found in our database, please try again?????", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in self.restartSessions()}))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    func restartSessions() {
        self.session.startRunning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "scannerToAddItem" {
//            let navigationController = segue.destination as! UINavigationController
//            let destinationVC = navigationController.topViewController as! AddItemViewController
            let destinationVC = segue.destination as! AddItemViewController
            destinationVC.itemInfo = self.scannedItem
        }
    }

}



















