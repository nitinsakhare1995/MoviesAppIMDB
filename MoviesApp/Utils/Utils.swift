//
//  Utils.swift
//  MoviesApp
//
//  Created by Nitin Sakhare on 14/02/23.
//

import Foundation
import UIKit

struct Utils {
    
   static func loadJson(filename fileName: String) -> Data {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let dataObj = try Data(contentsOf: url)
                return dataObj
            } catch {
                print("error:\(error)")
            }
        }
        return Data()
    }
    
}

extension UIView {

    func activityStartAnimating(activityColor: UIColor, backgroundColor: UIColor) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 475647
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        
        backgroundView.addSubview(activityIndicator)

        self.addSubview(backgroundView)
    }

    func activityStopAnimating() {
        if let background = viewWithTag(475647){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
    
}
