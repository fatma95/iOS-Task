//
//  UIImageView+Extension.swift
//  BooksLibrary
//
//  Created by Fatma Mohamed on 17/09/2021.
//

import Foundation
import UIKit

enum ImageSize: String {
    case s = "S"
    case m = "M"
    case l = "L"
}


let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    
    
    func
    loadImage(endPoint: URL?) {
        guard let url = endPoint else { return }
                image = nil
        
        if let cachedImage = imageCache.object(forKey: endPoint as AnyObject) {
            image = cachedImage as? UIImage
            return
        }
        APIService().downloadimage(url: url, completion: { [weak self] result, error in
            guard let self = self else { return }
            guard let data = result  else  {
                DispatchQueue.main.async {
                    self.image = UIImage(named: "none")
                }
                return
            }
            guard let imageToCache = UIImage(data: data) else { return }
            imageCache.setObject(imageToCache, forKey: endPoint as AnyObject)
            self.image = UIImage(data: data)
        })
         
    }
}
