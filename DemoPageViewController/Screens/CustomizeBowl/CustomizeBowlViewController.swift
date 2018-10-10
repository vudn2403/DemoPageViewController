//
//  CustomizeBowlViewController.swift
//  DemoPageViewController
//
//  Created by Đinh Ngọc Vũ on 10/2/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import UIKit
import Stripe

class CustomizeBowlViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var pageView: UIView!
    
    lazy var pagerController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    var viewControllers = [UIViewController]()
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var submitButton: UIButton!
    
    //MARK: - Variable
    fileprivate var currentPage = 0
    let stripePublishableKey = "pk_test_nYxpBPUe918NfRHIEBeyHkrd"
    let backendBaseURL: String? = "https://gem-demo-stripe.herokuapp.com"
    let appleMerchantID: String? = "dummy-merchant-id"
    let companyName = "Emoji Apparel"
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
        navigationItem.title = "Customize Bowl"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "$ x.x", style: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "arrowLeftWhite"), style: .done, target: self, action: #selector(onBack(_:)))
        navigationController?.navigationBar.barTintColor = UIColor.blue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        setUpPagerController()
        setUpPageControl()
        submitButton.setTitle(currentPage != viewControllers.count - 1 ? "Next" : "Submit and review", for: .normal)
    }
    
    func setUpPagerController() {
        MyAPIClient.sharedClient.baseURLString = self.backendBaseURL
        let recipientVC = RecipientViewController(nibName: "RecipientViewController", bundle: nil)
        let scheduledDeliveryVC = ScheduledDeliveryViewController(nibName: "ScheduledDeliveryViewController", bundle: nil)
        
        let config = STPPaymentConfiguration.shared()
        config.publishableKey = self.stripePublishableKey
        config.appleMerchantIdentifier = self.appleMerchantID
        config.companyName = self.companyName
        config.requiredBillingAddressFields = .full
        config.requiredShippingAddressFields = [.emailAddress, .name, .phoneNumber]
        config.shippingType = .shipping
        config.additionalPaymentMethods = .all
        
        // Create card sources instead of card tokens
        config.createCardSources = true;
        
        let customerContext = STPCustomerContext(keyProvider: MyAPIClient.sharedClient)
//        let paymentContext = STPPaymentContext(customerContext: customerContext,
//                                               configuration: config,
//                                               theme: .default())
//        let userInformation = STPUserInformation()
//        paymentContext.prefilledInformation = userInformation
//        paymentContext.paymentAmount = 5000
//        paymentContext.paymentCurrency = self.paymentCurrency
        
        let addCardVC = STPAddCardViewController(configuration: config, theme: .default())
        //addCardVC.delegate = self
        let paymentMethodsVC = STPPaymentMethodsViewController(configuration: config, theme: .default(), customerContext: customerContext, delegate: self)
//        let shippingVC = STPShippingAddressViewController(paymentContext: paymentContext)
        viewControllers = [recipientVC, scheduledDeliveryVC, paymentMethodsVC]
        //pagerController.dataSource = self
        //pagerController.delegate = self
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
    
    // MARK: - IBAction
    @IBAction func onSubmit(_ sender: UIButton) {
        if currentPage == viewControllers.count - 1 {
            if let vc = viewControllers[currentPage] as? ScheduledDeliveryViewController {
                BowlViewModel.shareInstance.scheduleDelivery = vc.scheduleDilivery
            }
            //let vc = BrowseProductsViewController()]
            let config = STPPaymentConfiguration.shared()
            let addCardVC = STPAddCardViewController(configuration: config, theme: .default())
            addCardVC.delegate = self
            let nav = UINavigationController(rootViewController: addCardVC)
            present(nav, animated: true, completion: nil)
        } else {
            var isVerify = true
//            if let vc = viewControllers[currentPage] as? RecipientViewController {
//                isVerify = vc.isVerify()
//            }
//
//            if let vc = viewControllers[currentPage] as? ScheduledDeliveryViewController {
//                isVerify = true
//            }
//
//            if let vc = viewControllers[currentPage] as? STPPaymentMethodsViewController {
//                isVerify = true
//            }
            
            if isVerify {
                currentPage += 1
                updateUI()
            }
        }
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
        submitButton.setTitle(currentPage != viewControllers.count - 1 ? "Next" : "Submit and review", for: .normal)
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

extension CustomizeBowlViewController: STPPaymentMethodsViewControllerDelegate {
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

extension CustomizeBowlViewController: STPAddCardViewControllerDelegate {
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        print(token.tokenId)
        print(token.stripeID)
        print(token.bankAccount?.bankName)
        self.dismiss(animated: true, completion: nil)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateSource source: STPSource, completion: @escaping STPErrorBlock) {
        // do something
        print("didCreateSource")
        print(source.clientSecret)
        self.dismiss(animated: true, completion: nil)
    }
}
