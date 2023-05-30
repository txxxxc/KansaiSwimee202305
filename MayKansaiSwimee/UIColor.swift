//
//  UIColor.swift
//  MayKansaiSwimee
//
//  Created by Tomoya Tanaka on 2023/05/17.
//

import UIKit

extension UIColor {
    static func createYumekawaColor(_ hue: CGFloat) -> UIColor {
        return UIColor(hue: hue / CGFloat(ratio), saturation: 0.18, brightness: 1, alpha: 1.0)
    }

    static func invertedColor(from color: UIColor) -> UIColor? {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        if color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: (hue + 0.5).truncatingRemainder(dividingBy: 1.0), saturation: saturation, brightness: brightness, alpha: alpha)
        } else {
            // UIColorがHSB色空間でない場合はnilを返す
            return nil
        }
    }

}


func randomText() -> String {
    let array = ["🦄", "🌈", "👾", "👽", "🧚"]
    return array[Int.random(in: 0..<array.count)]
}
