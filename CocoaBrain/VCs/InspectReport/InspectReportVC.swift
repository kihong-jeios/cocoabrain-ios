//
//  InspectReportVC.swift
//  CocoaBrain
//
//  Created by Kai on 3/6/25.
//

import UIKit
import Charts

class InspectReportVC: UIViewController {
    
    let viewModel: InspectReportViewModel = InspectReportViewModel()
    
    lazy var backButton: UIButton = {
        let v = UIButton()
        v.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        v.setBackgroundImage(UIImage(named: "ico_back"), for: .normal)
        v.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return v
    }()
    
    lazy var moreButton: UIButton = {
        let v = UIButton()
        v.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        v.setBackgroundImage(UIImage(named: "ico_more"), for: .normal)
        v.addTarget(self, action: #selector(moreButtonPressed), for: .touchUpInside)
        return v
    }()
    
    lazy var contentView: UIView = {
        let v = UIView()
        return v
    }()

    lazy var userInfoView: UserInfoView = {
        var userInfoViewData = UserInfoViewData()
        userInfoViewData.userId = String(inspectData.id)
        userInfoViewData.birth = inspectData.birth
        userInfoViewData.gender = inspectData.gender
        userInfoViewData.userName = inspectData.name
        let v = UserInfoView(data: userInfoViewData)
        return v
    }()
    
    lazy var chartBackView: UIView = {
        let v = UIView()
        return v
    }()
    
    lazy var chartScrollView: UIScrollView = {
        let v = UIScrollView()
        v.showsHorizontalScrollIndicator = false
        return v
    }()
    
    lazy var chartTitleLabel: UILabel = {
        let v = UILabel()
        v.text = "뇌인지건강지수 그래프"
        v.textColor = .brainTertiary
        v.font = UIFont.textStyleTitle()
        return v
    }()
    
    lazy var dateRangeView: DateRangeView = {
        let v = DateRangeView()
        return v
    }()
    
    lazy var chartContentView: UIView = {
        let v = UIView()
        return v
    }()
    
    lazy var line1 = DashedLineView()
    lazy var line2 = DashedLineView()
    lazy var line3 = DashedLineView()
    lazy var line4 = DashedLineView()
    lazy var line5 = DashedLineView()
    
    lazy var highLabel: UILabel = {
        let v = UILabel()
        v.text = "높음"
        v.font = UIFont.textStyleGraphGrade()
        v.textColor = .brainPopupBtnText
        v.textAlignment = .right
        return v
    }()
    
    lazy var goodLabel: UILabel = {
        let v = UILabel()
        v.text = "좋음"
        v.font = UIFont.textStyleGraphGrade()
        v.textColor = .brainPopupBtnText
        v.textAlignment = .right
        return v
    }()
    
    lazy var normalLabel: UILabel = {
        let v = UILabel()
        v.text = "보통"
        v.font = UIFont.textStyleGraphGrade()
        v.textColor = .brainPopupBtnText
        v.textAlignment = .right
        return v
    }()
    
    lazy var lowLabel: UILabel = {
        let v = UILabel()
        v.text = "낮음"
        v.font = UIFont.textStyleGraphGrade()
        v.textColor = .brainPopupBtnText
        v.textAlignment = .right
        return v
    }()
    
    lazy var chartBottomIndicatorView: UIView = {
        let v = UIView()
        
        let icons = [UIView(), UIView(), UIView(), UIView()]
        let labels = ["흑백 선 긋기", "시계그리기", "인지기능평가", "기억력"]
        let colors = [UIColor.brainGraphTMT, UIColor.brainGraphCDT, UIColor.brainGraphGDSQ, UIColor.brainGraphPMT]
        
        var previousLabel: UILabel? = nil
        
        for (index, icon) in icons.enumerated() {
            icon.layer.cornerRadius = 2
            icon.backgroundColor = colors[index]
            
            let label = UILabel()
            label.font = .textStyleGraphDate()
            label.textColor = .brainTertiary
            label.text = labels[index]
            
            v.addSubview(icon)
            v.addSubview(label)
            
            icon.snp.makeConstraints { make in
                make.centerY.equalTo(v)
                make.size.equalTo(15)
                if let previous = previousLabel {
                    make.left.equalTo(previous.snp.right).offset(10)
                } else {
                    make.left.equalTo(v)
                }
            }
            label.snp.makeConstraints { make in
                make.centerY.equalTo(v)
                make.left.equalTo(icon.snp.right).offset(4)
            }
            
            previousLabel = label
        }
        
        v.snp.makeConstraints { make in
            if let lastLabel = previousLabel {
                make.right.equalTo(lastLabel.snp.right)
            }
        }
        return v
    }()
    
    lazy var headerView: UIView = {
        let v = UIView()
        v.backgroundColor = .brainSecondary
        v.layer.cornerRadius = 8
        
        let titles = ["검사일", "흑백 선 긋기", "시계 그리기", "인지기능평가", "기억력"]
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        for title in titles {
            let label = UILabel()
            label.text = title
            label.font = .textStyleGridTitle()
            label.textColor = .brainTertiary
            label.textAlignment = .center
            stackView.addArrangedSubview(label)
        }
        
        v.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        return v
    }()
    
    lazy var tableView: UITableView = {
        let v = UITableView()
        v.delegate = self
        v.dataSource = self
        v.separatorColor = .clear
        v.register(InspectReportCell.self, forCellReuseIdentifier: InspectReportCell.reuseIdentifier)
        v.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: -30)
        return v
    }()

    
    
    var inspectData: AMO_UserInspectListData
    init(inspectData: AMO_UserInspectListData) {
        self.inspectData = inspectData
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        title = "뇌인지건강검사 결과"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreButton)
        
        view.backgroundColor = .white
        view.addSubview(contentView)
        contentView.addSubview(userInfoView)
        contentView.addSubview(chartBackView)
        chartBackView.addSubview(chartScrollView)
        chartBackView.addSubview(chartTitleLabel)
        chartBackView.addSubview(dateRangeView)
        chartScrollView.addSubview(chartContentView)
        chartContentView.addSubview(line1)
        chartContentView.addSubview(line2)
        chartContentView.addSubview(line3)
        chartContentView.addSubview(line4)
        chartContentView.addSubview(line5)
        chartBackView.addSubview(highLabel)
        chartBackView.addSubview(goodLabel)
        chartBackView.addSubview(normalLabel)
        chartBackView.addSubview(lowLabel)
        chartBackView.addSubview(chartBottomIndicatorView)
        
        contentView.addSubview(headerView)
        contentView.addSubview(tableView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        userInfoView.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(86)
        }
        
        chartBackView.snp.makeConstraints { make in
            make.top.equalTo(userInfoView.snp.bottom).offset(28)
            make.centerX.equalTo(contentView)
            make.left.equalTo(contentView).offset(30)
            make.right.equalTo(contentView).offset(-30)
            make.height.equalTo(404)
        }
        
        chartScrollView.snp.makeConstraints { make in
            make.top.equalTo(chartBackView).offset(102)
            make.left.equalTo(chartBackView).offset(24+60)
            make.right.equalTo(chartBackView).offset(-24)
            make.height.equalTo(278)
        }
        
        chartTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(chartBackView).offset(34)
            make.left.equalTo(chartBackView).offset(24)
        }
        
        dateRangeView.snp.makeConstraints { make in
            make.centerY.equalTo(chartTitleLabel)
            make.width.equalTo(324)
            make.height.equalTo(46)
            make.right.equalTo(chartBackView).offset(-24)
        }
        
        line1.snp.makeConstraints { make in
            make.left.right.equalTo(chartContentView)
            make.bottom.equalTo(chartContentView).offset(-66)
            make.height.equalTo(1)
        }
        
        line2.snp.makeConstraints { make in
            make.bottom.equalTo(line1).offset(-50)
            make.left.right.equalTo(chartContentView)
            make.height.equalTo(1)
        }
        
        line3.snp.makeConstraints { make in
            make.bottom.equalTo(line2).offset(-50)
            make.left.right.equalTo(chartContentView)
            make.height.equalTo(1)
        }
        
        line4.snp.makeConstraints { make in
            make.bottom.equalTo(line3).offset(-50)
            make.left.right.equalTo(chartContentView)
            make.height.equalTo(1)
        }
        
        line5.snp.makeConstraints { make in
            make.bottom.equalTo(line4).offset(-50)
            make.left.right.equalTo(chartContentView)
            make.height.equalTo(1)
        }
        
        chartBottomIndicatorView.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.bottom.equalTo(chartBackView).offset(-24)
            make.centerX.equalTo(chartBackView)
        }
        
        highLabel.snp.makeConstraints { make in
            make.centerY.equalTo(line5)
            make.left.equalTo(chartBackView).offset(24)
            make.width.equalTo(40)
        }
        
        goodLabel.snp.makeConstraints { make in
            make.centerY.equalTo(line4)
            make.left.equalTo(chartBackView).offset(24)
            make.width.equalTo(40)
        }
        
        normalLabel.snp.makeConstraints { make in
            make.centerY.equalTo(line3)
            make.left.equalTo(chartBackView).offset(24)
            make.width.equalTo(40)
        }
        
        lowLabel.snp.makeConstraints { make in
            make.centerY.equalTo(line2)
            make.left.equalTo(chartBackView).offset(24)
            make.width.equalTo(40)
        }
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(chartBackView.snp.bottom).offset(28)
            make.left.equalTo(contentView).offset(30)
            make.right.equalTo(contentView).offset(-30)
            make.height.equalTo(54)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(8)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.bottom.equalTo(contentView)
        }
        
        viewModel.getUserInspects(userId: String(inspectData.id))
    }
    
    override func reloadInputViews() {
        super.reloadInputViews()
        
    }
    
    @objc func backButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc func moreButtonPressed() {
        
    }
    
}

extension InspectReportVC: InspectReportViewModelDelegate {
    func didUpdateUserInspects() {
        chartContentView.subviews.forEach { if $0.tag == 1 { $0.removeFromSuperview() } }
        var lastCell: UIView?
        for (index, inspect) in viewModel.inspectList.enumerated() {
            var leftMargin = 16
            if index > 0 {
                leftMargin = leftMargin + (index * 64) + (index * 16) + (index * 16)
            }
            
            let cell = InspectReportGraphCell(data: inspect)
            cell.tag = 1
            chartContentView.addSubview(cell)
            cell.frame = CGRect(x: leftMargin, y: 0, width: 64, height: 212+23)
            lastCell = cell
        }

        if let lastCell = lastCell {
            chartContentView.frame = CGRect(x: 0, y: 0, width: lastCell.frame.maxX+16, height: 278)
            chartScrollView.contentSize = CGSize(width: lastCell.frame.maxX+16, height: 278)
        }
        
        tableView.reloadData()
    }
}

extension InspectReportVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.inspectList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as InspectReportCell
        let d = viewModel.inspectList[indexPath.row]
        cell.configure(with: d)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
}


class DateRangeView: UIView {
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2024-05-31 ~ 2024-11-30"
        label.textColor = .brainBorder
        label.font = UIFont.textStyleBody2()
        return label
    }()
    
    private let calendarIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar")
        imageView.tintColor = UIColor.lightGray
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        theCornerRadius = 8
        theBorderWidth = 1
        theBorderColor = .brainBorder
        
        addSubview(dateLabel)
        addSubview(calendarIcon)
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        calendarIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.width.height.equalTo(24)
        }
    }
}
