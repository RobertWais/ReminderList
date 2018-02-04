//
//  CreateReminderVC.swift
//  Reminders
//
//  Created by Robert Wais on 2/3/18.
//  Copyright © 2018 Robert Wais. All rights reserved.
//

import UIKit

class CreateReminderVC: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var textBox: UITextView!
    @IBOutlet var whenLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //extension function that was written
        nextBtn.bindToKeyboard()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion:nil)
        }
    
    
    //change to submit btn
    @IBAction func nextBtnPressed(_ sender: Any) {
        //Initialize data
        //add checker later
        self.saveReminder{ (complete) in
            if complete{
                dismiss(animated: true, completion: nil)
            }
          }
        }
    
    func saveReminder(completion: (_ finished: Bool)->()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let theDate = datePicker.date.dayWeek()
        print("The date: \(theDate)")
        
        let reminder = Reminder(context: managedContext)
        reminder.nameDescription = textBox.text
        reminder.periodTime = theDate
        reminder.reminderType = importanceType.very.rawValue
        
        do{
            try managedContext.save()
            print("SUCCCESSSS")
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
        
    }
}

//Extension for formatting date into,.. ex. Saturday 10:59 PM
extension Date {
    func dayWeek() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "EEEE h:mm a"
        return dateFormat.string(from: self)
    }
}




