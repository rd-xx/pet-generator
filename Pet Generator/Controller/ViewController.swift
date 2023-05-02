//
//  ViewController.swift
//  Pet Generator
//
//  Created by Vitor Sousa on 01/05/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var spinnerView: UIView! {
        didSet {
            spinnerView.layer.cornerRadius = 4
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 20
            containerView.layer.shadowRadius = 4
            containerView.layer.shadowOffset = CGSize(width: 0, height: -4)
        }
    }
    
    @IBOutlet weak var likeCounterLabel: UILabel!
    @IBOutlet weak var likeButton: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUser()
        
    }

    private func setupUser() {
        self.showSpinner()
        
        APIHelper.shared.generatePet(pet: .dog) { pet in
            self.updatePhoto(url: pet.photoUrl)
            
            print(pet)
        }
    }
    
    private func updatePhoto(url: URL) {
        ImageDownloader.shared.fromUrl(url: url) { data in
            self.backgroundImage.image = data == nil ? UIImage(systemName: "person.circle.fill") : UIImage(data: data!)
            
            DispatchQueue.global().async(execute: {
                print("teste")
                DispatchQueue.main.sync {
                    self.hideSpinner()
                }
            })
        }
    }
    
    private func showSpinner() {
        backgroundImage.alpha = CGFloat(0.2)
        containerView.alpha = CGFloat(0.2)
        spinnerView.alpha = CGFloat(1.0)
        
        activityIndicator.startAnimating()
        spinnerView.isHidden = false
    }
    
    private func hideSpinner() {
        backgroundImage.alpha = CGFloat(1.0)
        containerView.alpha = CGFloat(1.0)
        
        activityIndicator.stopAnimating()
        spinnerView.isHidden = true
    }
}

