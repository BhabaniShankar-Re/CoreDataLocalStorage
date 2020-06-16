//
//  DeviceListTableViewController.swift
//  CoreDataProjcet
//
//  Created by Bhabani on 13/06/20.
//  Copyright © 2020 Bhabani. All rights reserved.
//

import UIKit
import CoreData

class DeviceListTableViewController: UITableViewController {
    
    var devices: [Device]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedList: Set<IndexPath> = []
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let fetchRequest: NSFetchRequest<Device> = Device.fetchRequest()
        
        do{
            try devices = context.fetch(fetchRequest)
            
        }catch let error as NSError{
            print(error.localizedDescription, error.code, error.userInfo)
        }
        
        self.tableView.reloadData()
        
    }
    
    
    func devicesFromSelectedList()-> [Device]?{
        var devices = [Device]()
        
        for index in selectedList{
            let device = self.devices?[index.row]
            devices.append(device!)
        }
        return devices
    }
    
    
    @IBAction func slectOwnerAction(_ sender: Any) {
        
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return devices?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath) as! DeviceListTableViewCell
        
        let dev = devices![indexPath.row]
        cell.deviceNameLabel.text = dev.deviceType + " " + dev.deviceName
        cell.ownerNameLabel.text = dev.owner?.name

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedList.contains(indexPath){
            selectedList.remove(indexPath)
        }else{
            selectedList.insert(indexPath)
        }
        print(selectedList)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        if segue.identifier == "selectOwnerSegue"{
            let viewContr = segue.destination as! PersonListViewController
            viewContr.selectedDevice = devicesFromSelectedList()
        }
    }
    

}
