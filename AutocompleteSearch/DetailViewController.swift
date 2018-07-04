//
//  DetailViewController.swift
//  AutocompleteSearch
//
//  Created by Aman Aggarwal on 11/04/18.
//  Copyright © 2018 Aman Aggarwal. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var btnTet: UIButton!

    @IBOutlet weak var lblDetail: UILabel!
    
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var txtHC: NSLayoutConstraint!
    
    var strCountyName = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblDetail.text = strCountyName
        txtHC.constant = self.txtView.contentSize.height
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
