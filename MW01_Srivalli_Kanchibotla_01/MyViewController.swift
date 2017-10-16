//
//  MyViewController.swift
//  MW01_Srivalli_Kanchibotla_01
//
//  Created by KANCHIBOTLA SRIVALLI  on 10/3/16.
//  Copyright © 2016 KANCHIBOTLA SRIVALLI . All rights reserved.
//

import UIKit

class MyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var lapsHrs: [String] = []
    var lapsMins: [String] = []
    var lapsSecs: [String] = []
    var sum = 0
    var average = 0
    @IBOutlet var fastestLap: UILabel!
    @IBOutlet var slowestLap: UILabel!
    @IBOutlet var averageLap: UILabel!
    var allLaps: [String]!
    
    let textCellIdentifier = "TextCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //print(swiftBlogs)
        
        // Do any additional setup after loading the view.
       
        var temp: [String] = []
        var tempTime: [Int] = []
        for i in 0..<allLaps.count {
            
            temp = allLaps[i].components(separatedBy: ":")
            lapsHrs.append(temp[0])
            lapsMins.append(temp[1])
            lapsSecs.append(temp[2])
  
        }
       
        for i in 0..<lapsSecs.count{
            tempTime.append(Int(lapsHrs[i])!*60000 + Int(lapsMins[i])!*1000 + Int(lapsSecs[i])! )    //converting all the lap times to milliseconds
        }
        
        let max =  tempTime.max()               //getting the maximum laptime in milliseconds
        let maxIndex = tempTime.index(of: max!) //getting the index of maximum laptime
        let min = tempTime.min()                //getting the minimum laptime in miliseconds
        let minIndex = tempTime.index(of: min!) //getting the index of minimum laptime
        slowestLap.text = allLaps[maxIndex!]
        slowestLap.textAlignment = NSTextAlignment.right
        fastestLap.textAlignment = NSTextAlignment.right
        averageLap.textAlignment = NSTextAlignment.right
        fastestLap.text = allLaps[minIndex!]
        for i in 0..<tempTime.count {
            sum += tempTime[i]
        }
        average = sum/tempTime.count
        var x = average
        let ms = x % 1000
        x /= 1000
        let seconds = x % 60
        x /= 60
        let minutes = x % 60
        
        averageLap.text = "\(minutes):\(seconds):\(ms)"
        
       
       

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allLaps.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = "Lap \(row+1):"
        cell.detailTextLabel?.text = allLaps[row]
        
        
        return cell
    }
    
    
    
    @IBOutlet var tableView: UITableView!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
