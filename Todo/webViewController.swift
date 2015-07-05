//
//  webViewController.swift
//  Todo
//
//  Created by apple on 15/5/8.
//  Copyright (c) 2015年 zz. All rights reserved.
//

import UIKit

class webViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!

    var webURL:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let requestURL = NSURL(string:webURL!)
        let request = NSURLRequest(URL: requestURL!)
        
        webView.loadRequest(request)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
