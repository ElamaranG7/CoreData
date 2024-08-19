//
//  HomePageVc.swift
//  CoreDataData
//
//  Created by SAIL on 05/08/24.
//

import UIKit

class HomePageVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func createButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "CreateProfileVc") as! CreateProfileVc
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    @IBAction func profileListButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ListVC") as! ListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   

}
