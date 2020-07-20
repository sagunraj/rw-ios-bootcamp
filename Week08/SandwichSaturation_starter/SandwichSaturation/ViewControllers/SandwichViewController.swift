//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

protocol SandwichDataSource {
    func saveSandwich(_: SandwichData, needsAutoRefresh: Bool)
}

class SandwichViewController: UITableViewController, SandwichDataSource {
    let searchController = UISearchController(searchResultsController: nil)
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var fetchedRC: NSFetchedResultsController<Sandwich>!
    private var query = ""
    
    var sandwiches = [Sandwich]()
    var filteredSandwiches = [Sandwich]()
    
    private func refresh() {
        let hasLoadedSandwichFromJSON = UserDefaults.standard.bool(forKey: AppConstants.UserDefaultsConstants.hasLoadedSandwichFromJSON)
        if hasLoadedSandwichFromJSON {
            let request = Sandwich.fetchRequest() as NSFetchRequest<Sandwich>
            let sort = NSSortDescriptor(key: #keyPath(Sandwich.name),
                                        ascending: true,
                                        selector: #selector(NSString.caseInsensitiveCompare(_:)))
            request.sortDescriptors = [sort]
            fetchedRC = NSFetchedResultsController(fetchRequest: request,
                                                   managedObjectContext: context,
                                                   sectionNameKeyPath: nil,
                                                   cacheName: nil)
            do {
                try fetchedRC.performFetch()
                guard let objects = fetchedRC.fetchedObjects else { return }
                sandwiches = objects
            } catch let error as NSError {
                print("Could not fetch. \(error.localizedDescription)")
            }
        } else {
            loadSandwiches()
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddView(_:)))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = editButtonItem
        setupSearchController()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Filter Sandwiches"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = SauceAmount.allCases.map { $0.rawValue }
        searchController.searchBar.delegate = self
        
        let selectedFilterIndex = UserDefaults.standard.integer(forKey: AppConstants.UserDefaultsConstants.selectedFilterIndex)
        searchController.searchBar.selectedScopeButtonIndex = selectedFilterIndex
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    func loadSandwiches() {
        guard let sandwichJSONURL = Bundle.main.url(forResource: "sandwiches",
                                                    withExtension: "json") else { return }
        let decoder = JSONDecoder()
        do {
            let sandwichData = try Data(contentsOf: sandwichJSONURL)
            let sandwiches = try decoder.decode([SandwichData].self, from: sandwichData)
            sandwiches.forEach { (sandwich) in
                saveSandwich(sandwich, needsAutoRefresh: false)
            }
            UserDefaults.standard.set(true,
                                      forKey: AppConstants.UserDefaultsConstants.hasLoadedSandwichFromJSON)
            refresh()
        } catch let error {
            print("Unable to fetch sandwich data \(error.localizedDescription)")
        }
    }
    
    func saveSandwich(_ sandwich: SandwichData, needsAutoRefresh: Bool) {
        let sandwichEntity = Sandwich(entity: Sandwich.entity(),
                                      insertInto: context)
        let sauceAmountModel = SauceAmountModel(entity: SauceAmountModel.entity(),
                                                insertInto: context)
        sauceAmountModel.sauceAmount = sandwich.sauceAmount
        sandwichEntity.name = sandwich.name
        sandwichEntity.sauceAmount = sauceAmountModel
        sandwichEntity.imageName = sandwich.imageName
        appDelegate.saveContext()
        if needsAutoRefresh {
            refresh()
        }
    }
    
    @objc
    func presentAddView(_ sender: Any) {
        performSegue(withIdentifier: "AddSandwichSegue", sender: self)
    }
    
    // MARK: - Search Controller
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String,
                                    sauceAmount: SauceAmount? = nil) {
        let request = Sandwich.fetchRequest() as NSFetchRequest<Sandwich>
        var sauceAmountPredicate: NSPredicate
        var compoundPredicate: NSPredicate
        guard let sauceAmount = sauceAmount else { return }
        switch sauceAmount {
        case .any:
            sauceAmountPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [
                NSPredicate(format: "sauceAmount.sauceAmountString = %@", SauceAmount.none.rawValue),
                NSPredicate(format: "sauceAmount.sauceAmountString = %@", SauceAmount.tooMuch.rawValue)
            ])
        case .none, .tooMuch:
            sauceAmountPredicate = NSPredicate(format: "sauceAmount.sauceAmountString = %@", sauceAmount.rawValue)
        }
        if searchText.isEmpty {
            compoundPredicate = sauceAmountPredicate
        } else {
            let searchTextPredicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText)
            compoundPredicate = NSCompoundPredicate(type: .and,
                                                    subpredicates: [searchTextPredicate, sauceAmountPredicate])
        }
        request.predicate = compoundPredicate
        let sort = NSSortDescriptor(key: #keyPath(Sandwich.name),
                                    ascending: true,
                                    selector: #selector(NSString.caseInsensitiveCompare(_:)))
        request.sortDescriptors = [sort]
        fetchedRC = NSFetchedResultsController(fetchRequest: request,
                                               managedObjectContext: context,
                                               sectionNameKeyPath: nil,
                                               cacheName: nil)
        do {
            try fetchedRC.performFetch()
            guard let objects = fetchedRC.fetchedObjects else { return }
            filteredSandwiches = objects
        } catch let error as NSError {
            print("Could not fetch. \(error.localizedDescription)")
        }
        tableView.reloadData()
    }
    
    var isFiltering: Bool {
        let searchBarScopeIsFiltering =
            searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive &&
            (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredSandwiches.count : sandwiches.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichCell", for: indexPath) as? SandwichCell
            else { return UITableViewCell() }
        
        let sandwich = isFiltering ?
            filteredSandwiches[indexPath.row] :
            sandwiches[indexPath.row]
        cell.thumbnail.image = UIImage.init(imageLiteralResourceName: sandwich.imageName)
        cell.nameLabel.text = sandwich.name
        cell.sauceLabel.text = sandwich.sauceAmount.sauceAmountString
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let sandwich = fetchedRC.object(at: indexPath)
            context.delete(sandwich)
            appDelegate.saveContext()
            refresh()
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing && !searchController.isActive {
            return .delete
        }
        return .none
    }
    
}

// MARK: - UISearchResultsUpdating
extension SandwichViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let sauceAmount = SauceAmount(rawValue:
            searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
        
        filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
    }
}

// MARK: - UISearchBarDelegate
extension SandwichViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar,
                   selectedScopeButtonIndexDidChange selectedScope: Int) {
        let sauceAmount = SauceAmount(rawValue:
            searchBar.scopeButtonTitles![selectedScope])
        UserDefaults.standard.set(selectedScope,
                                  forKey: AppConstants.UserDefaultsConstants.selectedFilterIndex)
        filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
    }
    
}
