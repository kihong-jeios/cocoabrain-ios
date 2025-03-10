//
//  InspectReportCell.swift
//  CocoaBrain
//
//  Created by Kai on 3/9/25.
//

import UIKit

class InspectReportCell: UITableViewCell, ReusableView {

    lazy var backView: UIView = {
        let v = UIView()
        v.theBorderColor = .brainBorder
        v.theBorderWidth = 1
        v.theCornerRadius = 8
        return v
    }()
    
    lazy var dateLabel: UILabel = {
        let v = UILabel()
        v.font = .textStyleResultDate()
        v.textColor = .brainTertiary
        v.textAlignment = .left
        return v
    }()
    
    lazy var tmtGradeView: GradeView = {
        let v = GradeView()
        return v
    }()
    
    lazy var cdtGradeView: GradeView = {
        let v = GradeView()
        return v
    }()
    
    lazy var kdsqGradeView: GradeView = {
        let v = GradeView()
        return v
    }()
    
    lazy var pmtGradeView: GradeView = {
        let v = GradeView()
        return v
    }()
    
    lazy var stackView: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.spacing = 55
        v.alignment = .center
        v.distribution = .fillEqually
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
        backView.addSubview(stackView)
        backView.snp.makeConstraints { make in
            make.top.left.equalTo(contentView)
            make.right.equalTo(contentView).offset(-60)
            make.height.equalTo(80)
        }
        
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(tmtGradeView)
        stackView.addArrangedSubview(cdtGradeView)
        stackView.addArrangedSubview(kdsqGradeView)
        stackView.addArrangedSubview(pmtGradeView)
        
        stackView.snp.makeConstraints { make in
//            make.edges.equalToSuperview().inset(8)
            make.left.equalTo(backView).offset(30)
            make.right.equalTo(backView).offset(-30)
            make.top.bottom.equalTo(backView)
        }
    }
    
    func configure(with data: AMO_InspectDetailDataList) {
        dateLabel.text = data.date
        
        let data = getParsedInspect(data: data)
        let tmt: Int = data.tmt
        let cdt: Int = data.cdt
        let kdsq: Int = data.kdsq
        let pmt: Int = data.pmt
        
        if tmt > 0 {
            tmtGradeView.icon.image = getIcon(value: tmt)
            tmtGradeView.title.text = getTitle(value: tmt)
        }
        
        if cdt > 0 {
            cdtGradeView.icon.image = getIcon(value: cdt)
            cdtGradeView.title.text = getTitle(value: cdt)
        }
        
        if kdsq > 0 {
            kdsqGradeView.icon.image = getIcon(value: kdsq)
            kdsqGradeView.title.text = getTitle(value: kdsq)
        }
        
        if pmt > 0 {
            pmtGradeView.icon.image = getIcon(value: pmt)
            pmtGradeView.title.text = getTitle(value: pmt)
        }
        
    }
    
    func getIcon(value: Int) -> UIImage? {
        if value == 1 {
            return UIImage(named: "ico_small_grade_4")
        } else if value == 2 {
            return UIImage(named: "ico_small_grade_3")
        } else if value == 3 {
            return UIImage(named: "ico_small_grade_2")
        } else if value == 4 {
            return UIImage(named: "ico_small_grade_1")
        } else {
            return nil
        }
    }
    
    func getTitle(value: Int) -> String {
        if value == 1 {
            return "낮음"
        } else if value == 2 {
            return "보통"
        } else if value == 3 {
            return "좋음"
        } else if value == 4 {
            return "높음"
        } else {
            return ""
        }
    }
   
    
}

class GradeView: UIView {
    
    lazy var icon: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "ico_small_grade_4")
        return v
    }()
    
    lazy var title: UILabel = {
        let v = UILabel()
        v.textColor = .brainTertiary
        v.font = .textStyleGrade()
        v.text = "좋음"
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(icon)
        addSubview(title)
        
        icon.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(self)
            make.width.equalTo(30)
            make.height.equalTo(28)
        }
        
        title.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(icon.snp.right).offset(19)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
