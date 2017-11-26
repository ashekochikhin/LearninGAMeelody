//
//  ServiceViewController.swift
//  LearninGAMeelody
//
//  Created by Алексей Щекочихин on 07/01/2017.
//  Copyright © 2017 Ashe Inc. All rights reserved.
//

import UIKit
import CoreData

class ServiceViewController: UIViewController {

    @IBOutlet weak var progressOfLearning: UILabel!
    @IBOutlet weak var progresOfLearningLine: UIProgressView!
    
    @IBOutlet weak var lernedDescriptLabl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateProgress()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func earseDatabas(_ sender: Any) {
        deleteAllDataGen()
        deleteAllDataLang()
        coreDataStack.saveContext()
        updateProgress()
    }

    @IBAction func upgateRrogress(_ sender: Any) {
        updateProgress()
    }
    func updateProgress(){
        progressOfLearning.text = "На данный момент \(numberOfGensLearned()) генов из \(totalNumberOfGens()) имеют соответсвующее описание на естественном языке"
        
        progresOfLearningLine.progress = Float(numberOfGensLearned()/totalNumberOfGens())
        
        lernedDescriptLabl.text = ("Изучено \(numberOfDescriptLearned()) описаний на естественном языке из 27")
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
