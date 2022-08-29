//
//  SaveViewController.swift
//  notebook
//
//  Created by Yigit on 29.08.2022.
//

import UIKit
import CoreData
class SaveViewController: UIViewController {
    
    
    @IBOutlet weak var txtName: UITextField!
    
    
    @IBOutlet weak var txtNote: UITextField!
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnSaveClicked(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newNote = NSEntityDescription.insertNewObject(forEntityName: "Database", into: context)
        
        newNote.setValue(txtName.text, forKey: "name")
        newNote.setValue(txtNote.text, forKey: "note")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateString = dateFormatter.string(from: datePicker.date)
        newNote.setValue(dateString, forKey: "date")
        
        newNote.setValue(UUID(), forKey: "id")
        
        do{
            try context.save()
            
        }catch{
            print("Error")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newData"), object: nil)
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
}
