//
//  LocationSearchViewController.swift
//  UpMeDay
//
//  Created by MD. Amzad Hossain Arif on 28/8/19.
//  Copyright © 2019 MD. Amzad Hossain Arif. All rights reserved.
//

import UIKit
protocol searchCityDelegate {
    func userEnteredCityName(city: String)
}

class LocationSearchViewController: UIViewController {

    var delegate: searchCityDelegate?
    
    @IBOutlet weak var textFieldSearch: UITextField!
    
    
    
    @IBAction func buttonSearch(_ sender: UIButton) {
        
        let cityName = textFieldSearch.text!
        
        delegate?.userEnteredCityName(city: cityName)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
