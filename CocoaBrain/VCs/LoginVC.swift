//
//  LoginVC.swift
//  CocoaBrain
//
//  Created by Kai on 2/24/25.
//

import UIKit

class LoginVC: UIViewController {
    
    let viewModel = LoginViewModel()
    
    lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    lazy var topImageView: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "img_login_top")
        v.contentMode = .scaleAspectFit
        v.backgroundColor = .white
        return v
    }()
    
    lazy var centerDropdownButton: UIButton = {
        let v = UIButton()
        v.theBorderColor = .brainBorder
        v.theBorderWidth = 1
        v.theCornerRadius = 8
        v.setTitleColor(.brainTertiary, for: .normal)
        v.titleLabel?.textAlignment = .left
        
        let icon = UIImageView(image: UIImage(named: "ico_dropdown_arrow_down"))
        v.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.centerY.equalTo(v)
            make.right.equalTo(v).offset(-16)
            make.size.equalTo(28)
        }
        return v
    }()
    
    lazy var centerLabel: UILabel = {
        let v = UILabel()
        v.font = .textStyleBody1()
        v.textColor = .brainTertiary
        return v
    }()
    
    lazy var idTextField: PaddedTextField = {
        let v = PaddedTextField()
        v.theBorderColor = .brainBorder
        v.theBorderWidth = 1
        v.theCornerRadius = 8
        
        if PrefsManager.SI.isDebug == true {
            v.text = "min@jeios.com"
        }
        return v
    }()
    
    lazy var pwTextField: PaddedTextField = {
        let v = PaddedTextField()
        v.placeholder = "비밀번호를 입력하세요."
        v.theBorderColor = .brainBorder
        v.theBorderWidth = 1
        v.theCornerRadius = 8
        
        if PrefsManager.SI.isDebug == true {
            v.text = "jeios1234!!"
        }
        return v
    }()
    
    lazy var autoLoginLabel: UILabel = {
        let v = UILabel()
        v.text = "자동 로그인"
        v.textColor = .brainTertiary
        v.font = .textStyleBody3()
        return v
    }()
    
    lazy var idSaveCheckBox: UIButton = {
        let v = UIButton()
        v.setBackgroundImage(UIImage(named: "ico_login_checkbox_unchecked"), for: .normal)
        v.setBackgroundImage(UIImage(named: "ico_login_checkbox"), for: .selected)
        v.isSelected = false
        v.addTarget(self, action: #selector(idSaveCheckBoxPressed), for: .touchUpInside)
        return v
    }()
    
    lazy var idSaveLabel: UILabel = {
        let v = UILabel()
        v.text = "아이디(이메일주소) 저장"
        v.textColor = .brainBorder
        v.font = .textStyleBody3()
        return v
    }()
    
    lazy var autoLoginCheckBox: UIButton = {
        let v = UIButton()
        v.setBackgroundImage(UIImage(named: "ico_login_checkbox_unchecked"), for: .normal)
        v.setBackgroundImage(UIImage(named: "ico_login_checkbox"), for: .selected)
        v.isSelected = true
        v.addTarget(self, action: #selector(autoLoginCheckBoxPressed), for: .touchUpInside)
        return v
    }()
    
    lazy var loginButton: UIButton = {
        let v = UIButton()
        v.backgroundColor = .brainPrimary
        v.setTitle("로그인", for: .normal)
        v.setTitleColor(.brainBtnText, for: .normal)
        v.titleLabel?.font = UIFont.BrainButton1()
        v.theCornerRadius = 12
        v.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return v
    }()
    
    lazy var bottomImageView: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "img_login_bottom")
        return v
    }()
    
    var centerListMenu: UIMenu = UIMenu()
    var centerListItems: [UIAction] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(contentView)
        contentView.addSubview(topImageView)
        contentView.addSubview(centerDropdownButton)
        centerDropdownButton.addSubview(centerLabel)
        contentView.addSubview(idTextField)
        contentView.addSubview(pwTextField)
        contentView.addSubview(autoLoginLabel)
        contentView.addSubview(autoLoginCheckBox)
        contentView.addSubview(idSaveLabel)
        contentView.addSubview(idSaveCheckBox)
        contentView.addSubview(loginButton)
        contentView.addSubview(bottomImageView)
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        topImageView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(view)
            
            if let image = topImageView.image {
                let aspectRatio = image.size.height / image.size.width
                make.height.equalTo(topImageView.snp.width).multipliedBy(aspectRatio).priority(.required)
            }
        }
        
        centerDropdownButton.snp.makeConstraints { make in
            make.top.equalTo(topImageView.snp.bottom).offset(115)
            make.width.equalTo(437)
            make.height.equalTo(56)
            make.centerX.equalTo(contentView)
        }
        
        centerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(centerDropdownButton)
            make.left.equalTo(centerDropdownButton).offset(16)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(centerDropdownButton.snp.bottom).offset(24)
            make.width.equalTo(437)
            make.height.equalTo(56)
            make.centerX.equalTo(contentView)
        }
        
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(24)
            make.width.equalTo(437)
            make.height.equalTo(56)
            make.centerX.equalTo(contentView)
        }
        
        autoLoginLabel.snp.makeConstraints { make in
            make.top.centerY.equalTo(autoLoginCheckBox)
            make.right.equalTo(pwTextField)
        }
        
        autoLoginCheckBox.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(24)
            make.right.equalTo(autoLoginLabel.snp.left).offset(-4)
            make.size.equalTo(26)
        }
        
        idSaveLabel.snp.makeConstraints { make in
            make.top.centerY.equalTo(autoLoginCheckBox)
            make.right.equalTo(autoLoginCheckBox.snp.left).offset(-20)
        }

        idSaveCheckBox.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(24)
            make.right.equalTo(idSaveLabel.snp.left).offset(-4)
            make.size.equalTo(26)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(idSaveCheckBox.snp.bottom).offset(24)
            make.centerX.equalTo(contentView)
            make.width.equalTo(437)
            make.height.equalTo(75)
        }
        
        bottomImageView.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).offset(-40)
            make.centerX.equalTo(contentView)
        }
        
        viewModel.prepare()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func idSaveCheckBoxPressed() {
        idSaveCheckBox.isSelected = !idSaveCheckBox.isSelected
        if idSaveCheckBox.isSelected {
            idSaveLabel.textColor = .brainTertiary
        } else {
            idSaveLabel.textColor = .brainBorder
        }
    }
    
    @objc func autoLoginCheckBoxPressed() {
        autoLoginCheckBox.isSelected = !autoLoginCheckBox.isSelected
        if autoLoginCheckBox.isSelected {
            autoLoginLabel.textColor = .brainTertiary
        } else {
            autoLoginLabel.textColor = .brainBorder
        }
    }
    
    @objc func loginButtonPressed() {
        viewModel.login(id: idTextField.text ?? "", password: pwTextField.text ?? "")
    }
    
    

}

extension LoginVC: LoginViewModelDelegate {
    func didUpdateCenters(_ centers: [AMO_CenterList]) {
        for center in centers {
            centerListItems.append(
                UIAction(title: center.name, handler: { action in
                    self.centerLabel.text = center.name
                    self.viewModel.selectedCenterId = center.id
                })
            )
        }
        
        centerLabel.text = centers[0].name
        viewModel.selectedCenterId = centers[0].id
        
        centerListMenu = UIMenu(title: "", children: centerListItems)
        
        centerDropdownButton.menu = centerListMenu
        centerDropdownButton.showsMenuAsPrimaryAction = true
    }
}
