//
//  InspectReportGraphCell.swift
//  CocoaBrain
//
//  Created by Kai on 3/9/25.
//

import UIKit

func getParsedInspect(data: AMO_InspectDetailDataList) -> (tmt: Int, cdt: Int, kdsq: Int, pmt: Int){
    var tmt: Int = 0
    var cdt: Int = 0
    var kdsq: Int = 0
    var pmt: Int = 0
    if let tmtData = data.tmtBw {
        if tmtData.level == "HIGH" {
            tmt = 4
        } else if tmtData.level == "GOOD" {
            tmt = 3
        } else if tmtData.level == "NORMAL" {
            tmt = 2
        } else if tmtData.level == "LOW" {
            tmt = 1
        }
    }
    
    if let cdtData = data.cdt {
        if cdtData.level == "HIGH" {
            cdt = 4
        } else if cdtData.level == "GOOD" {
            cdt = 3
        } else if cdtData.level == "NORMAL" {
            cdt = 2
        } else if cdtData.level == "LOW" {
            cdt = 1
        }
    }
    
    if let kdsqData = data.kdsq {
        if kdsqData.level == "HIGH" {
            kdsq = 4
        } else if kdsqData.level == "GOOD" {
            kdsq = 3
        } else if kdsqData.level == "NORMAL" {
            kdsq = 2
        } else if kdsqData.level == "LOW" {
            kdsq = 1
        }
    }
    
    if let pmtData = data.pmt {
        if pmtData.level == "HIGH" {
            pmt = 4
        } else if pmtData.level == "GOOD" {
            pmt = 3
        } else if pmtData.level == "NORMAL" {
            pmt = 2
        } else if pmtData.level == "LOW" {
            pmt = 1
        }
    }
    
    return (tmt, cdt, kdsq, pmt)
}

class InspectReportGraphCell: UIView {
    
    lazy var tmtView: TopRoundedView = {
        let v = TopRoundedView()
        v.backgroundColor = .brainGraphTMT
        return v
    }()
    
    lazy var cdtView: TopRoundedView = {
        let v = TopRoundedView()
        v.backgroundColor = .brainGraphCDT
        return v
    }()
    
    lazy var gdsqView: TopRoundedView = {
        let v = TopRoundedView()
        v.backgroundColor = .brainGraphGDSQ
        return v
    }()
    
    lazy var pmtView: TopRoundedView = {
        let v = TopRoundedView()
        v.backgroundColor = .brainGraphPMT
        return v
    }()
    
    lazy var dateLabel: UILabel = {
        let v = UILabel()
        v.textColor = .brainTertiary
        v.font = UIFont.textStyleGraphDate()
        return v
    }()
    
    init(data: AMO_InspectDetailDataList) {
        super.init(frame: .zero)
        
        addSubview(tmtView)
        addSubview(cdtView)
        addSubview(gdsqView)
        addSubview(pmtView)
        addSubview(dateLabel)
        
        dateLabel.text = data.date
        
        let data = getParsedInspect(data: data)
        var tmt: Int = data.tmt
        var cdt: Int = data.cdt
        var kdsq: Int = data.kdsq
        var pmt: Int = data.pmt
        
        tmtView.snp.makeConstraints { make in
            make.bottom.equalTo(self).offset(-23)
            make.left.equalTo(self)
            make.width.equalTo(16)
            make.height.equalTo(tmt * 50)
        }
        
        cdtView.snp.makeConstraints { make in
            make.bottom.equalTo(self).offset(-23)
            make.left.equalTo(tmtView.snp.right)
            make.width.equalTo(16)
            make.height.equalTo(cdt * 50)
        }
        
        gdsqView.snp.makeConstraints { make in
            make.bottom.equalTo(self).offset(-23)
            make.left.equalTo(cdtView.snp.right)
            make.width.equalTo(16)
            make.height.equalTo(kdsq * 50)
        }
        
        pmtView.snp.makeConstraints { make in
            make.bottom.equalTo(self).offset(-23)
            make.left.equalTo(gdsqView.snp.right)
            make.width.equalTo(16)
            make.height.equalTo(pmt * 50)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self)
            make.centerX.equalTo(self)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TopRoundedView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCorners()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCorners()
    }
    
    private func setupCorners() {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight], // 왼쪽 상단, 오른쪽 상단만 적용
            cornerRadii: CGSize(width: 2, height: 2) // 코너 반지름
        )
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCorners() // 레이아웃 변경 시 다시 적용
    }
}

class DashedLineView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDashedLine()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDashedLine()
    }
    
    private func setupDashedLine() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.brainDisabled.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [6, 3] // [점 길이, 간격 길이]
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: self.bounds.height / 2)) // 시작점
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height / 2)) // 끝점
        
        shapeLayer.path = path.cgPath
        layer.addSublayer(shapeLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupDashedLine()
    }
}

