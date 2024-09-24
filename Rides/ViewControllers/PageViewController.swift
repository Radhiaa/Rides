//
//  PageViewController.swift
//  Rides
//
//  Created by Radhia MIGHRI on 23/9/2024.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var viewModel: VehicleDetailsViewModel!

    // Store the two view controllers
    lazy var orderedViewControllers: [UIViewController] = {
        let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VehicleDetailsViewController") as! VehicleDetailsViewController
        detailsVC.viewModel = viewModel
        
        let emissionsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EstimatedCarbonViewController") as! EstimatedCarbonViewController

        emissionsVC.viewModel.kilometrage = viewModel.kilometrage
        
        return [detailsVC, emissionsVC]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the dataSource and delegate
        self.dataSource = self
        self.delegate = self
        
        // Set the initial view controller (Details page)
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - UIPageViewControllerDataSource Methods
    
    // Return the previous view controller
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = orderedViewControllers.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return orderedViewControllers[index - 1]
    }
    
    // Return the next view controller
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = orderedViewControllers.firstIndex(of: viewController), index < orderedViewControllers.count - 1 else {
            return nil
        }
        return orderedViewControllers[index + 1]
    }
    
    // MARK: - Optional - UIPageControl
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
              let index = orderedViewControllers.firstIndex(of: firstViewController) else {
            return 0
        }
        return index
    }
}
