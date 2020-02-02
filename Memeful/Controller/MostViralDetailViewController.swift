//
//  MostViralDetailViewController.swift
//  Memeful
//
//  Created by Fazlin Nouzil on 2/1/20.
//  Copyright © 2020 Venera Sofware. All rights reserved.
//

import UIKit
import SDWebImage

class MostViralDetailViewController: UIViewController{
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var nameStartingLabel: UILabel!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var viewsCountLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var galleryModel:Gallery?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabels()
    }
    
    func setupLabels(){
        
        if let gallery = galleryModel{
            if let tags = gallery.tags{
                if tags.count != 0{
                    if let displayName = tags[0].displayName{
                        displayNameLabel.text = displayName
                        let firstLetter = displayName.prefix(1)
                        nameStartingLabel.layer.cornerRadius = nameStartingLabel.frame.height/2
                        nameStartingLabel.layer.masksToBounds = true
                        nameStartingLabel.text = firstLetter.capitalized
                    }else{
                        nameStartingLabel.layer.cornerRadius = nameStartingLabel.frame.height/2
                        nameStartingLabel.layer.masksToBounds = true
                        
                    }
                }else{
                    nameStartingLabel.layer.cornerRadius = nameStartingLabel.frame.height/2
                    nameStartingLabel.layer.masksToBounds = true
                }
            }
            if let viewsCount = gallery.views{
                viewsCountLabel.text = "\(viewsCount) views"
            }
            if let image =  gallery.image{
                
                if image[0].type == "image/jpeg"{
                    if let imageLink = image[0].link{
                        if let description =  image[0].desc{
                            descriptionLabel.text = description
                        }else{
                            descriptionLabel.text = ".."
                        }
                        
                        indicatorView.isHidden = false
                        indicatorView.startAnimating()
                        imageView?.sd_setImage(with: NSURL(string: imageLink) as URL? , completed: {
                            (image, error, cacheType, url) in
                            DispatchQueue.main.async {
                                self.indicatorView.isHidden = true
                                self.indicatorView.stopAnimating()
                            }
                        })
                        
                    }
                }
                
            }
            
        }
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
