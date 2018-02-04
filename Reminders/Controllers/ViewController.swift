//
//  ViewController.swift
//  Reminders
//
//  Created by Robert Wais on 2/2/18.
//  Copyright © 2018 Robert Wais. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var reminders = [Reminder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        ////////////////////////////
        
        ///////////////////////////
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Yes")
        super.viewWillAppear(animated)
        self.fetchObjects()
    }
    func fetchObjects(){
        
        self.fetch{ (complete) in
            if complete{
                if reminders.count < 1{
                    tableView.isHidden = true
                }else{
                    tableView.isHidden = false
                }
            }
            
        }
        tableView.reloadData()
}
    


    @IBAction func nxtBtnPressed(_ sender: Any) {
        guard let createReminder = storyboard?.instantiateViewController(withIdentifier: "CreateReminder")else{return}
        present(createReminder, animated: true, completion: nil)
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "remCell") as? ReminderCellTableViewCell else{
            return UITableViewCell()}
        let reminder = reminders[indexPath.row]
        
        cell.configureCell(name: reminder.nameDescription!, when: reminder.periodTime!,type: .very)
        return cell
        }
    
    
    //for editing table
    func tableView(_: UITableView, canEditRowAt: IndexPath)-> Bool{
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleted = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            tableView.beginUpdates()
            self.removeReminder(atIndexPath: indexPath)
            self.fetchObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
        deleted.backgroundColor = UIColor.red
        return [deleted]
    }
}

extension ViewController {
    func fetch(completion: (_ complete: Bool)->()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        let fetchRequest = NSFetchRequest<Reminder>(entityName: "Reminder")
        
        do{
            reminders = try managedContext.fetch(fetchRequest)
            print("Fetched Success")
            completion(true)
        } catch {
            debugPrint("Error \(error.localizedDescription)")
            completion(false)
        }
    }
    
   
    
    func removeReminder(atIndexPath indexPath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        managedContext.delete(reminders[indexPath.row])
        do{
            try managedContext.save()
            print("Deleted")
        } catch {
            debugPrint("Didnt work \(error.localizedDescription)")
        }
    }
}


