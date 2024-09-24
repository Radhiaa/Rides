//
//  VehicleListViewController.swift
//  Rides
//
//  Created by Radhia MIGHRI on 22/9/2024.
//

import UIKit
import Combine

class VehicleListViewController: UITableViewController {
    
    // Outlets for the input text field and button
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var fetchButton: UIButton!
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl! // Segmented control for sorting
    
    public let viewModel = VehicleViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Vehicles"
        
        //Programmatically set the header height if constraints aren't enough
        self.tableView.tableHeaderView?.frame.size.height = 100
        
        setupActivityIndicator()
        bindViewModel()
    }
    
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
    
    // MARK: - Bind ViewModel to the View
    private func bindViewModel() {
        
        // Bind sorted vehicles to table view reload
        viewModel.$sortedVehicles
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        
        // Bind vehicles to table view reload
        viewModel.$vehicles
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        // Bind error message to show alert
        viewModel.$errorMessage
            .compactMap { $0 } // Ignore nil values
            .sink { [weak self] errorMessage in
                self?.activityIndicator.stopAnimating()
                self?.showErrorAlert(message: errorMessage)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Button action
    @IBAction func fetchButtonTapped(_ sender: UIButton) {
        guard let inputText = inputTextField.text, let numberOfItems = Int(inputText) else {
            showErrorAlert(message: "Please enter a valid number.")
            return
        }
        
        if numberOfItems < 0 || numberOfItems > 100 {
            showErrorAlert(message: "Number must be between 0 and 100.")
        } else {
            // Proceed with fetching the data
            activityIndicator.startAnimating()
            viewModel.fetchVehicles(size: numberOfItems) // Pass the number of vehicles to be fetched
        }
        
    }
    
    // MARK: - Segmented control action to toggle sort mode
    @IBAction func sortModeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            viewModel.sortMode = .vin // Sort by vin
        } else {
            viewModel.sortMode = .carType // Sort by carType
        }
        viewModel.sortVehicles() // Sort vehicles based on the new sort mode
        tableView.reloadData()
    }
    
    // MARK: - Error alert
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sortedVehicles.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VehicleCell", for: indexPath)
        cell.textLabel?.text = viewModel.vin(at: indexPath.row)
        cell.detailTextLabel?.text = viewModel.makeAndModel(at: indexPath.row)
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVehicle = viewModel.vehicle(at: indexPath.row)
        let detailsViewModel = VehicleDetailsViewModel(vehicle: selectedVehicle)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsVC = storyboard.instantiateViewController(withIdentifier: "PageViewController") as? PageViewController {
            detailsVC.viewModel = detailsViewModel
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    // MARK: - Mocking for intercept when the alert is presented for the unit test
    var isAlertPresented = false
    var alert =  UIAlertController()
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        super.present(viewControllerToPresent, animated: flag, completion: completion)
        if viewControllerToPresent is UIAlertController {
            isAlertPresented = true
            alert = viewControllerToPresent as! UIAlertController
        }
    }
}
