//
//  ViewController.swift
//  Bitcoin Price
//
//  Created by Sachin Khanal on 7/21/20.
//  Copyright © 2020 Sachin Khanal. All rights reserved.
//

import UIKit
protocol CoinManagerDelegate {
    func didUpdateThePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}

class ViewController: UIViewController {
    
    var coinManager = CoinManager()

    @IBOutlet weak var bitcoinPrice: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        coinManager.delegate = self
        currencyPicker.delegate = self
    }


}

extension ViewController: UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.myCurrency.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.myCurrency[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.myCurrency[row]
        coinManager.fetchCoinData(for: selectedCurrency)
    }
    
    
}

extension ViewController: CoinManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateThePrice(price: String, currency: String) {
        DispatchQueue.main.async{
            self.bitcoinPrice.text = price
            self.currencyLabel.text = currency
            
        }
    }
    
}

