/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class HomeViewController: UIViewController {
  
  @IBOutlet weak var view1: CryptoListView!
  @IBOutlet weak var view2: CryptoListView!
  @IBOutlet weak var view3: CryptoListView!
  @IBOutlet weak var headingLabel: UILabel!
  @IBOutlet weak var view1TextLabel: UILabel!
  @IBOutlet weak var view2TextLabel: UILabel!
  @IBOutlet weak var view3TextLabel: UILabel!
  @IBOutlet weak var themeSwitch: UISwitch!
  @IBOutlet weak var mostFallingTextLabel: UILabel!
  @IBOutlet weak var mostRisingTextLabel: UILabel!
  @IBOutlet weak var mostRisingView: CryptoListView!
  @IBOutlet weak var mostFallingView: CryptoListView!
  @IBOutlet weak var mostRisingTitleLabel: UILabel!
  @IBOutlet weak var mostFallingTitleLabel: UILabel!
  
  let cryptoData = DataGenerator.shared.generateData() ?? []
  let themeManager = ThemeManager.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLabels()
    setView1Data()
    setView2Data()
    setView3Data()
    setMostFallingAndMostRisingData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    registerForTheme()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unregisterForTheme()
  }
  
  func setupLabels() {
    headingLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    view1TextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    view2TextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    
    view1TextLabel.numberOfLines = 0
    view2TextLabel.numberOfLines = 0
    view3TextLabel.numberOfLines = 0
  }
  
  func setView1Data() {
    let ownedCryptoCurrencyNames = cryptoData.map(\.name)
    view1TextLabel.text = ownedCryptoCurrencyNames.joined(separator: ", ")
  }
  
  func setView2Data() {
    let currencyNamesWithIncreasedValue = cryptoData.filter {
      $0.currentValue > $0.previousValue }.map(\.name)
    view2TextLabel.text = currencyNamesWithIncreasedValue.joined(separator: ", ")
  }
  
  func setView3Data() {
    let currencyNamesWithDecreasedValue = cryptoData.filter {
      $0.currentValue < $0.previousValue }.map(\.name)
    view3TextLabel.text = currencyNamesWithDecreasedValue.joined(separator: ", ")
  }
  
  func setMostFallingAndMostRisingData() {
    let differenceValues = cryptoData.map { $0.currentValue - $0.previousValue }
    mostRisingTextLabel.text = "\(differenceValues.max() ?? 0)"
    mostFallingTextLabel.text = "\(differenceValues.min() ?? 0)"
  }
  
}

// MARK: - Actions
extension HomeViewController {
  
  @IBAction func onStepperTap(_ sender: UIStepper) {
    view1.cornerRadius = CGFloat(sender.value)
    view2.cornerRadius = CGFloat(sender.value)
    view3.cornerRadius = CGFloat(sender.value)
    mostFallingView.cornerRadius = CGFloat(sender.value)
    mostRisingView.cornerRadius = CGFloat(sender.value)
  }
  
  @IBAction func switchPressed(_ sender: Any) {
    themeManager.set(theme: themeSwitch.isOn ? DarkTheme() : LightTheme())
  }
  
}

// MARK: - Themable
extension HomeViewController: Themable {
  
  func registerForTheme() {
    NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: Constants.NotificationNames.themeChanged, object: nil)
  }
  
  func unregisterForTheme() {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func themeChanged() {
    view1.backgroundColor = themeManager.currentTheme?.widgetBackgroundColor
    view2.backgroundColor = themeManager.currentTheme?.widgetBackgroundColor
    view3.backgroundColor = themeManager.currentTheme?.widgetBackgroundColor
    mostRisingView.backgroundColor = themeManager.currentTheme?.widgetBackgroundColor
    mostFallingView.backgroundColor = themeManager.currentTheme?.widgetBackgroundColor
    
    view1TextLabel.textColor = themeManager.currentTheme?.textColor
    view2TextLabel.textColor = themeManager.currentTheme?.textColor
    view3TextLabel.textColor = themeManager.currentTheme?.textColor
    mostRisingTextLabel.textColor = themeManager.currentTheme?.textColor
    mostFallingTextLabel.textColor = themeManager.currentTheme?.textColor
    mostRisingTitleLabel.textColor = themeManager.currentTheme?.textColor
    mostFallingTitleLabel.textColor = themeManager.currentTheme?.textColor
    
    headingLabel.textColor = themeManager.currentTheme?.textColor
    
    navigationController?.navigationBar.barTintColor = themeManager.currentTheme?.backgroundColor
    
    view.backgroundColor = themeManager.currentTheme?.backgroundColor
  }
  
}
