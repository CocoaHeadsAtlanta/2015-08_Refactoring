//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

import Foundation

class _FHKContactPerson: FHKContact {

}

// MARK: - Cell Support
extension _FHKContactPerson {
    
    override var localizedDisplayName: String {
        get {
            var displayName = ""
            if (firstName != nil) {
                displayName = displayName + firstName
            }
            if (lastName != nil) {
                if (displayName != "") {
                    displayName = displayName + " "
                }
                
                displayName = displayName + lastName
            }

            return displayName
        }
    }
}
