//
//  UserNewsTableViewController.swift
//  practicambaasfrontend
//
//  Created by Alma Martinez on 30/10/16.
//  Copyright © 2016 Alma Martinez. All rights reserved.
//

import UIKit

typealias NewsRecord = Dictionary<String, AnyObject>

public enum PublishedStatus: Int {
    case Draft = 0
    case Ready = 1
    case Published = 2
}

class UserNewsTableViewController: UITableViewController {
    
    var client: MSClient = MSClient(applicationURL: URL(string: "https://kc-mbaas-pr-almams.azurewebsites.net")!)
    var model: Dictionary<PublishedStatus,[NewsRecord]>? = [.Draft:[],.Ready:[],.Published:[]]
    var author: [AnyHashable:AnyObject]?
    
    func doLoginInFacebook() {
        client.login(withProvider: "facebook", parameters: nil, controller: self, animated: true) { (user,error) in
            if let _ = error{
                print(error!)
                return
            }
            
            if let _ = user{
                self.getRegisteredUser()
                self.fillTheModel()
            }
        }
    }
    
    func getRegisteredUser() {
        let tableMS = client.table(withName: "Authors")
        
        let predicate = NSPredicate(format: "id = '\(client.currentUser?.userId!)'")
        tableMS.read(with: predicate, completion: { (results, error) in
            if let _ = error{
                print (error!)
                return
            }
            if let _ = results {
                self.author = results?.items?.first as [AnyHashable : AnyObject]?
                
            }
            else{
                self.presentPopUpLogin()
            }
            
        })
    }
    
    func presentPopUpLogin(){
        let alert = UIAlertController(title: "Registro de Usuario", message: "Escribe tu nombre de autor", preferredStyle: .alert)
        
        
        let actionOk = UIAlertAction(title: "OK", style: .default) { (alertAction) in
            let nameAutor = alert.textFields![0] as UITextField
            let secondName = alert.textFields![1] as UITextField
            
            
            self.inserNewAutor(nameAutor.text!, secondName: secondName.text!)
            
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel){ (alertaAction) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(actionOk)
        alert.addAction(actionCancel)
        alert.addTextField { (textField) in
            
            textField.placeholder = "Introduce tu nombre "
            
        }
        
        alert.addTextField {(textfield2) in
            textfield2.placeholder = "Introduce tus apellidos"
        }
        present(alert, animated: true, completion: nil)
    }
    
    func inserNewAutor(_ name: String, secondName: String) {
        
        let tableMS = client.table(withName: "Authors")
        
        tableMS.insert(["name" : name, "surname": secondName]) { (result, error) in
            
            if let _ = error {
                print(error!)
                return
            }
            print(result!)
            
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = client.currentUser{
            fillTheModel()
        } else {
            self.doLoginInFacebook()
        }
       
    }
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func fillTheModel() {
        client.invokeAPI("newsbyuser", body: nil, httpMethod: "GET", parameters: nil, headers: nil){ (result, response, error) in
            if let _ = error{
                print (error!)
                return
            }
            if !((self.model?.isEmpty)!) {
                self.model=[.Draft:[],.Ready:[],.Published:[]]
            }
            if let _ = result {
                let json = result as! [NewsRecord]
                
                for item in json{
                    let status = PublishedStatus(rawValue: item["publishStatus"] as! Int)
                    self.model?[status!]?.append(item)
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if (model?.isEmpty)! {
            return 0
        }
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (model?.isEmpty)! {
            return 0
        }
        return (model?[PublishedStatus(rawValue: section)!]?.count)!
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let status = PublishedStatus(rawValue: section)!
        switch status{
        case .Draft:
            return "Draft"
        case .Ready:
            return "Ready"
        case .Published:
            return "Published"
        
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLNEWS", for: indexPath) as! AuthNewsTableViewCell
        let status = PublishedStatus(rawValue: indexPath.section)!
        
        let item = model?[status]?[indexPath.row]
        // Configure the cell...
        //La imagen de momento nada
        
        cell.titleNews.text = item?["title"] as! String?
        let avg = item?["avgValuations"] as! Double
        let nbr = item?["numberValuations"] as! Int
        cell.valuationNews.text = "Valoración media: \(avg) (\(nbr) valoraciones)"
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        let status = PublishedStatus(rawValue: indexPath.section)!
        if status == .Published{
            return false
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let status = PublishedStatus(rawValue: indexPath.section)!

        let item = model?[status]?[indexPath.row]
        
        performSegue(withIdentifier: "detailNews", sender: item)
    }

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailNews" {
            let vc = segue.destination as? NewsWritterViewController
            
            vc?.client = client
            vc?.model = sender as? NewsRecord
            
        }
    }
    

}
