//
//  CustomTabBar.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 27.07.24.
//

import UIKit

class CustomTabBar: UITabBar {

    private var shapeLayer: CALayer?

    override func draw(_ rect: CGRect) {
        addShape()
    }

    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor.systemGray.cgColor
        shapeLayer.lineWidth = 1.0
        
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowOpacity = 0.3
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }

    private func createPath() -> CGPath {
        let height: CGFloat = 20
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2

        path.move(to: CGPoint(x: 0, y: 0)) // start top left
        path.addLine(to: CGPoint(x: self.frame.width, y: 0)) // top right
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height + height)) // right down
        path.addLine(to: CGPoint(x: 0, y: self.frame.height + height)) // down left
        path.close()

        return path.cgPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
}
