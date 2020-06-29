//
//  ViewController.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    var alertController: UIAlertController!
    var selectedImage: UIImage!
    
    let viewModel: MediaPostsViewModel = MediaPostsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    func setUpTableView() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "TextTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "textPostCell")
        tableview.register(UINib(nibName: "ImageTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "imagePostCell")
    }
    
}

// MARK: - Actions
extension ViewController {
    
    @IBAction func didPressCreateTextPostButton(_ sender: Any) {
        alertController = UIAlertController(title: "Birdie", message: "Enter post details",
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
                                            (action : UIAlertAction!) -> Void in
                                            self.selectedImage = nil
        })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func handleSaveAction() {
        guard let textFields =  alertController.textFields else { return }
        guard let userNameText = textFields[0].text,
            !userNameText.isEmpty else {
                selectedImage = nil
                alertController.dismiss(animated: true) {
                    self.showAlertWithOk(and: "Please make sure you enter your username.")
                }
                return
        }
        if let imageForPost = selectedImage {
            viewModel.mediaPostsHandler.addImagePost(imagePost: ImagePost(textBody: textFields[1].text,
                                                                userName: userNameText,
                                                                timestamp: Date(),
                                                                image: imageForPost))
            selectedImage = nil
        } else {
            viewModel.mediaPostsHandler.addTextPost(textPost: TextPost(textBody: textFields[1].text,
                                                             userName: userNameText,
                                                             timestamp: Date()))
        }
        alertController.dismiss(animated: true) {
            self.tableview.reloadData()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSaveAction()
        return true
    }
    
    @IBAction func didPressCreateImagePostButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
}

// MARK: - UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate
extension ViewController: UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        selectedImage = image
        dismiss(animated: true) {
            self.didPressCreateTextPostButton(self)
        }
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mediaPostsHandler.mediaPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentMediaPost = viewModel.mediaPostsHandler.mediaPosts[indexPath.row]
        switch viewModel.getPostType(currentMediaPost) {
        case .image:
            guard let imagePostCell = tableView.dequeueReusableCell(withIdentifier: "imagePostCell")
                as? ImageTableViewCell else { fatalError("Unable to dequeue cell.") }
            imagePostCell.setupCell(with: currentMediaPost as! ImagePost) // used force unwrapping since we're sure that it's an ImagePost
            return imagePostCell
        case .text:
            guard let textPostCell = tableView.dequeueReusableCell(withIdentifier: "textPostCell")
                as? TextTableViewCell else { fatalError("Unable to dequeue cell.") }
            textPostCell.setupCell(with: currentMediaPost)
            return textPostCell
        }
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.mediaPostsHandler.removePost(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}



