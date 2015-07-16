//
//  ViewController.swift
//  BAImageLoadingExemple
//
//  Created by Benjamin Deneux on 16/07/2015.
//  Copyright (c) 2015 Bananapp's. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: BAImageLoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(animated: Bool) {
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "showDownloadedImage", userInfo: nil, repeats: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showDownloadedImage() {
        imageView.setLoadedImage(UIImage(named: "photographer"))
    }

}

