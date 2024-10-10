//
//  PhotoModelFileManager.swift
//  MiniApiApp
//
//  Created by Oğuzhan Abuhanoğlu on 10.10.2024.
//
import Foundation
import SwiftUI

class PhotoModelFileManager {
    
    static let instance = PhotoModelFileManager()
    let folderName: String = "downloaded_images"
    
    private init() {
        createFolderIfNeeded()
    }
    
    private func getFolderPath() -> URL? {
        let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
        
        return path
    }
    
    private func createFolderIfNeeded() {
        guard let url = getFolderPath() else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                print("Successfully created folder")
            } catch let error {
                print("Error Creating Folder: \(error)")
            }
        }
    }
    
    func getImagePath(key: String) -> URL? {
        guard let folder = getFolderPath() else { return nil }
        return folder.appendingPathComponent(key + ".png")
    }
    
    func add(key: String, value: UIImage) {
        guard let data = value.pngData(),
              let url = getImagePath(key: key) else { return }
        
        do {
            try data.write(to: url)
            print("Successfully saved image")
        } catch let error {
            print("Error Saving Image: \(error)")
        }
    }
    
    func get(key: String) -> UIImage? {
        guard
            let url = getImagePath(key: key),
            FileManager.default.fileExists(atPath: url.path) else { return nil }
        
        return UIImage(contentsOfFile: url.path)
    }
}
