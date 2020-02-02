//
//  PageViewController.swift
//  Memeful
//
//  Created by Fazlin Nouzil on 2/1/20.
//  Copyright © 2020 Venera Sofware. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
    
    var galleriesModel = [Gallery]()
    private var pageController: UIPageViewController?
    internal var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPageController()
    }
    //MARK: PageViewController setup
    
    private func setupPageController() {
        
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageController?.dataSource = self
        self.pageController?.delegate = self
        self.pageController?.view.backgroundColor = .clear
        self.pageController?.view.frame = CGRect(x: 0,y: 0,width: self.view.frame.width,height: self.view.frame.height)
        self.addChild(self.pageController!)
        self.view.addSubview(self.pageController!.view)
        let  storyboard : UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "MostViralDetailViewController") as! MostViralDetailViewController
        let initialVC = viewController
        initialVC.galleryModel = galleriesModel[currentIndex]
        
        self.pageController?.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        
        self.pageController?.didMove(toParent: self)
    }
}

//MARK: PageViewController Delegate and DataSource

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if currentIndex == 0 {
            return nil
        }
        
        currentIndex -= 1
        let  storyboard : UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let beforeVC = storyboard.instantiateViewController(withIdentifier: "MostViralDetailViewController") as! MostViralDetailViewController
        beforeVC.galleryModel = galleriesModel[currentIndex]
        
        return beforeVC
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        
        if currentIndex >= self.galleriesModel.count - 1 {
            return nil
        }
        
        currentIndex += 1
        let  storyboard : UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let afterVC = storyboard.instantiateViewController(withIdentifier: "MostViralDetailViewController") as! MostViralDetailViewController
        afterVC.galleryModel = galleriesModel[currentIndex]
        
        return afterVC
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.galleriesModel.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
}

