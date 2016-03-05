//
//  ViewController.swift
//  book
//
//  Created by Matheus Néry on 24/10/15.
//  Copyright © 2015 MatheusNéry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var mytextfield: UITextField!
    
    @IBOutlet var amazonP: UILabel!

    @IBAction func pesquisa(sender: AnyObject) {
        if(validateISBN()){
            Amazonpreco()
        }
    }
    
    // "<span class=\"a-color-price\">"
    // "</span>"
    func splitString(htmlString:NSString) -> NSString?
    {
            let myArray1 = htmlString.componentsSeparatedByString("<span class=\"a-color-price\">")
            let myArray2 = myArray1[1].componentsSeparatedByString("</span>")
            let preco = myArray2[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            return preco
    }
    
    
    func Amazonpreco()
    {
        let myURLString = "http://amazon.com/dp/" + mytextfield.text!
        let myURL = NSURL(string: myURLString)
        let myTask = NSURLSession.sharedSession().dataTaskWithURL(myURL!) {
            (myData, myResponse, myError) -> Void in
            if let myDataCode = myData
            {
                let myDataString = NSString(data: myDataCode, encoding: NSUTF8StringEncoding)
            //print(myDataString)
            //print(self.splitString(myDataString!))
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.amazonP.text = self.splitString(myDataString!) as? String
                })
            }
        }
        myTask.resume()
    }
    
    func validateISBN() -> Bool{
        if let myISBNText = mytextfield.text
        {
            if (myISBNText.characters.count == 10)
            {
                return true
            }
        }
        return false
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

