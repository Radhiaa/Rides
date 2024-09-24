//
//  EstimatedCarbonViewModel.swift
//  Rides
//
//  Created by Radhia MIGHRI on 23/9/2024.
//

import Foundation
import Combine

class EstimatedCarbonViewModel {
    
    @Published var kilometrage: Int? {
        didSet {
            if let kilometrage = kilometrage {
                estimatedEmissions = calculateCarbonEmissions(for: Double(kilometrage))
            }
        }
    }
    
    @Published var estimatedEmissions: Double = 0.0
    
    // Function to calculate emissions based on kilometrage
    func calculateCarbonEmissions(for kilometrage: Double) -> Double {
        let threshold = 5000.0
        let initialRate = 1.0
        let additionalRate = 1.5
        
        if kilometrage <= threshold {
            return kilometrage * initialRate
        } else {
            let emissionsForFirst5000 = threshold * initialRate
            let additionalKilometres = kilometrage - threshold
            let emissionsForAdditionalKilometres = additionalKilometres * additionalRate
            return emissionsForFirst5000 + emissionsForAdditionalKilometres
        }
    }
}
