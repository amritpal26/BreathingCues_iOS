//
//  tester.swift
//  Breathing Cues
//
//  Created by Amritpal Singh on 2018-08-23.
//  Copyright © 2018 Amritpal Singh. All rights reserved.
//

import UIKit

class Tester: UIViewController {
    
    @IBOutlet weak var animatableView: UIView!
    
    @IBAction func sliderChanged(_ sender: UISlider){
        let value = sender.value
        let max = sender.maximumValue
        setMax(max: max)
        setProgress(progress: value)
    }
    
    var max: float_t = 0
    var scaledMax: float_t = 100
    var progress: float_t = 0
    var scaledProgress: float_t = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Circle
        animatableView.backgroundColor = UIColor.blue
        animatableView.layer.cornerRadius = animatableView.bounds.size.height/2
        animatableView.layer.masksToBounds = true
    }
    
    func setProgress(progress: float_t){
        scaledProgress = float_t(((progress - 0) / 100) + 0.50)
        self.progress = progress
        UIView.animate(withDuration: 0.1, animations: {
            self.animatableView.transform = CGAffineTransform(scaleX: CGFloat(self.scaledProgress), y: CGFloat(self.scaledProgress))
        })
    }
    
    func setMax(max: float_t){
        self.max = max
        scaledMax = float_t((max - 0) / 100)
    }
    
    func getMax() -> float_t{
        return max
    }
    
    func getProgress() -> float_t{
        return progress
    }
    
    func getScaledMax() -> float_t{
        return scaledMax
    }
    
    func getScaledProgress() -> float_t{
        return scaledProgress
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
