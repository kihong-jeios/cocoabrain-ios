//
//  MainViewModel.swift
//  CocoaBrain
//
//  Created by Kai on 2/27/25.
//

import UIKit
import Alamofire
import PromiseKit

protocol MainViewModelDelegate: AnyObject {
    func didUpdateListData()
}

class MainViewModel: NSObject {
    
    weak open var delegate: MainViewModelDelegate?
    let userProvider = UserProvider()
    
    var currentPage: Int = 0
    var sortDirection: SortDirection = .ASC
    var sortType: SortType = .inspectDate
    
    var listData: [AMO_UserInspectListData] = []
    
    func prepare() {
        getUsers()
    }
    
    func getUsers() {
        userProvider.getAllUsers(page: currentPage, sortDirection: sortDirection, sortType: sortType, keyword: "").done { data in
            self.listData = data.data.list
            self.delegate?.didUpdateListData()
            
        }.catch { error in
            print(error)
        }
    }
    
}
