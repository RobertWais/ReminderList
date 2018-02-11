//
//  CreateReminderVC.swift
//  Reminders
//
//  Created by Robert Wais on 2/3/18.
//  Copyright © 2018 Robert Wais. All rights reserved.
//

import UIKit
import UserNotifications

class CreateReminderVC: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var textBox: UITextView!
    @IBOutlet var whenLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///
        print("Here")
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (granted, error) in
            if granted {
                print("This application has access")
            } else {
                print(error?.localizedDescription)
            }
        }
        
        ///
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
        
        
        ////
        let temp = datePicker.calendar.dateComponents([.day,.month,.year,.minute,.second], from: datePicker.date)
        
        createNofication(dateComponent: temp, stringNotif: textBox.text, completion: {success in
            if success {
                print("Successful")
            }
        })
        
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
    
    func createNofication(dateComponent: DateComponents, stringNotif: String, completion: @escaping (_ Success: Bool) -> ()) {
        let notification = UNMutableNotificationContent()
        notification.title = "Reminder"
        notification.subtitle = ""
        notification.body = stringNotif
        
        let notifTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        let request = UNNotificationRequest(identifier: "datePickerNotif", content: notification, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error)
                completion(false)
            } else {
                completion(true)
            }
        })
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




