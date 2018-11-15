//
//  UserListTableViewController.swift
//  UserMap
//
//  Created by Max Rybak on 11/15/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class UserListTableViewController: UITableViewController {

    var ref: DatabaseReference!
    var userLocations: [DataSnapshot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        ref.child("UserLocation").observe(.childAdded) {
            (snapshot) in
            self.userLocations.append(snapshot)
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userLocations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let snapshot = userLocations[indexPath.row]
        if let userDictionary = snapshot.value as? [String:AnyObject] {
            if let email = userDictionary["email"] as? String {
                cell.textLabel?.text = email
            }
        }
        return cell
    }
    
}