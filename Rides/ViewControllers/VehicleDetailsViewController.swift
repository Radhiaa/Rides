//
//  VehicleDetailsViewController.swift
//  Rides
//
//  Created by Radhia MIGHRI on 22/9/2024.
//

import UIKit

class VehicleDetailsViewController: UIViewController {

    var viewModel: VehicleDetailsViewModel!

    @IBOutlet weak var vinLabel: UILabel!
    @IBOutlet weak var makeAndModelLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var carTypeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the view with the data from the ViewModel
        vinLabel.text = viewModel.vin
        makeAndModelLabel.text = viewModel.makeAndModel
        colorLabel.text = viewModel.color
        carTypeLabel.text = viewModel.carType
    }
}

