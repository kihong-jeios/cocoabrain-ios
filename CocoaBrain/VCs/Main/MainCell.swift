//
//  MainCell.swift
//  CocoaBrain
//
//  Created by Kai on 2/27/25.
//

import UIKit

let userInfoLabelWidth = k320-(180+80+150+50+60+20+20)

class MainCell: UITableViewCell, ReusableView {
    
    lazy var backView: UIView = {
        let v = UIView()
        v.theBorderColor = .brainBorder
        v.theBorderWidth = 1
        v.theCornerRadius = 8
        return v
    }()
    
    lazy var medicalNoLabel: UILabel = {
        let v = UILabel()
        v.font = .textStyleGridBody1()
        v.textColor = .brainTertiary
        v.textAlignment = .center
        return v
    }()

    lazy var userInfoLabel: UILabel = {
        let v = UILabel()
        v.font = .textStyleGridBody3()
        v.textColor = .brainTertiary
        v.textAlignment = .center
        return v
    }()

    lazy var testCountLabel: UILabel = {
        let v = UILabel()
        v.font = .textStyleGridBody3()
        v.textColor = .brainTertiary
        v.textAlignment = .center
        return v
    }()

    lazy var inspectDateLabel: UILabel = {
        let v = UILabel()
        v.font = .textStyleGridBody4()
        v.textColor = .brainTertiary
        v.textAlignment = .center
        return v
    }()

    lazy var resultButton: UIButton = {
        let v = UIButton()
        v.setTitle("보기", for: .normal)
        v.setTitleColor(.brainPrimary, for: .normal)
        v.titleLabel?.font = .systemFont(ofSize: 14)
        v.theBorderColor = .brainPrimary
        v.theBorderWidth = 1
        v.theCornerRadius = 6
        return v
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        contentView.addSubview(backView)
        backView.addSubview(medicalNoLabel)
        backView.addSubview(userInfoLabel)
        backView.addSubview(testCountLabel)
        backView.addSubview(inspectDateLabel)
        backView.addSubview(resultButton)
        
        backView.snp.makeConstraints { make in
            make.top.left.equalTo(contentView)
            make.right.equalTo(contentView).offset(-60)
            make.height.equalTo(80)
        }
        
        medicalNoLabel.snp.makeConstraints { make in
            make.left.equalTo(backView)
            make.width.equalTo(180)
            make.centerY.equalTo(backView)
        }
        
        userInfoLabel.snp.makeConstraints { make in
            make.left.equalTo(medicalNoLabel.snp.right).offset(4)
            make.width.equalTo(userInfoLabelWidth)
            make.centerY.equalTo(backView)
        }
        
        testCountLabel.snp.makeConstraints { make in
            make.left.equalTo(userInfoLabel.snp.right).offset(4)
            make.width.equalTo(80)
            make.centerY.equalTo(backView)
        }
        
        inspectDateLabel.snp.makeConstraints { make in
            make.left.equalTo(testCountLabel.snp.right).offset(4)
            make.width.equalTo(150)
            make.centerY.equalTo(backView)
        }
        
        resultButton.snp.makeConstraints { make in
            make.left.equalTo(inspectDateLabel.snp.right).offset(4)
            make.width.equalTo(50)
            make.centerY.equalTo(backView)
        }
    }

    func configure(with data: AMO_UserInspectListData) {
        let genderString = Gender(rawValue: data.gender.rawValue)!.rawValue
        
        medicalNoLabel.text = data.medicalNo
        userInfoLabel.text = "\(data.name) | \(genderString) | \(data.birth)"
        testCountLabel.text = "\(data.count)회"
        inspectDateLabel.text = data.inspectDate ?? "-"
        resultButton.isHidden = data.count == 0
    }
}
