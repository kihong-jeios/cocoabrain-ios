//
//  InspectReportViewModel.swift
//  CocoaBrain
//
//  Created by Kai on 3/6/25.
//

import UIKit
import Alamofire
import PromiseKit

protocol InspectReportViewModelDelegate: AnyObject {
    func didUpdateUserInspects()
}

class InspectReportViewModel: NSObject {

    weak open var delegate: InspectReportViewModelDelegate?
    let inspectProvider = InspectProvider()
    var inspectList: [AMO_InspectDetailDataList] = []
    
    func getUserInspects(userId: String) {
        inspectProvider.getInspect(userId: userId).done { inspects in
            self.inspectList = inspects.data.inspectList
            self.delegate?.didUpdateUserInspects()
            
        }.catch { error in
            
        }
    }
}
