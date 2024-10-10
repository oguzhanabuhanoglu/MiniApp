//
//  PhotoModelCacheManager.swift
//  MiniApiApp
//
//  Created by Oğuzhan Abuhanoğlu on 10.10.2024.
//

import Foundation
import SwiftUI

class PhotoModelCacheManager {
    
    static let instance = PhotoModelCacheManager()
    private init() {}
    
    var cache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
   
    func add(key: String, value: UIImage) {
        cache.setObject(value, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
    
}
