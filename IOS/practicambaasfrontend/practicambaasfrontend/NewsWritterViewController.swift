//
//  NewsWritterViewController.swift
//  practicambaasfrontend
//
//  Created by Alma Martinez on 30/10/16.
//  Copyright © 2016 Alma Martinez. All rights reserved.
//

import UIKit

class NewsWritterViewController: UIViewController {

    var client: MSClient?
    var model: NewsRecord?
    
    @IBOutlet weak var titleTxt: UITextField!{
        didSet{
            if isNewPost(){
                titleTxt.text = ""
                doneBtn.isEnabled = false
            }else{
                doneBtn.isEnabled = true
            }
        }
    }
    
    @IBOutlet weak var imgPost: UIImageView!{
        didSet{
            
        }
    }
    
    
    @IBOutlet weak var contentPostTxt: UITextView!{
        didSet{
            if isNewPost(){
                contentPostTxt.text = ""

            }
        }
    }
    
    
    @IBOutlet weak var publishBtn: UIBarButtonItem!{
        didSet{
            if isNewPost(){
                publishBtn.isEnabled = false
            }
        }
    }
    
    @IBOutlet weak var doneBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isNewPost(){
            self.title = "New Post"
            publishBtn.isEnabled = false
            doneBtn.isEnabled = false
        }else{
            self.title = model!["title"] as? String
            self.titleTxt.text = model!["title"] as? String
            self.titleTxt.isEnabled = false
            self.contentPostTxt.text = model!["content"] as? String
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPicture(_ sender: UIBarButtonItem) {
        // Crear una instancia de UIImagePicker
        let picker = UIImagePickerController()
        
        // Configurarlo
        if UIImagePickerController.isCameraDeviceAvailable(.rear){
            picker.sourceType = .camera
        }else{
            // me conformo con el carrete
            picker.sourceType = .photoLibrary
        }
        
        
        picker.delegate = self
        
        // Mostrarlo de forma modal
        self.present(picker, animated: true) {
            // Por si quieres hacer algo nada más
            // mostrarse el picker
        }

    }

    @IBAction func editingTitle(_ sender: UITextField) {
        doneBtn.isEnabled = !(sender.text?.isEmpty)!
        
        if(isNewPost()){
            if !(sender.text?.isEmpty)!{
                self.title = sender.text
            }
            else{
                self.title = "New Post"
            }
        }
    }
    @IBAction func publishPost(_ sender: UIBarButtonItem) {
        let tableAz = client?.table(withName: "News")
        
        model!["publishStatus"] = PublishedStatus.Ready as AnyObject?
        
        tableAz?.update(model!, completion: { (result, error) in
            if let _ = error{
                print(error!)
                return
            }
            print(result!)
        })
        
        _ = self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func savePost(_ sender: UIBarButtonItem) {
        if isNewPost(){
            insertPost()
        }else{
            updatePost()
        }
        _ = self.navigationController?.popViewController(animated: true)
    }

        
    
    
    func isNewPost() -> Bool {
        return model == nil
    }
    func updatePost() {
        let tableAz = client?.table(withName: "News")
        
        model!["content"] = self.contentPostTxt.text as AnyObject?
        
        tableAz?.update(model!, completion: { (result, error) in
            if let _ = error{
                print(error!)
                return
            }
            print(result!)
        })
        print(model!)
        
        self.dismiss(animated: true, completion: nil)
    }
    func insertPost() {
        let tableAz = client?.table(withName: "News")
        
        model = NewsRecord()
        
        model!["title"] = self.titleTxt.text as AnyObject?
        model!["content"] = self.contentPostTxt.text as AnyObject?
        model!["publishStatus"] = PublishedStatus.Draft.rawValue as AnyObject?
        model!["locateLongitude"] = -1 as AnyObject?
        model!["locateLatitude"] = -1 as AnyObject?
        
        print(model!)
        
        tableAz?.insert(model!, completion: { (result, error) in
            if let _ = error{
                print(error!)
                return
            }
            print(result!)
        })
        
        
    }

}
//MARK: - Delegates
extension NewsWritterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        // Redimensionarla al tamaño de la pantalla
        // deberes (está en el online)
    // model.photo?.image = info[UIImagePickerControllerOriginalImage] as! UIImage?
        
        // Quitamos de enmedio al picker
        self.dismiss(animated: true) {
            //
        }
    }
}
