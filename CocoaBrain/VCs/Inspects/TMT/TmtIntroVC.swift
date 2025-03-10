//
//  TmtIntroVC.swift
//  CocoaBrain
//
//  Created by Kai on 3/9/25.
//

import UIKit

enum TmtIntroType {
    case typeA
    case typeB
}

class TmtIntroVC: UIViewController {
    
    lazy var backButton: UIButton = {
        let v = UIButton()
        v.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        v.setBackgroundImage(UIImage(named: "ico_back"), for: .normal)
        v.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
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

    lazy var imageView: UIImageView = {
        let v = UIImageView()
        switch type {
        case .typeA:
            v.image = UIImage(named: "img_tmt_a")
        case .typeB:
            v.image = UIImage(named: "img_tmt_b")
        }
        return v
    }()
    
    lazy var startButton: UIButton = {
        let v = UIButton()
        v.backgroundColor = .brainPrimary
        v.setTitle("검사 시작하기", for: .normal)
        v.setTitleColor(.brainBtnText, for: .normal)
        v.titleLabel?.font = UIFont.BrainButton1()
        v.theCornerRadius = 12
        v.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        return v
    }()
    
    var type: TmtIntroType
    var inspectData: AMO_UserInspectListData
    init(type: TmtIntroType, inspectData: AMO_UserInspectListData) {
        self.type = type
        self.inspectData = inspectData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        title = "흑백 선 긋기 검사"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        view.backgroundColor = .white
        view.addSubview(contentView)
        contentView.addSubview(userInfoView)
        contentView.addSubview(imageView)
        contentView.addSubview(startButton)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        userInfoView.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(86)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(userInfoView.snp.bottom).offset(60)
            make.centerX.equalTo(view)
            make.width.equalTo(665)
            switch type {
            case .typeA:
                make.height.equalTo(698)
            case .typeB:
                make.height.equalTo(778)
            }
        }
        
        startButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-40)
            make.width.equalTo(484)
            make.height.equalTo(70)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func backButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc func startButtonPressed() {
        let vc = TmtTestVC(type: type, inspectData: inspectData)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
