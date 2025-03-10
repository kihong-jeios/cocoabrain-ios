//
//  UserInfoView.swift
//  CocoaBrain
//
//  Created by Kai on 3/6/25.
//

import UIKit

struct UserInfoViewData {
    var gender: Gender = .male
    var userId: String = ""
    var userName: String = ""
    var birth: String = ""
}

class UserInfoView: UIView {

    lazy var userIcon: UIImageView = {
        let v = UIImageView()
        return v
    }()
    
    lazy var userIdLabel: UILabel = {
        let v = UILabel()
        v.font = .textStyleBody4()
        v.textColor = .brainBackground
        return v
    }()
    
    lazy var userInfoLabel: UILabel = {
        let v = UILabel()
        v.font = .textStyleBody1()
        v.textColor = .brainBackground
        return v
    }()
    
    var data: UserInfoViewData
    init(data: UserInfoViewData) {
        self.data = data
        super.init(frame: .zero)
        setupUI()
        
        if data.gender == .male {
            userIcon.image = UIImage(named: "ico_male")
        } else {
            userIcon.image = UIImage(named: "ico_female")
        }
        
        userIdLabel.text = data.userId
        let birth = data.birth.convertDateFormat() ?? ""
        userInfoLabel.text = data.userName + " | " + data.gender.rawValue + " | " + birth
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .brainPrimary
        addSubview(userIcon)
        addSubview(userIdLabel)
        addSubview(userInfoLabel)
        
        userIcon.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(44)
        }
        
        userIdLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(14)
            make.left.equalTo(userIcon.snp.right).offset(20)
        }
        
        userInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(userIdLabel.snp.bottom).offset(8)
            make.left.equalTo(userIcon.snp.right).offset(20)
        }
    }
    
   
}
