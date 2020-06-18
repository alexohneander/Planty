//
//  Plant.swift
//  Planty
//
//  Created by Alex Wellnitz on 17.06.20.
//  Copyright © 2020 Wellcom. All rights reserved.
//

import Foundation
import CoreML
import Vision

public class Plant{
    
    //MARK: Properties
    var name: String
    var description: String?
    var id: String
    
    
    //MARK: Initialization
    init?(name: String, description: String?, id: String) {
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || id.isEmpty {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.description = description
        self.id = id
    }
    
   static func getTranslatedList(classifications: [VNClassificationObservation]) {
        
        var classificationDict = Dictionary<String, AnyObject>()
        let translationList = FileController.readPropertyList()
        
        for classification in classifications {
            let translatedClassification = translationList?.lazy.filter{ c in c.key == classification.identifier}.first
            
            classificationDict[classification.identifier] = translatedClassification as AnyObject?
        }
        
        print(classificationDict)
    }
}
