//
//  ViewController.swift
//  GradientFromImage
//
//  Created by Shawn Roller on 7/23/18.
//  Copyright © 2018 Shawn Roller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    private var imagePicker: UIImagePickerController?
    private var gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initialBackgroundColor = self.view.backgroundColor ?? UIColor.clear
        setInitialBackgroundGradient(to: [initialBackgroundColor.cgColor, initialBackgroundColor.cgColor])
    }
    
    @IBAction private func selectImage(sender: Any) {
        self.imagePicker = UIImagePickerController()
        self.imagePicker?.delegate = self
        guard self.imagePicker != nil else { return }
        present(self.imagePicker!, animated: true)
    }
    
}

// MARK: - Gradients
extension ViewController {
    
    private func setInitialBackgroundGradient(to colors: [CGColor]) {
        guard colors.count > 1 else { return }
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.colors = [colors[0], colors[1]]
        self.gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(self.gradientLayer, at: 0)
    }
    
    private func setBackgroundGradient(for image: UIImage) {
        let colors = getBackgroundGradient(for: image)
        guard let gradientColors = colors, gradientColors.count > 1 else { return }
        animateGradient(to: [gradientColors[0], gradientColors[1]], duration: 2.0)
    }
    
    private func getBackgroundGradient(for image: UIImage) -> [CGColor]? {
        guard let image = self.imageView.image else { return nil }
        let (firstColor, lastColor) = image.getGradientColors()
        return [firstColor.cgColor, lastColor.cgColor]
    }
    
    private func animateGradient(to colors: [CGColor], duration: TimeInterval) {
        guard colors.count >= 2 else { return }
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        let toColors = [colors[0], colors[1]]
        let fromColors = self.gradientLayer.colors ?? [UIColor.clear.cgColor, UIColor.clear.cgColor]
        gradientChangeAnimation.duration = duration
        gradientChangeAnimation.fromValue = fromColors
        gradientChangeAnimation.toValue = toColors
        gradientChangeAnimation.fillMode = kCAFillModeForwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        self.gradientLayer.colors = toColors
        self.gradientLayer.add(gradientChangeAnimation, forKey: "colorChange")
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        imageView.image = image
        dismiss(animated: true) {
            self.imagePicker = nil
            self.setBackgroundGradient(for: image)
        }
    }
    
}

