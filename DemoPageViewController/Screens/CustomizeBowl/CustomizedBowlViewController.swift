//
//  CustomizeBowlViewController.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/2/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import UIKit
import Stripe

class CustomizedBowlViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var pageView: UIView!
    
    lazy var pagerController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    var viewControllers = [UIViewController]()
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: - Variable
    fileprivate var currentPage = 0
    let stripePublishableKey = "pk_test_nYxpBPUe918NfRHIEBeyHkrd"
    let backendBaseURL: String? = "https://gem-demo-stripe.herokuapp.com"
    let appleMerchantID: String? = "dummy-merchant-id"
    let paymentCurrency = "usd"
    
    let paymentContext: STPPaymentContext? = nil
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    let numberFormatter: NumberFormatter? = nil
    let shippingString: String = ""

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUp()
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
        navigationItem.title = "Customized Bowl"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "$ x.x", style: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "arrowLeftWhite"), style: .done, target: self, action: #selector(onBack(_:)))
        navigationController?.navigationBar.barTintColor = AppColor.colorPaleGray()
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        setUpPagerController()
        setUpPageControl()
    }
    
    func setUpPagerController() {
        MyAPIClient.sharedClient.baseURLString = self.backendBaseURL
        let proteinVC = BowlProductViewController(ProductType.protein)
        let veggiesVC = BowlProductViewController(ProductType.veggies)
        let sauceForSaladVC = BowlProductViewController(ProductType.sauceForSalad)
        let recipientVC = RecipientViewController(nibName: "RecipientViewController", bundle: nil)
        let scheduledDeliveryVC = ScheduledDeliveryViewController(nibName: "ScheduledDeliveryViewController", bundle: nil)
        viewControllers = [proteinVC, veggiesVC, sauceForSaladVC, recipientVC, scheduledDeliveryVC]
        pagerController.dataSource = self
        pagerController.delegate = self
        addChildViewController(pagerController)
        pagerController.view.frame.size = pageView.frame.size
        pagerController.setViewControllers([viewControllers[currentPage]], direction: .forward, animated: true, completion: nil)
        
        pageView.addSubview(pagerController.view)
    }
    
    func setUpPageControl() {
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.numberOfPages = viewControllers.count
        pageControl.currentPage = currentPage
        pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    // MARK: - Action
    
    @objc func onBack(_ sender: UIBarButtonItem) {
        alertWith("Thông báo", "Back to main page")
    }
}

// MARK: - UIPageViewControllerDataSource
extension CustomizedBowlViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = viewControllers.index(of: viewController) {
            if viewControllerIndex == 0 {
                return nil
            } else {
                return viewControllers[viewControllerIndex - 1]
            }
        }

        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = viewControllers.index(of: viewController) {
            if viewControllerIndex == viewControllers.count - 1{
                return nil
            } else {
                return viewControllers[viewControllerIndex + 1]
            }
        }
        return nil
    }
}

// MARK: - UIPageViewControllerDelegate
extension CustomizedBowlViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        // update pageControl
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = viewControllers.index(of: pageContentViewController)!
    }
}

extension CustomizedBowlViewController: STPPaymentMethodsViewControllerDelegate {
    func paymentMethodsViewController(_ paymentMethodsViewController: STPPaymentMethodsViewController, didFailToLoadWithError error: Error) {
        alertWith("Lỗi", "did load with error")
    }
    
    func paymentMethodsViewControllerDidFinish(_ paymentMethodsViewController: STPPaymentMethodsViewController) {
        //self.dismiss(animated: true, completion: nil)
    }
    
    func paymentMethodsViewControllerDidCancel(_ paymentMethodsViewController: STPPaymentMethodsViewController) {
        //self.dismiss(animated: true, completion: nil)
    }
}

extension CustomizedBowlViewController: STPAddCardViewControllerDelegate {
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateSource source: STPSource, completion: @escaping STPErrorBlock) {
        // do something
        print("didCreateSource")
        self.dismiss(animated: true, completion: nil)
    }
}
