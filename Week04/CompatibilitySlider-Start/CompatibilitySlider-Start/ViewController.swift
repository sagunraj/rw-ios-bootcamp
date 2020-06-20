//
//  ViewController.swift
//  CompatibilitySlider-Start
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var compatibilityItemLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var questionLabel: UILabel!
    
    let compatibilityItems = ["Cats", "Dogs", "Rabbits", "Fishes", "Ducks", "Chickens"]
    var currentItemIndex = 0
    
    var person1 = Person(id: 1, items: [:])
    var person2 = Person(id: 2, items: [:])
    var currentPerson: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPerson = person1
        setupView()
    }
    
    private func setupView() {
        questionLabel.text = "User \(currentPerson!.id), what do you think about..."
        compatibilityItemLabel.text = compatibilityItems.first
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        print(sender.value)
    }
    
    @IBAction func didPressNextItemButton(_ sender: Any) {
        let currentItem = compatibilityItems[currentItemIndex]
        currentPerson?.items[currentItem] = slider.value.rounded()
        
        if currentItemIndex != compatibilityItems.count - 1 {
            currentItemIndex += 1
            compatibilityItemLabel.text = compatibilityItems[currentItemIndex]
            slider.setValue(3, animated: true)
        } else {
            if currentPerson?.id == 1 {
                showAlertWithOk(and: "It's User \(person2.id)'s turn.") {
                    self.resetSystem(with: self.person2)
                }
            } else if currentPerson?.id == 2 {
                var compatibilityResultString = calculateCompatibility()
                compatibilityResultString = "You two are \(compatibilityResultString) compatible."
                showAlertWithOk(with: "Results",
                                and: compatibilityResultString) {
                                    self.resetSystem(with: self.person1)
                }
            }
        }
    }
    
    private func resetSystem(with person: Person) {
        currentPerson = person
        currentItemIndex = 0
        setupView()
        slider.setValue(3, animated: true)
    }
    
    func calculateCompatibility() -> String {
        // If diff 0.0 is 100% and 5.0 is 0%, calculate match percentage
        var percentagesForAllItems: [Double] = []
        
        for (key, person1Rating) in person1.items {
            let person2Rating = person2.items[key] ?? 0
            let difference = abs(person1Rating - person2Rating)/5.0
            percentagesForAllItems.append(Double(difference))
        }
        
        let sumOfAllPercentages = percentagesForAllItems.reduce(0, +)
        let matchPercentage = sumOfAllPercentages/Double(compatibilityItems.count)
        print(matchPercentage, "%")
        let matchString = 100 - (matchPercentage * 100).rounded()
        return "\(matchString)%"
    }
    
}

