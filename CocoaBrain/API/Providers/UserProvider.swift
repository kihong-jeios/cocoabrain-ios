//
//  UserProvider.swift
//  CocoaBrain
//
//  Created by Kai on 3/3/25.
//

import UIKit
import PromiseKit
import Alamofire

enum SortDirection: String {
    case ASC = "ASC"
    case DESC = "DESC"
}

enum SortType: String {
    case medicalNo = "MedicalNo"
    case userName = "UserName"
    case count = "Count"
    case inspectDate = "InspectDate"
}

enum Gender: String {
    case male = "M"
    case female = "F"
}

enum EduLevel: String, CaseIterable {
    case elementary = "ELEMENTARY"
    case middle = "MIDDLE"
    case highschool = "HIGHSCHOOL"
    case bachelors = "BACHELORS"
    case master = "MASTERS"
    
    func string() -> String {
        switch self {
        case .elementary:
            return "초등학교"
        case .middle:
            return "중학교"
        case .highschool:
            return "고등학교"
        case .bachelors:
            return "대학교"
        case .master:
            return "대학원 이상"
        }
    }

}

enum GuardianType: String, CaseIterable {
    case partner = "PARTNER"
    case son = "SON"
    case daughter = "DAUGHTER"
    case father = "FATHER"
    case mother = "MOTHER"
    case grandchildren = "GRANDCHILDREN"
    case relative = "RELATIVE"
    case friend = "FRIEND"
    
    func string() -> String {
        switch self {
        case .partner:
            return "배우자"
        case .son:
            return "아들"
        case .daughter:
            return "딸"
        case .father:
            return "아버지"
        case .mother:
            return "어머니"
        case .grandchildren:
            return "손주"
        case .relative:
            return "친척"
        case .friend:
            return "지인"
        }
    }

}

enum InspectType: String {
    case TMTBW = "TMTBW"
    case CDT = "CDT"
    case GDSQ = "GDSQ"
    case PMT = "PMT"
}

enum InspectStatus: String {
    case PAUSED = "PAUSED"
    case COMPLETED = "COMPLETED"
}

class UserProvider: NSObject {

    func getAllUsers(page: Int, sortDirection: SortDirection, sortType: SortType, keyword: String) -> Promise<AMO_UserInspects> {
        var params: Parameters = [:]
        params["page"] = page
        params["sortDirection"] = sortDirection.rawValue
        params["sortBy"] = sortType.rawValue
        params["keyword"] = keyword
        let worker = UserWorker.init(type: .getUsers(params: params))
        return Promise { seal in
            worker.request.validate().responseObject { (response: AFDataResponse<AMO_UserInspects>) in
                switch response.result {
                case .success(let value):
                    seal.fulfill(value)
                    
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func getUser(userId: String) -> Promise<AMO_User> {
        let params: Parameters = [:]
        let worker = UserWorker.init(type: .getUser(userId: userId, params: params))
        return Promise { seal in
            worker.request.validate().responseObject { (response: AFDataResponse<AMO_User>) in
                switch response.result {
                case .success(let value):
                    seal.fulfill(value)
                    
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func addUser(user: AMO_UserData) -> Promise<AMO_Login> {
        var params: Parameters = [:]
        params["medicalNo"] = user.medicalNo
        params["name"] = user.name
        params["enabled"] = true
        params["gender"] = user.gender.rawValue
        params["birth"] = user.birth
        if let eduLevel = user.eduLevel {
            params["eduLevel"] = eduLevel.rawValue
        }
        params["hasGraduated"] = user.hasGraduated
        params["contact"] = user.contact
        if let guardianName = user.guardianName {
            params["guardianName"] = guardianName
        }
        if let guardianType = user.guardianType {
            params["guardianType"] = guardianType.rawValue
        }
        params["guardianContact"] = user.guardianContact
        params["centerId"] = user.centerId
        params["centerName"] = user.centerName
        
        let worker = UserWorker.init(type: .addUser(params: params))
        return Promise { seal in
            worker.request.validate().responseObject { (response: AFDataResponse<AMO_Login>) in
                switch response.result {
                case .success(let value):
                    seal.fulfill(value)
                    
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func editUser(userId: String,
                  name: String,
                  gender: Gender,
                  birth: String,
                  eduLevel: EduLevel,
                  hasGraduated: Bool,
                  contact: String,
                  guardianName: String?,
                  guardianType: GuardianType?,
                  guardianContact: String?) -> Promise<AMO_Login> {
        var params: Parameters = [:]
        params["name"] = name
        params["gender"] = gender.rawValue
        params["birth"] = birth
        params["eduLevel"] = eduLevel.rawValue
        params["hasGraduated"] = hasGraduated
        params["contact"] = contact
        
        if let guardianName = guardianName {
            params["guardianName"] = guardianName
        }
        if let guardianType = guardianType {
            params["guardianType"] = guardianType
        }
        if let guardianContact = guardianContact {
            params["guardianContact"] = guardianContact
        }
        
        let worker = UserWorker.init(type: .editUser(userId: userId, params: params))
        return Promise { seal in
            worker.request.validate().responseObject { (response: AFDataResponse<AMO_Login>) in
                switch response.result {
                case .success(let value):
                    seal.fulfill(value)
                    
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
}
