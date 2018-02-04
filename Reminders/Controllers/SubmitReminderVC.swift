//
//  SubmitReminderVC.swift
//  Reminders
//
//  Created by Robert Wais on 2/3/18.
//  Copyright © 2018 Robert Wais. All rights reserved.
//

import UIKit

class SubmitReminderVC: UIViewController, UITextViewDelegate {
    @IBOutlet var displayTxt: UITextView!
    @IBOutlet var submitBtn: UIButton!
    @IBOutlet var whenTxt: UILabel!
    
    var viewDescription: String!
    var viewImpType: importanceType!
    
    func initData(description: String, type: importanceType){
        print("Here")
        self.viewDescription = description
        print("Here1 \(description)")
        self.viewImpType = type
        print("Here2")
        print("Here3")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayTxt.delegate = self
        displayTxt.text = viewDescription
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitBtnPressed(_ sender: Any) {
        self.saveReminder{ (complete) in
            if complete{
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    //pass value and return this value
    func saveReminder(completion: (_ finished: Bool)->()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let reminder = Reminder(context: managedContext)
        reminder.nameDescription = viewDescription
        reminder.periodTime = "Monday"
        reminder.reminderType = viewImpType.rawValue
        
        do{
           try managedContext.save()
            print("SUCCCESSSS")
           completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
