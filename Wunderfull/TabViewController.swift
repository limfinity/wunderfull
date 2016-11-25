//
//  TabViewController.swift
//  Wunderfull
//
//  Created by Peter Pult on 25/11/2016.
//  Copyright © 2016 Peter Pult. All rights reserved.
//

import UIKit
import Segmentio

enum ContainerViewState: Int {
    case list, map
}

class TabViewController: UIViewController {

    @IBOutlet weak var tabView: Segmentio!
    @IBOutlet weak var containerView: UIView!
    
    fileprivate weak var currentViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabView()
    }

    func setupTabView() {
        TabViewBuilder.buildTabView(tabView: tabView, style: .onlyLabel)
        tabView.valueDidChange = { tabView, index in
            print("Selected item: \(index)")
            self.showViewController(withState: ContainerViewState(rawValue: index)!)
        }
        
        // Select first state by default
        tabView.selectedSegmentioIndex = 0
    }
    
    func showViewController(withState state: ContainerViewState) {
        let viewController: UIViewController
        
        switch state {
        case .list:
            viewController = (storyboard?.instantiateViewController(withIdentifier: "LocationList"))!
        case .map:
            viewController = (storyboard?.instantiateViewController(withIdentifier: "LocationMap"))!
        }
        
        addViewController(asChildViewController: viewController, toContainerView: containerView)
        
        removeViewController(asChildViewController: currentViewController)
        currentViewController = viewController
    }
    
    func addViewController(asChildViewController viewController: UIViewController, toContainerView containerView: UIView) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    func removeViewController(asChildViewController viewController: UIViewController?) {
        // Notify Child View Controller
        viewController?.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController?.view.removeFromSuperview()
        
        // Remove Child View Controller
        viewController?.removeFromParentViewController()
    }

}
