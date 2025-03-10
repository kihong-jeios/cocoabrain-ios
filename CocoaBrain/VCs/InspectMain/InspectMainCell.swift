//
//  InspectMainCell.swift
//  CocoaBrain
//
//  Created by Kai on 3/9/25.
//

import UIKit

class InspectMainCell: UICollectionViewCell, ReusableView {
    
    lazy var backView: UIView = {
        let v = UIView()
        v.theBorderColor = .brainPrimary
        v.theBorderWidth = 1
        v.theCornerRadius = 8
        return v
    }()
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .textStyleTitle()
        v.textColor = .brainPrimary
        v.textAlignment = .left
        return v
    }()
    
    lazy var descLabel: UILabel = {
        let v = UILabel()
        v.font = .textStyleBody2()
        v.textColor = .brainTertiary
        v.textAlignment = .left
        return v
    }()
    
    lazy var chevronIcon: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "ico_testselect_arrowright")
        return v
    }()
    
    lazy var imageView: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "ico_testselect_arrowright")
        return v
    }()
    
    lazy var dateLabel: UILabel = {
        let v = UILabel()
        v.font = .textStyleBody4()
        v.textColor = .brainPopupBtnText
        v.textAlignment = .left
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(backView)
        backView.addSubview(titleLabel)
        backView.addSubview(descLabel)
        backView.addSubview(chevronIcon)
        backView.addSubview(imageView)
        backView.addSubview(dateLabel)
        
        backView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backView).offset(16)
            make.left.equalTo(backView).offset(16)
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(backView).offset(16)
        }
        
        chevronIcon.snp.makeConstraints { make in
            make.top.equalTo(backView).offset(16)
            make.right.equalTo(backView).offset(-16)
            make.size.equalTo(28)
        }
        
        imageView.snp.makeConstraints { make in
            make.bottom.equalTo(backView)
            make.right.equalTo(backView)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backView).offset(-12)
            make.left.equalTo(backView).offset(16)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
