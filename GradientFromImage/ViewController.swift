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
        guard let image = self.imageView.image else { return }
        let gradient = image.getGradient(frame: self.imageView.frame.size)
        gradient.frame = self.view.bounds
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
//    private func animateToGradient() {
//        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
//        gradientChangeAnimation.duration = 5.0
//        gradientChangeAnimation.toValue = [
//            UIColor(red: 244/255, green: 88/255, blue: 53/255, alpha: 1).cgColor,
//            UIColor(red: 196/255, green: 70/255, blue: 107/255, alpha: 1).cgColor
//        ]
//        gradientChangeAnimation.fillMode = kCAFillModeForwards
//        gradientChangeAnimation.isRemovedOnCompletion = false
//        gradient.add(gradientChangeAnimation, forKey: "colorChange")
//    }

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

