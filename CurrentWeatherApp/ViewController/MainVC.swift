//
//  MainVC.swift
//  CurrentWeatherApp
//
//  Created by Ivan Ramirez on 2/3/22.
//

import UIKit
import CoreLocation

class MainVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var mainDescriptionLabel: UILabel!
    @IBOutlet weak var subDescriptionLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!

    private let locationManager = CLLocationManager()
    private let weatherController = WeatherController()
    // TOOPLE
    var coordinate = (myLat: "", myLong: "") {
        didSet {
            // TODO: - call the updateWeather dunc and provide the values above if changed, triggered by updated location
            updateWeather(latValue: coordinate.myLat, longValue: coordinate.myLong) // calls updateViews func
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: - add background UI
        view.addVerticalGradientLayer()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // more accruate, more battery drain
        locationManager.distanceFilter = 10 // move 10m to update
        locationManager.startUpdatingLocation() // how much should user travel before updating
    }

    override func viewWillAppear(_ animated: Bool) { // We want to grab location, check for premission
        super.viewWillAppear(animated)
        if CLLocationManager.locationServicesEnabled(){
            // TODO: - call updateWeather func
            updateWeather(latValue: coordinate.myLat, longValue: coordinate.myLong)
      }
    }
    
    // MARK: - Weather --> WEARNING: FUNC TIGHTLY COUPLED
        func updateWeather(latValue: String, longValue: String) {
            
            // CALL FETCH FUNC USING VALUES ABOVE
            weatherController.fetchWeather(lat: latValue, lon: longValue) { [weak self] result in // retain cycle
                
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let weatherDetails):
                    print(weatherDetails)
                    
                    // TODO: - Update labels w/ weather details from web
                    self?.updateViews(weatherInfo: weatherDetails) // retain cycle
                }
            }
        }


    /**
     Updates the labels with the weather details
     - weatherInfo  this is taken from your weather info model

     ## Important Note##
     The user needs internet in order for this function to run
     */
    func updateViews(weatherInfo: WeatherInfo) {
        Dispatch.DispatchQueue.main.async {
            self.cityLabel.text = "City: \(weatherInfo.name)"
            self.tempLabel.text = String(weatherInfo.main.temp)
            self.mainDescriptionLabel.text = weatherInfo.weather.first?.main ?? "No data found"
            self.subDescriptionLabel.text = weatherInfo.weather.first?.description ?? "No data found"
            self.maxTempLabel.text = "Max: \(weatherInfo.main.tempMax)"
            self.minTempLabel.text = "Min: \(weatherInfo.main.tempMin)"
        }
    }

    //MARK: - Location

    // Permissions
    // Detects if user authorization has changed (Apple created func)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestAlwaysAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            break
        case .denied, .restricted:
            break
        default:
            break
        }
        manager.startUpdatingLocation()
    }

    // Get the updated location of the user
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let locationValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        coordinate = ( "\(locationValue.latitude)", "\(locationValue.longitude)")
        
        print("🌎 didUpdateLocations: locations = \(locationValue.latitude)\(locationValue.longitude)")
        
        //C
        //Update weather func gets called
    }

}
