//
//  PersonListViewController.swift
//  CoreDataProjcet
//
//  Created by Bhabani on 16/06/20.
//  Copyright © 2020 Bhabani. All rights reserved.
//

import UIKit
import CoreData

class PersonListViewController: UITableViewController {
    
    var viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var persons: [Person]?
    var selectedPerson: Person?
    var selectedDevice: [Device]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
         persons = try? viewContext.fetch(fetchRequest)
    }
    
    @IBAction func performSaveAction(_ sender: Any) {
        guard let selectPerson = selectedPerson, let devices = selectedDevice, !devices.isEmpty else {
            return
        }
        print(selectPerson, devices)
        selectPerson.addToDevice(NSSet(array: devices))
        
        try? viewContext.save()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return persons?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
        let person = persons?[indexPath.row].name
        cell.textLabel?.text = person

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPerson = persons?[indexPath.row]
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if persons?.count == 1{
            return false
        }else{
            return true
        }
        
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let person = persons!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            viewContext.delete(person)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
        try? viewContext.save()
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        print("lets move")
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row == 0{
            return .insert
        }else{
            return .delete
        }
    }
    

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
