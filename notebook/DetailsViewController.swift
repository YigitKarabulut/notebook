//
//  DetailsViewController.swift
//  notebook
//
//  Created by Yigit on 29.08.2022.
//

import UIKit
import CoreData
class DetailsViewController: UIViewController {
    
    
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    
    @IBOutlet weak var lblNote: UILabel!
    
   
    var chosenId : UUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lblNote.numberOfLines = 0
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Database")
        
        let idString = chosenId?.uuidString
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject]{
                    if let name = result.value(forKey: "name") as? String{
                        lblName.text = name
                    }
                    if let note = result.value(forKey: "note") as? String{
                        lblNote.text = note
                    }
                    if let date = result.value(forKey: "date") as? String{
                        lblDate.text = date
                    }
                }
            }
            
        }catch{
            print("Error")
        }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    

    
}
