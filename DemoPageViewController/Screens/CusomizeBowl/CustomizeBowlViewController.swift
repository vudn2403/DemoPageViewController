//
//  CustomizeBowlViewController.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/2/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import UIKit
import MaterialComponents

class CustomizeBowlViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var pageView: UIView!
    
    lazy var pagerController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    var viewControllers = [UIViewController]()
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextPageButton: UIButton!
    @IBOutlet weak var submitPageButton: UIButton!
    
    //MARK: - Variable
    fileprivate var currentPage = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setup
    func setUp() {
        navigationItem.title = "Customize Bowl"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "$ x.x", style: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "arrowLeftWhite"), style: .done, target: self, action: #selector(onBack(_:)))
        navigationController?.navigationBar.barTintColor = UIColor.blue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        setUpPagerController()
        setUpPageControl()
        
    }
    
    func setUpPagerController() {
        let recipientVC = RecipientViewController(nibName: "RecipientViewController", bundle: nil)
        let scheduledDeliveryVC = ScheduledDeliveryViewController(nibName: "ScheduledDeliveryViewController", bundle: nil)
        viewControllers = [recipientVC, scheduledDeliveryVC]
        //pagerController.dataSource = self
        //pagerController.delegate = self
        addChildViewController(pagerController)
        pagerController.view.frame.size = pageView.frame.size
        pagerController.setViewControllers([viewControllers[0]], direction: .forward, animated: true, completion: nil)
        
        pageView.addSubview(pagerController.view)
    }
    
    func setUpPageControl() {
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.numberOfPages = viewControllers.count
        pageControl.currentPage = 0
        pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    // MARK: - IBAction
    @IBAction func onNextPage(_ sender: UIButton) {
//        if currentPage == viewControllers.count - 1 {
//            // do nothing
//        } else {
//
//        }
        var isVerify = false
        
        if let vc = viewControllers[currentPage] as? RecipientViewController {
            isVerify = vc.isVerify()
        }
        
        if isVerify {
            currentPage += 1
            updateUI()
        }
    }
    @IBAction func onSubmit(_ sender: UIButton) {
        alertWith("Thông báo", "Submit and review")
    }
    
    // MARK: - Action
    
    @objc func onBack(_ sender: UIBarButtonItem) {
        if currentPage == 0 {
            alertWith("Thông báo", "Back to main page")
        } else {
            currentPage -= 1
            updateUI()
        }
    }
    
    func updateUI() {
        pagerController.setViewControllers([viewControllers[currentPage]], direction: .forward, animated: true, completion: nil)
        pageControl.currentPage = currentPage
        nextPageButton.isHidden = currentPage == viewControllers.count - 1 ? true : false
        submitPageButton.isHidden = currentPage == viewControllers.count - 1 ? false : true
    }
}

extension CustomizeBowlViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
    }
    
    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        if let viewControllerIndex = viewControllers.index(of: viewController) {
//            if viewControllerIndex == 0 {
//                return nil
//            } else {
//                return viewControllers[viewControllerIndex - 1]
//            }
//        }
//
//        return nil
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        if let viewControllerIndex = viewControllers.index(of: viewController) {
//            if viewControllerIndex == viewControllers.count - 1{
//                return nil
//            } else {
//                return viewControllers[viewControllerIndex + 1]
//            }
//        }
//        return nil
//    }
}

extension CustomizeBowlViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        // update pageControl
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = viewControllers.index(of: pageContentViewController)!
    }
}
