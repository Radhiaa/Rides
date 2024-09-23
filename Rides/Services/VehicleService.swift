//
//  VehicleService.swift
//  Rides
//
//  Created by Radhia MIGHRI on 22/9/2024.
//

import Foundation
import Combine

class VehicleService {
    func fetchVehicles(size: Int) -> AnyPublisher<[Vehicle], Error> {
        let urlString = "https://random-data-api.com/api/vehicle/random_vehicle?size=\(size)"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Vehicle].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main) // Ensure updates happen on the main thread
            .eraseToAnyPublisher()
    }
    
}
