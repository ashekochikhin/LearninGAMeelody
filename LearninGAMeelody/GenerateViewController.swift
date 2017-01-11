//
//  GenerateViewController.swift
//  LearninGAMeelody
//
//  Created by Алексей Щекочихин on 04/01/2017.
//  Copyright © 2017 Ashe Inc. All rights reserved.
//

import UIKit
import CoreData

class GenerateViewController: UIViewController {

    @IBOutlet weak var rhythmToGenerate: UISegmentedControl!
    @IBOutlet weak var moodToGenerate: UISegmentedControl!
    @IBOutlet weak var melodyToGenerate: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func generateMelody(_ sender: Any) {
        do{
            let desirableUserSettings = UserLanguageDescription(_rhythm: rhythmToGenerate.titleForSegment(at: rhythmToGenerate.selectedSegmentIndex)!, _mode: moodToGenerate.titleForSegment(at: moodToGenerate.selectedSegmentIndex)!, _melody: melodyToGenerate.titleForSegment(at: melodyToGenerate.selectedSegmentIndex)!)
            let predicatesForLangDesirable = NSPredicate(format: "melody == '\(desirableUserSettings.melodyDescription)' AND mood == '\(desirableUserSettings.modeDescription)'  AND rhythm == '\(desirableUserSettings.rhythmDescription)'")
            let fetchRequestLang: NSFetchRequest<NaturalLanguageDescription>
            fetchRequestLang = NaturalLanguageDescription.fetchRequest()
            fetchRequestLang.predicate = predicatesForLangDesirable
            let resultsLang = try context.fetch(fetchRequestLang)
            if resultsLang.count == 0 {
                let genToPlay = MelodyRules()
                playMelody(melody: makeMelodyInNotesOfRules(_melody: Int(genToPlay.melody), _mode: Int(genToPlay.mode), _rhythm: Int(genToPlay.rhythm)))
            } else {
                let arrayOfGens = resultsLang[0].genRepresentation?.allObjects as! [GenRepresentation]
                let amountOfParents = arrayOfGens.count
                
                
                let genMam = arrayOfGens[Int(arc4random_uniform(UInt32(amountOfParents)))]
                let genMamToFuck = MelodyRules(_rhythm: genMam.rhythmicRule, _mode: genMam.modeRule, _melody: genMam.melodyRule)
                print("mam: ", genMamToFuck.melody, genMamToFuck.mode, genMamToFuck.rhythm)
                
                let genPap = arrayOfGens[Int(arc4random_uniform(UInt32(amountOfParents)))]
                let genPapToFuck = MelodyRules(_rhythm: genPap.rhythmicRule, _mode: genPap.modeRule, _melody: genPap.melodyRule)
                print("pap: ", genPapToFuck.melody, genPapToFuck.mode, genPapToFuck.rhythm)
                
                let genToPlay = MelodyRules(_rhythm: genPapToFuck.rhythm, _mode: genMamToFuck.mode, _melody: genMamToFuck.melody)
               playMelody(melody: makeMelodyInNotesOfRules(_melody: Int(genToPlay.melody), _mode: Int(genToPlay.mode), _rhythm: Int(genToPlay.rhythm)))
            }
            
        
        
        
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
