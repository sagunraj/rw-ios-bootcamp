//
//  ViewController.swift
//  ColorPicker
//
//  Created by Sagun Raj Lage on 5/28/20.
//  Copyright © 2020 Sagun Raj Lage. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak private var colorLabel: UILabel!
    @IBOutlet var sliders: [UISlider]!
    @IBOutlet var sliderValueLabels: [UILabel]!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    /// This variable contains an array of three items. The first one holds the value of first slider,
    ///  the second holds that of the second and the third holds that of the third.
    private var sliderValues: [CGFloat] = [0, 0, 0]
    private var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDefaultColoring()
    }
    
    private func setupView() {
        colorLabel.text = ""
    }
    
    private func setupDefaultColoring() {
        view.backgroundColor = .black
        redLabel.textColor = .white
        greenLabel.textColor = .white
        blueLabel.textColor = .white
        sliderValueLabels.forEach { (label) in
            label.textColor = .white
        }
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        colorLabel.textColor = .white
    }
    
    private func setupColoringForWhiteBackground() {
        redLabel.textColor = .black
        greenLabel.textColor = .black
        blueLabel.textColor = .black
        sliderValueLabels.forEach { (label) in
            label.textColor = .black
        }
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        colorLabel.textColor = .black
    }
    
    func showAlertWithTextField() {
        let alertController = UIAlertController(title: "ColorPicker", message: "Enter the color name",
                                                preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Color name"
            textField.returnKeyType = .done
            textField.delegate = self
            textField.enablesReturnKeyAutomatically = true
            textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
        }
        
        textField = alertController.textFields![0] as UITextField
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: UIAlertAction.Style.default,
                                       handler: { alert -> Void in
                                        self.handleSaveAction()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: UIAlertAction.Style.default,
                                         handler: {
                                            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        alertController.actions[0].isEnabled = false
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func handleSaveAction() {
        if textField.text.hasValue {
            self.colorLabel.text = textField.text
            view.backgroundColor = UIColor(red: sliderValues[0].toColorValue,
                                           green: sliderValues[1].toColorValue,
                                           blue: sliderValues[2].toColorValue,
                                           alpha: 1)
            if sliderValues == [0, 0, 0] {
                setupDefaultColoring()
            } else {
                setupColoringForWhiteBackground()
            }
        }
    }
    
    @objc private func textChanged(_ sender: UITextField) {
        var resp : UIResponder! = sender
        while !(resp is UIAlertController) { resp = resp.next }
        let alert = resp as! UIAlertController
        alert.actions[0].isEnabled = (sender.text != "")
    }
    
}

// MARK: - Actions
extension ViewController {
    
    @IBAction func onInfoButtonTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let infoVC = storyboard.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        self.present(infoVC, animated: true, completion: nil)
    }
    
    @IBAction func onResetTap(_ sender: UIButton) {
        sliderValues = [0, 0, 0]
        colorLabel.text = ""
        sliderValueLabels.forEach { (label) in
            label.textColor = .white
            label.text = "0"
        }
        sliders.forEach { (slider) in
            slider.value = 0
        }
        setupDefaultColoring()
    }
    
    @IBAction func onSetColorTap(_ sender: UIButton) {
        showAlertWithTextField()
    }
    
    @IBAction func onSliderChange(_ sender: UISlider) {
        sliderValues[sender.tag] = sender.value.toCGFloat
        sliderValueLabels[sender.tag].text = "\(sliderValues[sender.tag].toInt)"
    }
    
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSaveAction()
        dismiss(animated: true, completion: nil)
        return false
    }
    
}
