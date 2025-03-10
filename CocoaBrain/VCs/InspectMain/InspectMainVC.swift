//
//  InspectMainVC.swift
//  CocoaBrain
//
//  Created by Kai on 3/9/25.
//

import UIKit

class InspectMainVC: UIViewController {
    
    let viewModel: InspectMainViewModel = InspectMainViewModel()
    
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
    
    lazy var descLabel: UILabel = {
        let v = UILabel()
        v.text = "시행하실 검사를 선택하세요.\n검사를 모두 시행하시면 뇌인지건강지수를 종합적으로 확인하실 수 있습니다."
        v.textColor = .brainTertiary
        v.font = UIFont.textStyleGuide()
        v.numberOfLines = 0
        return v
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 27
        layout.minimumInteritemSpacing = 27
        
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.delegate = self
        v.dataSource = self
        v.register(InspectMainCell.self, forCellWithReuseIdentifier: InspectMainCell.reuseIdentifier)
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

        title = "검사 선택"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreButton)
        
        view.backgroundColor = .white
        view.addSubview(contentView)
        contentView.addSubview(userInfoView)
        contentView.addSubview(descLabel)
        contentView.addSubview(collectionView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        userInfoView.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(86)
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(userInfoView.snp.bottom).offset(36)
            make.left.equalTo(contentView).offset(44)
            make.right.equalTo(contentView).offset(-44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(36)
            make.left.equalTo(contentView).offset(44)
            make.right.equalTo(contentView).offset(-44)
            make.bottom.equalTo(contentView)
        }
    }
    
    @objc func backButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc func moreButtonPressed() {
        
    }
    
}

extension InspectMainVC: InspectMainViewModelDelegate {
    func didUpdateUserInspects() {
        
    }
}

extension InspectMainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // 흑백 선 긋기 검사
            let vc = TmtIntroVC(type: .typeA, inspectData: inspectData)
            let navi = UINavigationController(rootViewController: vc)
            navi.modalPresentationStyle = .fullScreen
            present(navi, animated: true)
            
        } else if indexPath.row == 1 {
            // 시계 그리기 검사
            
        } else if indexPath.row == 2 {
            // 인지기능평가 설문지
            
        } else if indexPath.row == 3 {
            // 기억력 검사
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as InspectMainCell
        if indexPath.row == 0 {
            cell.titleLabel.text = "흑백 선 긋기 검사"
            cell.descLabel.text = "TMT-B&W"
            cell.dateLabel.text = "2024-06-25 13:01"
            cell.imageView.image = UIImage(named: "img_testselect_tmt")
            
        } else if indexPath.row == 1 {
            cell.titleLabel.text = "시계 그리기 검사"
            cell.descLabel.text = "CDT"
            cell.dateLabel.text = "2024-06-25 13:01"
            cell.imageView.image = UIImage(named: "img_testselect_cdt")
            
        } else if indexPath.row == 2 {
            cell.titleLabel.text = "인지기능평가 설문지"
            cell.descLabel.text = "GDSQ"
            cell.dateLabel.text = "2024-06-25 13:01"
            cell.imageView.image = UIImage(named: "img_testselect_kdsq")
            
        } else if indexPath.row == 3 {
            cell.titleLabel.text = "기억력 검사"
            cell.descLabel.text = "PMT"
            cell.dateLabel.text = "2024-06-25 13:01"
            cell.imageView.image = UIImage(named: "img_testselect_pmt")
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing: CGFloat = 27 * 1 // (2개의 셀 사이의 간격)
        let width = (collectionView.frame.width - totalSpacing) / 2
        return CGSize(width: width, height: 226)
    }
}
