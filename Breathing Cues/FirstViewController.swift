//
//  FirstViewController.swift
//  Breathing Cues
//
//  Created by Amritpal Singh on 2018-08-22.
//  Copyright © 2018 Amritpal Singh. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    let timerSecondsKey = "TimerSeconds"
    let holdSecondsKey = "SecondListContinousHold"
    let actionSecondsKey = "SecondListContinous"
    
    var timerSeconds: [Int] = []
    var holdSeconds: [Int] = []
    var actionSeconds: [Int] = []
    
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
//        setupPickerViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData(){
        let path = Bundle.main.path(forResource:"pickerData", ofType: "plist")
        let dict:NSDictionary = NSDictionary(contentsOfFile: path!)!
    
        if (dict.object(forKey: "TimerSeconds") != nil) {
            if let secArray = dict.object(forKey: "TimerSeconds") as? [Int] {
                timerSeconds = secArray
                print(secArray)
            }
        }
        if (dict.object(forKey: "SecondListContinous") != nil) {
            if let secArray = dict.object(forKey: "SecondListContinous") as? [Int] {
                actionSeconds = secArray
                print(secArray)
            }
        }
        if (dict.object(forKey: "SecondListContinousHold") != nil) {
            if let secArray = dict.object(forKey: "SecondListContinousHold") as? [Int] {
                holdSeconds = secArray
                print(secArray)
            }
        }
    }
}

extension FirstViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 0{
            return 4
        }else{
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
            if component == 0 || component == 2{
                return actionSeconds.count
            }
            else{
                return holdSeconds.count
            }
        }else{
            return timerSeconds.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0{
            if component == 0 || component == 2{
                return String(actionSeconds[row])
            }
            else{
                return String(holdSeconds[row])
            }
        }else{
            return String(timerSeconds[row])
        }
    }
}

extension FirstViewController: UIPickerViewDelegate{
    
}
