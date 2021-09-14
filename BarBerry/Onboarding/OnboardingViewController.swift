//
//  OnboardViewController.swift
//  BarBerry
//
//  Created by Odirile Kekana on 2021/08/11.
//

import UIKit

class OnboardingViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageCntrl: UIPageControl!
    @IBOutlet weak var nextBtn: UIButton!
    
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageCntrl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Get Started", for: .normal)
                nextBtn.backgroundColor = UIColor.magenta
            }    
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
       //create array to populate the collectionview
        
        slides = [OnboardingSlide(title: "Welcome!", description: "Experience a variety of drinks, alcohol and non-alcohol, from different cultures around the world.", image: #imageLiteral(resourceName: "two")),
        OnboardingSlide(title: "The best bartenders", description: "Our drinks are prepared by only the best", image: #imageLiteral(resourceName: "ralph-darabos-swkwxyaBFto-unsplash")),
        OnboardingSlide(title: "Join us", description: "Explore our menu and lets help you get rid of that thirst", image: #imageLiteral(resourceName: "one"))]
        
        pageCntrl.numberOfPages = slides.count
    }

    @IBAction func nextBtnClicked(_ sender: Any) {
        
        //pageCntrl.currentPage = currentPage
        
        if currentPage == slides.count - 1 {
            // code to go launch the home page of your app
            let controller = storyboard?.instantiateViewController(identifier: "home") as! UITabBarController
            UserDefaults.standard.hasOnboarded = true
            present(controller, animated: true, completion: nil)
          
        }
        else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnboardingCollectionViewCell
        
        cell.setUp(slide: slides[indexPath.row])
        
        
        return cell
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    //lets us know when scrolling has occured
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
        //pageCntrl.currentPage = currentPage
        
            }
}
