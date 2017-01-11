//
//  LearnViewController.swift
//  LearninGAMeelody
//
//  Created by Алексей Щекочихин on 04/01/2017.
//  Copyright © 2017 Ashe Inc. All rights reserved.
//

import UIKit
import CoreData

class LearnViewController: UIViewController {
    
    
    
    @IBOutlet weak var rhytmAtribute: UISegmentedControl!
    @IBOutlet weak var moodAtribute: UISegmentedControl!
    @IBOutlet weak var melodyAtribute: UISegmentedControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func listenToRandomMelody(_ sender: Any) {
        currentMelodyRules.setRandomMelodyRules()
        print(currentMelodyRules.melody, currentMelodyRules.mode, currentMelodyRules.rhythm)
        playMelody(melody: makeMelodyInNotesOfRules(_melody: Int(currentMelodyRules.melody), _mode: Int(currentMelodyRules.mode), _rhythm: Int(currentMelodyRules.rhythm)))
        
    }

    @IBAction func learnUserAtributes(_ sender: Any) {

        do {
            let userLangDescript = UserLanguageDescription(_rhythm: rhytmAtribute.titleForSegment(at: rhytmAtribute.selectedSegmentIndex)!, _mode: moodAtribute.titleForSegment(at: moodAtribute.selectedSegmentIndex)!, _melody: melodyAtribute.titleForSegment(at: melodyAtribute.selectedSegmentIndex)!)

           print("\(userLangDescript.melodyDescription, userLangDescript.modeDescription, userLangDescript.rhythmDescription)")

                let predicatesForGenExisting = NSPredicate(format: "melodyRule == \(currentMelodyRules.melody) AND modeRule == \(currentMelodyRules.mode) AND rhythmicRule == \(currentMelodyRules.rhythm)")
                let fetchRequestGen: NSFetchRequest<GenRepresentation>
                fetchRequestGen = GenRepresentation.fetchRequest()
                fetchRequestGen.predicate = predicatesForGenExisting
                let resultsGen = try context.fetch(fetchRequestGen)
                
                let predicatesForLangExisting = NSPredicate(format: "melody == '\(userLangDescript.melodyDescription)' AND mood == '\(userLangDescript.modeDescription)'  AND rhythm == '\(userLangDescript.rhythmDescription)'")
                let fetchRequestLang: NSFetchRequest<NaturalLanguageDescription>
                fetchRequestLang = NaturalLanguageDescription.fetchRequest()
                fetchRequestLang.predicate = predicatesForLangExisting
                let resultsLang = try context.fetch(fetchRequestLang)
 
                switch (resultsGen.count, resultsLang.count) {
                case (0, 0):
                   let newGen = createGenRepresentation(melodyRules: currentMelodyRules)
                    newGen.naturalLanguageDescription = createNaturalLangugeDescription(userLangDescription: userLangDescript)
                case (1, 0):
                    resultsGen[0].naturalLanguageDescription = createNaturalLangugeDescription(userLangDescription: userLangDescript)
                case (1, 1):
                    resultsGen[0].naturalLanguageDescription = resultsLang[0]
                case (0, 1):
                    let newGen = createGenRepresentation(melodyRules: currentMelodyRules)
                    newGen.naturalLanguageDescription = resultsLang[0]
                default:
                    print ("smth went wrong")
                }
                coreDataStack.saveContext()
        } catch let error {
            print(error.localizedDescription)
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
