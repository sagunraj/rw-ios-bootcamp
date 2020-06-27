//
//  ViewController.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    var alertController: UIAlertController!
    let mediaPostsHandler = MediaPostsHandler.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mediaPostsHandler.getPosts()
        setUpTableView()
    }
    
    func setUpTableView() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: "textPostCell")
        tableview.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "imagePostCell")
    }
    
}

// MARK: - Actions
extension ViewController {
    
    @IBAction func didPressCreateTextPostButton(_ sender: Any) {
        alertController = UIAlertController(title: "Birdie", message: "Create Text Post",
                                                preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Username"
            textField.returnKeyType = .next
            textField.enablesReturnKeyAutomatically = true
        }
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Message"
            textField.returnKeyType = .done
            textField.delegate = self
            textField.enablesReturnKeyAutomatically = true
        }
        
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
            
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func handleSaveAction() {
        guard let textFields =  alertController.textFields else { return }
        guard let userNameText = textFields[0].text,
            !userNameText.isEmpty else {
                alertController.dismiss(animated: true) {
                    self.showAlertWithOk(and: "Please make sure you enter your username.")
                }
                return
        }
        mediaPostsHandler.addTextPost(textPost: TextPost(textBody: textFields[1].text,
                                                         userName: userNameText,
                                                         timestamp: Date()))
        alertController.dismiss(animated: true) {
            self.tableview.reloadData()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSaveAction()
        return true
    }
    
    @IBAction func didPressCreateImagePostButton(_ sender: Any) {
        
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaPostsHandler.mediaPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentMediaPostItem = mediaPostsHandler.mediaPosts[indexPath.row]

        if let mediaPostItem = currentMediaPostItem as? ImagePost {
            guard let imagePostCell = tableView.dequeueReusableCell(withIdentifier: "imagePostCell")
                as? ImageTableViewCell else { fatalError("Unable to dequeue cell.") }
            imagePostCell.setupCell(with: mediaPostItem)
            return imagePostCell
        } else {
            guard let textPostCell = tableView.dequeueReusableCell(withIdentifier: "textPostCell")
                as? TextTableViewCell else { fatalError("Unable to dequeue cell.") }
            textPostCell.setupCell(with: currentMediaPostItem)
            return textPostCell
        }
    }
    
}



