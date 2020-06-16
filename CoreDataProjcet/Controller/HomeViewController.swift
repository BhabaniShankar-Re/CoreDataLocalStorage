//
//  ViewController.swift
//  CoreDataProjcet
//
//  Created by Bhabani on 09/06/20.
//  Copyright © 2020 Bhabani. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    @IBOutlet weak var personlistTable: UITableView!
    
    @IBOutlet weak var trialTextField: UITextField!
    var persons: [Person]?
    
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        //By normal use of nsmanagedobject
       
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        persons = try? viewContext.fetch(fetchRequest)
        personlistTable.reloadData()
    }

    @IBAction func editButton(_ sender: Any) {
        let fetchRequers = NSFetchRequest<NSFetchRequestResult>(entityName: "Device")
               if let result = try? viewContext.fetch(fetchRequers) as? [NSManagedObject]{
                   for value in result{
                       let name = value.value(forKey: "deviceName")
                       let type = value.value(forKey: "deviceType")
                       print(name as Any, type as Any)
                   }
               }
               
        guard let reqResult = try? viewContext.fetch(Person.fetchRequest()) as? [Person] else { return }
        
        for value in reqResult{
            print(value.name)
        }
               
    }
    @IBAction func addPersonButton(_ sender: Any) {
        let alert = UIAlertController(title: "Person", message: "Add a Person", preferredStyle: .alert)
        alert.addTextField { (nameTextField) in
            nameTextField.placeholder = "Full Name"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            let name = alert.textFields![0].text
            let entity = NSEntityDescription.entity(forEntityName: "Person", in: self.viewContext)
            let person = NSManagedObject.init(entity: entity!, insertInto: self.viewContext) as! Person
            person.name = name!
            do{
                try self.viewContext.save()
            }catch let error as NSError{
                print(error.localizedDescription, error.userInfo)
            }
            self.viewWillAppear(false)

        }
        alert.addAction(addAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
        
       
    }
    @IBAction func addDeviceButton(_ sender: Any) {
        let alert = UIAlertController(title: "Device", message: "Add new Device", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Device Type"
        }
        alert.addTextField { (nameTextField) in
            nameTextField.placeholder = "Device Name"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            let deviceType = alert.textFields?[0].text ?? "Iphone"
            let deviceName = alert.textFields?[1].text ?? ""
            let entity = NSEntityDescription.entity(forEntityName: "Device", in: self.viewContext)!
            
            let device = NSManagedObject(entity: entity, insertInto: self.viewContext)
            device.setValue(deviceName, forKey: "deviceName")
            device.setValue(deviceType, forKey: "deviceType")
            do{
                try self.viewContext.save()
            }catch let error as NSError{
                print(error.localizedDescription, error.userInfo, error.code)
            } //throws error but not handel here.
        }
        alert.addAction(addAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func textFieldTouchUpinside(_ sender: Any) {
        print("ohoo aaa....")
    }

    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        persons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonDetailsCell", for: indexPath)
        let person = persons?[indexPath.row].name
        cell.textLabel?.text = person
        return cell
    }
    
    
}

struct feedback {
    let question: String
    let answer: String
    let rating: Double
    
    init(q: String = "", a: String = "", r: Double = 0.0) {
        question = q
        answer = a
        rating = r
    }
}

class Human: NSObject, Codable{
    let name: String
    let age: Int
    
}

