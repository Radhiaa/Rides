//
//  VehicleDetailsViewModel.swift
//  Rides
//
//  Created by Radhia MIGHRI on 22/9/2024.
//

import Foundation

class VehicleDetailsViewModel {
    private let vehicle: Vehicle
    
    init(vehicle: Vehicle) {
        self.vehicle = vehicle
    }
    
    var vin: String {
        return vehicle.vin
    }
    
    var carType: String {
        return  vehicle.carType
    }
    
    var makeAndModel: String {
        return  vehicle.makeAndModel
    }
    
    var color: String {
        return  vehicle.color
    }
    
    var kilometrage: Int {
        return  vehicle.kilometrage
    }
    
}
