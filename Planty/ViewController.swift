//
//  ViewController.swift
//  Planty
//
//  Created by Alex Wellnitz on 16.06.20.
//  Copyright © 2020 Wellcom. All rights reserved.
//

import CoreML
import Vision
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var resultView: UIView!
    
    /// - Tag: MLModelSetup
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: PlantyModel().model)
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    /// Updates the UI with the results of the classification.
    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                print("Unable to classify image.\n\(error!.localizedDescription)")
                return
            }
            // The `results` will always be `VNClassificationObservation`s, as specified by the Core ML model in this project.
            let classifications = results as! [VNClassificationObservation]

            if classifications.isEmpty {
                print("Nothing recognized.")
            } else {
                
                
                 //Plant.getTranslatedList(classifications: classifications)
                
                // Display top classifications ranked by confidence in the UI.
                let topClassifications = classifications.prefix(2)
                let topResult = topClassifications.first!
                
                if topResult.confidence >= 0.85 {
                    let result = topClassifications.first!.identifier
                    self.resultLabel.text = result
                    
                    return
                }
                
                self.resultLabel.text = "Nothing recognized."
            }
        }
    }
    
    func updateClassifications(for image: UIImage) {
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))!
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }

        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }
    
    /// IBAction Photo Button
    @IBAction func didTapTakePictureButton(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        
        // if not real device use MediaLibrary
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            // PhotoLibrary
            imagePicker.sourceType = .photoLibrary
        } else {
            // Camera
            imagePicker.sourceType = .camera
        }
        
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else {
            return
        }

        imageView.image = image
        updateClassifications(for: image)
    }
}
