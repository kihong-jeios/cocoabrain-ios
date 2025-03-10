//
//  InspectMainViewModel.swift
//  CocoaBrain
//
//  Created by Kai on 3/9/25.
//

import UIKit

protocol InspectMainViewModelDelegate: AnyObject {
    func didUpdateUserInspects()
}

class InspectMainViewModel: NSObject {

    weak open var delegate: InspectMainViewModelDelegate?
    
}
