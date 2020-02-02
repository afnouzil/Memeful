//
//  MostViralViewController.swift
//  Memeful
//
//  Created by Fazlin Nouzil on 1/27/20.
//  Copyright © 2020 Venera Sofware. All rights reserved.
//

import UIKit
import SDWebImage

class MostViralViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var acitvityIndicator: UIActivityIndicatorView!
    
    var galleriesModel = [Gallery]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.acitvityIndicator.startAnimating()
        collectionView.register(UINib.init(nibName:Constants.ReuseableIdentifiers.mostViralCollectionViewCell.rawValue , bundle: nil), forCellWithReuseIdentifier: Constants.ReuseableIdentifiers.mostViralCollectionViewCell.rawValue)
       
        guard NetworkStatus.isConnectedToInternet else{
            self.toast(title: "No internet connection available", duration: 1.2, color: .white)
            self.acitvityIndicator.isHidden = true
            return
        }
        self.toast(title: "Please wait..Fetching details", duration: 1.2, color: .white)
        self.acitvityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.galleryAPI()
        }
    }
    
    //MARK: API for fetching Gallery details
    func galleryAPI(){
        DataManager.shared.getGalleryImages { (res, err) in
            if let galleries = res{
                print(galleries)
                self.galleriesModel = galleries
                self.acitvityIndicator.stopAnimating()
                self.collectionView.reloadData()
            }
        }
    }
}

//MARK: Swiping from left to right and vice versa.

extension MostViralViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  galleriesModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseableIdentifiers.mostViralCollectionViewCell.rawValue, for: indexPath) as? MostViralCollectionViewCell  else {
            return UICollectionViewCell()
        }
        
        if let image =  galleriesModel[indexPath.row].image{
            
            if image[0].type == "image/jpeg"{
                if let imageLink = image[0].link{
                    if let title =  self.galleriesModel[indexPath.row].title{
                        cell.titleLabel.text = title
                        cell.titleLabel.isHidden = false
                    }else{
                        cell.titleLabel.isHidden = true
                    }
                    
                    if let description =  image[0].desc{
                        cell.descriptionLabel.text = description
                        cell.descriptionLabel.isHidden = false
                        
                    }else{
                        cell.descriptionLabel.text = ".."
                    }
                    
                    if let points =  self.galleriesModel[indexPath.row].points{
                        cell.pointsLabel.text = "\(points) points"
                        cell.pointsLabel.isHidden = false
                    }else{
                        cell.pointsLabel.isHidden = true
                    }
                    
                    cell.layer.cornerRadius = 3
                    cell.layer.masksToBounds = true
                    cell.activityIndicator.isHidden = false
                    cell.activityIndicator.startAnimating()
                    cell.imageView?.sd_setImage(with: NSURL(string: imageLink) as URL? , completed: {
                        (image, error, cacheType, url) in
                        DispatchQueue.main.async {
                            cell.activityIndicator.isHidden = true
                            cell.activityIndicator.stopAnimating()
                        }
                    })
                    
                }
            }
            
        }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let  storyboard : UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let pageViewController = storyboard.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
        pageViewController.galleriesModel = galleriesModel
        pageViewController.currentIndex = indexPath.row
        self.navigationController?.pushViewController(pageViewController, animated: true)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((collectionView.frame.size.width)/2)-20, height:(collectionView.frame.size.width)/2)
    }
    
}


