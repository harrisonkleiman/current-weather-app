//
//  Extensions.swift
//  CurrentWeatherApp
//
//  Created by Ivan Ramirez on 2/3/22.
//

import UIKit

extension UIView {

    /**
     An extension on UIView that renders a gradient on a UIViewController

     - Parameter topColor: Top color for gradient
     - Parameter bottomColor: Bottom color for gradient
     */
    func addVerticalGradientLayer() {

        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [



            UIColor(red: 55/255, green: 179/255, blue: 198/255, alpha: 1.0).cgColor,

            UIColor(red: 154/255, green: 213/255, blue: 214/255, alpha: 1.0).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 20)
        self.layer.insertSublayer(gradient, at: 0)
    }

}
