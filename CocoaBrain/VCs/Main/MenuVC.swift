//
//  MenuVC.swift
//  CocoaBrain
//
//  Created by Kai on 3/3/25.
//

import UIKit

enum MenuRow: Int, CaseIterable {
    case main
    case addUser
    case autoLogin
    case privacyPolicy
    case appVersion
    
    func image() -> UIImage? {
        switch self {
        case .main:
            return UIImage(named: "ico_menu_main")
        case .addUser:
            return UIImage(named: "ico_user_plus_black")
        case .autoLogin:
            return UIImage(named: "ico_menu_autologin")
        case .privacyPolicy:
            return UIImage(named: "ico_privacy_policy")
        case .appVersion:
            return UIImage(named: "ico_menu_versioninfo")
        }
    }
    
    func title() -> String {
        switch self {
        case .main:
            return "메인"
        case .addUser:
            return "사용자 등록"
        case .autoLogin:
            return "자동 로그인"
        case .privacyPolicy:
            return "개인정보처리방침"
        case .appVersion:
            return "앱 버전 정보"
        }
    }
}

protocol MenuVCDelegate: AnyObject {
    func signout()
    func addUser()
}

class MenuVC: UIViewController {
    
    weak open var delegate: MenuVCDelegate?
    
    lazy var closeButton: UIButton = {
        let v = UIButton(type: .system)
        v.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        v.setBackgroundImage(UIImage(named: "ico_xclose"), for: .normal)
        return v
    }()
    
    lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .brainBackground
        return v
    }()
    
    lazy var centerLabel: UILabel = {
        let v = UILabel()
        v.font = UIFont.textStyleBody2()
        v.textColor = .brainTertiary
        v.text = PrefsManager.SI.centerName
        return v
    }()
    
    lazy var nameLabel: UILabel = {
        let v = UILabel()
        v.font = UIFont.textStyleTitle()
        v.textColor = .brainTertiary
        v.text = PrefsManager.SI.userName
        return v
    }()
    
    lazy var lineView: UIView = {
        let v = UIView()
        v.backgroundColor = .brainDisabled
        return v
    }()

    lazy var tableView: UITableView = {
        let v = UITableView()
        v.delegate = self
        v.dataSource = self
        v.separatorColor = .clear
        v.register(MenuCell.self, forCellReuseIdentifier: MenuCell.reuseIdentifier)
        v.contentInset = UIEdgeInsets(top: 0, left: 44, bottom: 0, right: -44)
        return v
    }()
    
    lazy var logoutButton: UIButton = {
        let v = UIButton()
        v.backgroundColor = .brainPrimary
        v.setTitle("로그아웃", for: .normal)
        v.setTitleColor(.brainBtnText, for: .normal)
        v.titleLabel?.font = UIFont.BrainButton1()
        v.theCornerRadius = 12
        v.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        return v
    }()
    
    override func loadView() {
        super.loadView()

        view.addSubview(contentView)
        contentView.addSubview(closeButton)
        contentView.addSubview(centerLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(lineView)
        contentView.addSubview(tableView)
        contentView.addSubview(logoutButton)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(54)
            make.right.equalTo(contentView).offset(-32)
            make.height.equalTo(46)
        }
        
        centerLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(40)
            make.left.equalTo(44)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(centerLabel)
            make.left.equalTo(centerLabel.snp.right).offset(12)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(36)
            make.left.right.equalTo(contentView)
            make.height.equalTo(3)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(14)
            make.left.right.equalTo(contentView)
            make.height.equalTo(500)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).offset(-80)
            make.centerX.equalTo(contentView)
            make.width.equalTo(484)
            make.height.equalTo(70)
        }
    }
    
    @objc func closeButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc func logoutButtonPressed() {
        let actionSheet = UIAlertController(title: "로그아웃하시겠습니까?",
                                            message: "\n로그아웃 후 로그인 화면으로 이동합니다.",
                                            preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default) { action in
            self.dismiss(animated: true)
            self.delegate?.signout()
        }
        confirm.setValue(UIColor.brainPrimary, forKey: "titleTextColor")
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in }
        actionSheet.addAction(confirm)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
    }

}

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let row = MenuRow(rawValue: indexPath.row) else { return }
        switch row {
        case .main:
            dismiss(animated: true)
        case .addUser:
            dismiss(animated: true)
            delegate?.addUser()
        case .autoLogin:
            break
        case .privacyPolicy:
            break
        case .appVersion:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuRow.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.reuseIdentifier, for: indexPath) as? MenuCell,
              let menuRow = MenuRow(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        cell.icon.image = menuRow.image()
        cell.titleLabel.text = menuRow.title()
        
        switch menuRow {
        case .main, .addUser, .privacyPolicy:
            cell.rightIcon.isHidden = false
            cell.switchView.isHidden = true
            cell.versionLabel.isHidden = true
        case .autoLogin:
            cell.rightIcon.isHidden = true
            cell.switchView.isHidden = false
            cell.versionLabel.isHidden = true
        case .appVersion:
            cell.rightIcon.isHidden = true
            cell.switchView.isHidden = true
            cell.versionLabel.isHidden = false
        }
        
        return cell
    }
    
}


class MenuCell: UITableViewCell, ReusableView {
    
    lazy var backView: UIView = {
        let v = UIView()
        return v
    }()
    
    lazy var icon: UIImageView = {
        let v = UIImageView()
        return v
    }()
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .textStyleTitle2()
        v.textColor = .brainTertiary
        return v
    }()
    
    lazy var rightIcon: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "ico_menu_rightarrow")
        return v
    }()
    
    lazy var switchView: UISwitch = {
        let v = UISwitch()
        v.onTintColor = .brainSecondary
        v.thumbTintColor = .brainPrimary
        v.isOn = UDManager.SI.getIsEnabledAutoLogin()
        return v
    }()
    
    lazy var versionLabel: UILabel = {
        let v = UILabel()
        v.font = .textStyleTitle2()
        v.textColor = .brainPopupBtnText
        v.text = PrefsManager.SI.getAppVersion()
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        selectionStyle = .none
        
        contentView.addSubview(backView)
        backView.addSubview(icon)
        backView.addSubview(titleLabel)
        backView.addSubview(rightIcon)
        backView.addSubview(switchView)
        backView.addSubview(versionLabel)
        
        backView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        icon.snp.makeConstraints { make in
            make.centerY.equalTo(backView)
            make.left.equalTo(backView)
            make.size.equalTo(46)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backView)
            make.left.equalTo(icon.snp.right).offset(40)
        }
        
        rightIcon.snp.makeConstraints { make in
            make.centerY.equalTo(backView)
            make.right.equalTo(backView).offset(-80)
            make.size.equalTo(46)
        }
        
        switchView.isHidden = true
        switchView.snp.makeConstraints { make in
            make.centerY.equalTo(backView)
            make.right.equalTo(backView).offset(-100)
            make.size.equalTo(46)
        }
        
        versionLabel.isHidden = true
        versionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backView)
            make.right.equalTo(backView).offset(-100)
        }
    }
}
