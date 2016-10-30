//
//  MainViewController.swift
//  practicambaasfrontend
//
//  Created by Alma Martinez on 30/10/16.
//  Copyright © 2016 Alma Martinez. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func goToAuthenticated(_ sender: UIButton) {
        let storyBoardL = UIStoryboard(name: "Authenticated", bundle: Bundle.main)
        let vc = storyBoardL.instantiateViewController(withIdentifier: "authScene")
        
        present(vc, animated: true, completion: nil)
    
    }
    
    
    @IBAction func goToUnauthenticated(_ sender: UIButton) {
        let storyBoardA = UIStoryboard(name: "Anonymous", bundle: Bundle.main)
        let vc = storyBoardA.instantiateViewController(withIdentifier: "anonymousScene")
        
        present(vc, animated: true, completion: nil)

    
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
