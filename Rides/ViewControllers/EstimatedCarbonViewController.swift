//
//  EstimatedCarbonViewController.swift
//  Rides
//
//  Created by Radhia MIGHRI on 23/9/2024.
//

import UIKit
import Combine

class EstimatedCarbonViewController: UIViewController {
    
    @IBOutlet weak var emissionsLabel: UILabel!
    
    var viewModel = EstimatedCarbonViewModel()
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Bind the ViewModel to the UI
        bindViewModel()
        
    }
    
    // Function to bind the ViewModel
    func bindViewModel() {
        // Observe changes to estimatedEmissions
        viewModel.$estimatedEmissions
            .sink { [weak self] emissions in
                self?.emissionsLabel.text = "Estimated Carbon Emissions: \(emissions) kg CO2"
            }
            .store(in: &cancellables)
    }
}
