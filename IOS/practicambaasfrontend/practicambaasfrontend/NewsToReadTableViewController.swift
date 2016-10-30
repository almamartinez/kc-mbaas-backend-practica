//
//  NewsToReadTableViewController.swift
//  practicambaasfrontend
//
//  Created by Alma Martinez on 31/10/16.
//  Copyright © 2016 Alma Martinez. All rights reserved.
//

import UIKit

class NewsToReadTableViewController: UITableViewController {

    var client: MSClient = MSClient(applicationURL: URL(string: "https://kc-mbaas-pr-almams.azurewebsites.net")!)
    var model: [NewsRecord]? = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        fillTheModel()
    }
    func fillTheModel() {
        client.invokeAPI("allpublishednews", body: nil, httpMethod: "GET", parameters: nil, headers: nil){ (result, response, error) in
            if let _ = error{
                print (error!)
                return
            }
            if !((self.model?.isEmpty)!) {
                self.model?.removeAll()
            }
            if let _ = result {
                let json = result as! [NewsRecord]
                
                for item in json{
                    self.model?.append(item)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if (model?.isEmpty)! {
            return 0
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (model?.isEmpty)! {
            return 0
        }
        return (model?.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLANONYMOUS", for: indexPath) as! AnonymousNewsTableViewCell
        
        
        let item = model?[indexPath.row]
        // Configure the cell...
        //La imagen de momento nada
        
        cell.titleLbl.text = item?["title"] as! String?
        let avg = item?["avgValuations"] as! Double
        let nbr = item?["numberValuations"] as! Int
        cell.valuationLbl.text = "\(avg) (\(nbr))"
        cell.authorLbl.text = "\(item?["name"] as! String?) \(item?["surname"] as! String?)"
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
