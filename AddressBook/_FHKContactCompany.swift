//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

import Foundation

class _FHKContactCompany: FHKContact {

}

// MARK: Cell Support
extension _FHKContactCompany {
    
    override var localizedDisplayName: String {
        get {
            return companyName
        }
    }
}
