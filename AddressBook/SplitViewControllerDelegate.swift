//
//  Copyright (c) 2015 Fish Hook LLC. All rights reserved.
//

import UIKit

class SplitViewControllerDelegate: NSObject {
    
}

extension SplitViewControllerDelegate: UISplitViewControllerDelegate {
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController!, ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool
    {
        return true;
    }
}
