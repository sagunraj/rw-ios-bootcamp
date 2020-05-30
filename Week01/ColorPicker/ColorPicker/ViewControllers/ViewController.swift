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
    @IBOutlet weak var firstSliderLabel: UILabel!
    @IBOutlet weak var secondSliderLabel: UILabel!
    @IBOutlet weak var thirdSliderLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    /// This variable contains an array of three items. The first one holds the value of first slider,
    ///  the second holds that of the second and the third holds that of the third.
    private var sliderValues: [CGFloat] = [0, 0, 0]
    private var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRGBView()
        setupDefaultColoring()
    }
    
    private func setupRGBView() {
        colorLabel.text = ""
        firstSliderLabel.text = "Red"
        secondSliderLabel.text = "Green"
        thirdSliderLabel.text = "Blue"
        sliders.forEach { (slider) in
            slider.minimumValue = 0
            slider.maximumValue = 255
            slider.value = 0
        }
        sliderValueLabels.forEach { (label) in
            label.text = "0"
        }
    }
    
    private func setupHSBView() {
        colorLabel.text = ""
        firstSliderLabel.text = "Hue"
        secondSliderLabel.text = "Saturation"
        thirdSliderLabel.text = "Brightness"
        sliders.enumerated().forEach { (index, slider) in
            slider.maximumValue = index == 0 ? 360 : 100
            slider.minimumValue = 0
            slider.value = 0
        }
        sliderValueLabels.forEach { (label) in
            label.text = "0"
        }
    }
    
    private func setupDefaultColoring() {
        view.backgroundColor = .black
        firstSliderLabel.textColor = .white
        secondSliderLabel.textColor = .white
        thirdSliderLabel.textColor = .white
        sliderValueLabels.forEach { (label) in
            label.textColor = .white
        }
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        colorLabel.textColor = .white
    }
    
    private func setupColoringForWhiteBackground() {
        firstSliderLabel.textColor = .black
        secondSliderLabel.textColor = .black
        thirdSliderLabel.textColor = .black
        sliderValueLabels.forEach { (label) in
            label.textColor = .black
        }
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        colorLabel.textColor = .black
    }
    
    func showAlertWithTextField() {
        let alertController = UIAlertController(title: "Color Picker", message: "Enter the color name",
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
            if segmentedControl.selectedSegmentIndex == 0 {
                view.backgroundColor = UIColor(red: sliderValues[0].toRGBValue,
                                                          green: sliderValues[1].toRGBValue,
                                                          blue: sliderValues[2].toRGBValue,
                                                          alpha: 1)
            } else {
                view.backgroundColor = UIColor(hue: sliderValues[0].toHueValue,
                                               saturation: sliderValues[1].toSaturationBrightnessValue,
                                               brightness: sliderValues[2].toSaturationBrightnessValue,
                                               alpha: 1)
            }
           
            if segmentedControl.selectedSegmentIndex == 0 {
                sliderValues == [0, 0, 0] ? setupDefaultColoring() : setupColoringForWhiteBackground()
            } else {
                sliderValues[2] <= 50 ? setupDefaultColoring() : setupColoringForWhiteBackground()
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
    
    @IBAction func onSCModeChange(_ sender: UISegmentedControl) {
        setupDefaultColoring()
        sender.selectedSegmentIndex == 0 ? setupRGBView() : setupHSBView()
    }
    
    @IBAction func onInfoButtonTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let infoVC = storyboard.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        infoVC.isColorModeRGB = segmentedControl.selectedSegmentIndex == 0
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
