//
//  ViewController.swift
//  MW01_Srivalli_Kanchibotla
//
//  Created by KANCHIBOTLA SRIVALLI  on 9/22/16.
//  Copyright © 2016 KANCHIBOTLA SRIVALLI . All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet var noOfLaps: UILabel!
    @IBOutlet var totalTime: UILabel!
    
    @IBOutlet var newLap: UIButton!
    @IBOutlet var stats: UIButton!
    @IBOutlet var currentLap: UILabel!
    var laps: [String] = []
    var seconds = 0.00
    var startTime = TimeInterval()
    var timer = Timer()
    var timer1 = Timer()
    let startDisabled = UIImage(named: "Start_disabled.png") as UIImage!
    let stopImage = UIImage(named: "stop.png") as UIImage!
    let startImage = UIImage(named: "start_1.png") as UIImage!
    let newLapActive = UIImage(named: "newlap_active.png") as UIImage!
    let newLapDisabled = UIImage(named: "newlap_1.png") as UIImage!
    let showStatsActive = UIImage(named: "showstats_active.png") as UIImage!
    let showStats = UIImage(named: "showstats_1.png") as UIImage!
    var isTimerOn = false
    
    @IBOutlet var resetButton: UIBarButtonItem!
    
    
    @IBOutlet var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        totalTime.text = "00:00:00"
        noOfLaps.text = "0"
       
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    @IBAction func showStats(_ sender: AnyObject) {
       
        
    }
    
   

    @IBAction func reset(_ sender: AnyObject) {
        
        if isTimerOn {
            
        
        let alertController = UIAlertController(title: "Caution!", message: "Are you sure you want to reset the count?", preferredStyle: .alert)
        let resetAction = UIAlertAction(title: "Yes", style: .destructive){
            (result : UIAlertAction) in
            self.currentLap.text = "00:00:00"
            self.totalTime.text = "00:00:00"
            self.noOfLaps.text = "0"
            self.startButton.setImage(self.startImage, for: .normal)
            self.startButton.isEnabled = true
            self.stats.setImage(self.showStats, for: .normal)
            self.stats.isEnabled = false
            self.newLap.setImage(self.newLapDisabled, for: .normal)
            self.newLap.isEnabled = false
            self.timer.invalidate()
            self.laps.removeAll()
            self.isTimerOn = false
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(resetAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mySegueIdentifier" {
            let dvc =  segue.destination as? MyViewController
            dvc!.allLaps = laps
            
            
        }
    }
  
    @IBAction func newLap(_ sender: AnyObject) {
        
        laps.append(currentLap.text!)
        
        let time = currentLap.text
        
        let currentTime = time?.components(separatedBy: ":")
        let currentTT = totalTime.text?.components(separatedBy: ":")
        let hours = currentTT?[0]
        let mins = currentTT?[1]
        let sec = currentTT?[2]
        let curHours = currentTime?[0]
        let curMins = currentTime?[1]
        let curSec = currentTime?[2]
        var totalHrs = Int(hours!)!+Int(curHours!)!
        var totalMins = Int(mins!)!+Int(curMins!)!
        var totalSecs = Int(sec!)!+Int(curSec!)!
        if totalSecs>=1000 {
            totalSecs = 0
            totalMins += 1
            
        }
        if totalMins>=60{
            totalMins = 0
            totalHrs += 1
        }
        totalTime.text = "\(totalHrs):\(totalMins):\(totalSecs)"
        noOfLaps.text = String(Int(noOfLaps.text!)!+1)
        timer.invalidate()
        currentLap.text = "00:00:00"
         timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate
        
    }
    
    
    
    @IBAction func start(_ sender: AnyObject) {
        if isTimerOn {
            self.startButton.setImage(startDisabled, for: .normal)
            self.startButton.isEnabled = false
            self.stats.setImage(showStatsActive, for: .normal)
            self.stats.isEnabled = true
            self.newLap.setImage(newLapDisabled, for: .normal)
            self.newLap.isEnabled = false
            timer.invalidate()
            
            
        }
        else{
            
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
       
            startTime = NSDate.timeIntervalSinceReferenceDate
        self.startButton.setImage(stopImage, for: .normal)
            
            self.newLap.setImage(newLapActive, for: .normal)
            self.newLap.isEnabled = true
            isTimerOn = true
            
        }
        
    }

    
    func updateTimer(){
        let currentTime = NSDate.timeIntervalSinceReferenceDate
        var elapsedTime: TimeInterval = currentTime - startTime
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (TimeInterval(minutes) * 60)
        let seconds = UInt8(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        let fraction = UInt8(elapsedTime * 100)
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        currentLap.text = "\(strMinutes):\(strSeconds):\(strFraction)"
        
    }
}

var instance = ViewController()

