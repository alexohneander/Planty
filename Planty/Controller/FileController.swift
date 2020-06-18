//
//  FileController.swift
//  Planty
//
//  Created by Alex Wellnitz on 17.06.20.
//  Copyright © 2020 Wellcom. All rights reserved.
//

import Foundation

public class FileController {
    
    public static func readPropertyList() -> [String:AnyObject]? {
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
        var plistData: [String: AnyObject] = [:] //Our data
        let plistPath: String? = Bundle.main.path(forResource: "Translation", ofType: "plist")! //the path of the data
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        do {
            ///convert the data to a dictionary and handle errors.
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:AnyObject]
            
            return plistData

        } catch {
            print("Error reading plist: \(error), format: \(propertyListFormat)")
            
            return nil
        }
    }
}
