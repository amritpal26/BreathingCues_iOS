//
//  SecondViewController.swift
//  Breathing Cues
//
//  Created by Amritpal Singh on 2018-08-22.
//  Copyright © 2018 Amritpal Singh. All rights reserved.
//

import UIKit
import UICircularProgressRing

class SecondViewController: UIViewController{
    
    var timerSeconds: [Int] = []
    var selectedTimer: Int = 30
    var remainingTime: Int = 30
    var isTimerRunning = false
    var selectedRow = 0
    var timer = Timer()

    @IBOutlet weak var timerValue: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressView: UICircularProgressRing!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func PauseBtn(_ sender: Any) {
        if isTimerRunning{
            timer.invalidate()
            isTimerRunning = false
            timerValue.isEnabled = true
            progressView.maxValue = 100
            progressView.value = 100
        }
    }
    
    @IBAction func StartBtn(_ sender: Any) {
        if !isTimerRunning{
            runTimer()
            timerValue.isEnabled = false
            progressView.maxValue = CGFloat(selectedTimer)
            progressView.value = CGFloat(selectedTimer)
        }
    }
    
    @IBAction func stopBtn(_ sender: Any) {
        if isTimerRunning{
            timer.invalidate()
            remainingTime = selectedTimer
            isTimerRunning = false
            timerLabel.text = "0:00"
            timerValue.isEnabled = true
            progressView.maxValue = CGFloat(selectedTimer)
            progressView.value = CGFloat(selectedTimer)
        }
    }
    
    @IBAction func timerPick(_ sender: Any) {
        let alert = UIAlertController(title: "Timer", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        alert.isModalInPopover = true
        
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        pickerFrame.selectRow(selectedRow, inComponent: 0, animated: false)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            print("You selected " + String(self.selectedTimer))
            self.selectedTimer = self.timerSeconds[self.selectedRow]
            self.remainingTime = self.selectedTimer
            self.timerValue.setTitle(convertToString(totalSeconds: self.selectedTimer), for: .normal)
        }))
        self.present(alert,animated: true, completion: nil )
    }
    
    func loadData(){
        let path = Bundle.main.path(forResource:"pickerData", ofType: "plist")
        let dict:NSDictionary = NSDictionary(contentsOfFile: path!)!
        
        if (dict.object(forKey: "TimerSeconds2") != nil) {
            if let secArray = dict.object(forKey: "TimerSeconds2") as? [Int] {
                timerSeconds = secArray
                print(secArray)
            }
        }
    }
    
    func runTimer(){
        print("YEs")
        isTimerRunning = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(SecondViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if remainingTime > 0{
            remainingTime -= 1
            print(String(remainingTime) + "")
            let timeString = convertToString(totalSeconds: remainingTime)
            timerLabel.text = timeString
            progressView.value = CGFloat(remainingTime)
        }else{
            timer.invalidate()
            isTimerRunning = false
            remainingTime = selectedTimer
        }
    }
}

extension SecondViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timerSeconds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(timerSeconds[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        selectedRow = row
    }
}
extension SecondViewController: UIPickerViewDelegate{
    
}

func convertToString(totalSeconds: Int) -> String {
    let minutes = totalSeconds / 60
    let seconds = totalSeconds % 60
    if seconds > 9{
        return String(minutes) + ":" + String(seconds)
    }else{
        return String(minutes) + ":0" + String(seconds)
    }
}
