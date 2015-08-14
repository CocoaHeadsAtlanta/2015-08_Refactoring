//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

import UIKit

class ContactsDataSource: NSObject {
    static let CellReuseIdentifier = "Contact Cell"
    
    let contacts: [ FHKContact ]
    let configure: (FHKContact, UITableViewCell) -> ()
    
    init(contacts: [ FHKContact ], configure: (FHKContact, UITableViewCell) -> ())
    {
        self.contacts = contacts
        self.configure = configure
    }
    
    func contactForIndexPath(indexPath: NSIndexPath) -> FHKContact
    {
        return contacts[indexPath.row]
    }
}

extension ContactsDataSource: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        assert(section == 0, "Unexpected section number: \(section)")
        return contacts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(ContactsDataSource.CellReuseIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        let contact = contacts[indexPath.row]
        
        configure(contact, cell)
        
        return cell
    }
}
