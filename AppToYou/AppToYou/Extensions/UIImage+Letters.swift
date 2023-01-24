//
//  UIImage+Letters.swift
//  AppToYou
//
//  Created by Philip Bratov on 22.07.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

extension UIImage {

    convenience init?(imageName: String) {
        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let filePath = docDir.appendingPathComponent(imageName);

        guard FileManager.default.fileExists(atPath: filePath.path) else  {
           return nil
        }
        self.init(contentsOfFile: filePath.path)
    }
    
    public convenience init?(withLettersFromName name: String) {
        // getting first name and surname letters
        let words = name.split(separator: " ")
        var letters = ""
        let word = String(words.first ?? "")

        if let letter = word.first {
            letters.append(letter)
        }

        //drowing the image with letters and filled with associated color
        let scale = UIScreen.main.scale

        let gradientLayer = CAGradientLayer()

        let rect = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        gradientLayer.bounds = rect
        gradientLayer.startPoint = CGPoint(x: 1, y: -1)
        gradientLayer.colors = [R.color.backgroundTextFieldsColor()?.cgColor ?? UIColor.white.cgColor, R.color.backgroundTextFieldsColor()?.cgColor ?? UIColor.white.cgColor]
        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, false, scale)
        UIRectFill(rect)
        let context = UIGraphicsGetCurrentContext()
        gradientLayer.render(in: context!)

        let charLabel = UILabel()
        charLabel.frame.size = CGSize(width: 50.0, height: 50.0)
        charLabel.textColor = R.color.failureColor()
        charLabel.text = letters
        charLabel.textAlignment = .center
        charLabel.backgroundColor = .clear
        charLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)

        charLabel.drawText(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
