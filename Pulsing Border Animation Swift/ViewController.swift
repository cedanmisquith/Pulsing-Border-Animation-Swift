//
//  ViewController.swift
//  Pulsing Border Animation Swift
//
//  Created by Cedan Misquith on 14/10/22.
//

import UIKit

enum Orientation {
    case TOP
    case BOTTOM
    case LEFT
    case RIGHT
}
class ViewController: UIViewController {

    @IBOutlet weak var bottomView: UIImageView!
    @IBOutlet weak var topView: UIImageView!
    @IBOutlet weak var leftView: UIImageView!
    @IBOutlet weak var rightView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black // Set view background to black
        
        // Set up the views with their gradients
        topView.image = getGradientImage(frame: topView.bounds, orientation: .TOP)
        bottomView.image = getGradientImage(frame: bottomView.bounds, orientation: .BOTTOM)
        leftView.image = getGradientImage(frame: leftView.bounds, orientation: .LEFT)
        rightView.image = getGradientImage(frame: rightView.bounds, orientation: .RIGHT)
        
        // Start the animation
        fadeOut()
    }
    
    // Fade out animation
    func fadeOut() {
        UIView.animate(withDuration: 1, delay: 1, options: .curveEaseIn) {
            self.topView.alpha = 0
            self.bottomView.alpha = 0
            self.leftView.alpha = 0
            self.rightView.alpha = 0
        } completion: { completed in
            if completed {
                self.fadeIn()
            }
        }
    }
    
    // Fade in animation
    func fadeIn() {
        UIView.animate(withDuration: 1, delay: 1, options: .curveEaseOut) {
            self.topView.alpha = 1
            self.bottomView.alpha = 1
            self.leftView.alpha = 1
            self.rightView.alpha = 1
        } completion: { completed in
            if completed {
                self.fadeOut()
            }
        }
    }
    
    // Create a UIImage from the specific gradient
    func getGradientImage(frame: CGRect, orientation: Orientation) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        
        switch orientation {
        case .TOP:
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.red.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        case .BOTTOM:
            gradientLayer.colors = [UIColor.red.cgColor, UIColor.clear.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        case .LEFT:
            gradientLayer.colors = [UIColor.red.cgColor, UIColor.clear.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        case .RIGHT:
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.red.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        let gradientImage = gradientLayer.toImage()
        return gradientImage
    }
}

// Extension to convert a gradient to an image
extension CAGradientLayer {
    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0)
        self.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage ?? UIImage()
    }
}
