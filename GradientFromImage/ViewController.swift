//
//  ViewController.swift
//  GradientFromImage
//
//  Created by Shawn Roller on 7/23/18.
//  Copyright © 2018 Shawn Roller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            setBackgroundGradient()
        }
    }
    fileprivate var imagePicker: UIImagePickerController?
    fileprivate var gradientLayer: CAGradientLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func selectImage(sender: Any) {
        self.imagePicker = UIImagePickerController()
        self.imagePicker?.delegate = self
        guard self.imagePicker != nil else { return }
        present(self.imagePicker!, animated: true)
    }
    
    private func setBackgroundGradient() {
        // TODO: animate the initial gradient
        // TODO: animate the background gradient to ranom positions
        guard let image = self.imageView.image else { return }
        guard self.gradientLayer == nil else { animateToGradient(); return }
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer = image.getGradient(frame: self.imageView.frame.size)
        self.gradientLayer!.frame = self.view.bounds
        self.view.layer.insertSublayer(self.gradientLayer!, at: 0)
    }
    
    private func animateToGradient() {
        guard let image = self.imageView.image else { return }
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 5.0
        let (firstColor, lastColor) = image.getGradientColors()
        gradientChangeAnimation.toValue = [firstColor.cgColor, lastColor.cgColor]
        gradientChangeAnimation.fillMode = kCAFillModeForwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        self.gradientLayer!.add(gradientChangeAnimation, forKey: "colorChange")
    }

}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        imageView.image = image
        dismiss(animated: true) {
            self.imagePicker = nil
            self.setBackgroundGradient()
        }
    }
    
}

