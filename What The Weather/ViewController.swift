//
//  ViewController.swift
//  What The Weather
//
//  Created by mn on 24/05/16.
//  Copyright © 2016 mn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cityTextField: UITextField!

    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func findWeather(sender: AnyObject) {
        
        var wasSuccessful = false
        
        let tryurl = NSURL(string: "http://www.weather-forecast.com/locations/"+cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-")+"/forecasts/latest")
        if let url = tryurl{
    
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, respond, error)-> Void in
                if let urlContent = data{
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    let webSiteArray = webContent?.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                    if webSiteArray!.count > 1{
                        
                        wasSuccessful = true
                        
                        let weatherArray = webSiteArray![1].componentsSeparatedByString("</span>")
                        
                        if weatherArray.count > 1{
                            let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "°")
                            
                            dispatch_async(dispatch_get_main_queue(), { ()-> Void in
                                self.resultLabel.text = weatherSummary
                            })
                            
                        }
                    }
                    
                }
                if wasSuccessful == false{
                    self.resultLabel.text = "Could not find the weather for that city - please try again"
                }
            }
            
            task.resume()
        }else{
            self.resultLabel.text = "Could not find the weather for that city - please try again"
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

