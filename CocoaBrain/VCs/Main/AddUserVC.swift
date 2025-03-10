//
//  AddUserVC.swift
//  CocoaBrain
//
//  Created by Kai on 3/5/25.
//

import UIKit

class AddUserVC: UIViewController {
    
    let viewModel: AddUserViewModel = AddUserViewModel()
    
    lazy var backButton: UIButton = {
        let v = UIButton()
        v.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        v.setBackgroundImage(UIImage(named: "ico_back"), for: .normal)
        v.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return v
    }()
    
    lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.text = "사용자 등록을 위해 다음의 정보를 입력하세요."
        v.font = UIFont.textStyleGuide()
        return v
    }()
    
    lazy var requiredLabel: UILabel = {
        let v = UILabel()
        v.text = "* 필수입력"
        v.textColor = .brainError
        v.font = UIFont.textStyleGuide()
        return v
    }()
    
    
    
    lazy var registrationNumberLabel: UILabel = {
        let v = UILabel()
        v.text = "등록번호(병록번호) *"
        v.font = UIFont.textStyleBody1()
        v.textColor = .brainTertiary
        return v
    }()
    
    lazy var registrationNumberField: PaddedTextField = {
        let v = PaddedTextField()
        v.placeholder = "등록번호(병록번호) 입력"
        return v
    }()
    
    
    
    lazy var nameLabel: UILabel = {
        let v = UILabel()
        v.text = "사용자 이름 *"
        v.font = UIFont.textStyleBody1()
        v.textColor = .brainTertiary
        return v
    }()
    
    lazy var nameField: PaddedTextField = {
        let v = PaddedTextField()
        v.placeholder = "사용자 이름 입력"
        return v
    }()
    
    
    
    
    lazy var birthLabel: UILabel = {
        let v = UILabel()
        v.text = "생년월일 *"
        v.font = UIFont.textStyleBody1()
        v.textColor = .brainTertiary
        return v
    }()
    
    lazy var birthField: PaddedTextField = {
        let v = PaddedTextField()
        v.placeholder = "생년월일 입력 (예: 19440805)"
        return v
    }()
    
    
    
    lazy var genderLabel: UILabel = {
        let v = UILabel()
        v.text = "성별 *"
        v.font = UIFont.textStyleBody1()
        v.textColor = .brainTertiary
        return v
    }()
    
    lazy var genderBackView: UIView = {
        let v = UIView()
        return v
    }()
    
    lazy var menRadioButton: DLRadioButton = {
        let v = DLRadioButton()
        v.marginWidth = 10
        v.icon = UIImage(named: "btn_radio_off")!
        v.iconSelected = UIImage(named: "btn_radio_on")!
        v.iconColor = .brainDisabled
        v.setTitle("남성", for: .normal)
        v.titleLabel?.font = UIFont.textStyleBody1()
        v.setTitleColor(.brainTertiary, for: .normal)
        v.tag = 0
        v.addTarget(self, action: #selector(menWomenRadioButtonPressed), for: .touchUpInside)
        v.isSelected = true
        return v
    }()
    
    lazy var womenRadioButton: UIButton = {
        let v = DLRadioButton()
        v.marginWidth = 10
        v.icon = UIImage(named: "btn_radio_off")!
        v.iconSelected = UIImage(named: "btn_radio_on")!
        v.iconColor = .brainDisabled
        v.setTitle("여성", for: .normal)
        v.titleLabel?.font = UIFont.textStyleBody1()
        v.setTitleColor(.brainTertiary, for: .normal)
        v.tag = 1
        v.addTarget(self, action: #selector(menWomenRadioButtonPressed), for: .touchUpInside)
        return v
    }()
    
    
    
    
    
    lazy var educationLabel: UILabel = {
        let v = UILabel()
        v.text = "교육정도 *"
        v.font = UIFont.textStyleBody1()
        v.textColor = .brainTertiary
        return v
    }()
    
    lazy var educationDropdownButton: UIButton = {
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
    
    lazy var educationDropdownLabel: UILabel = {
        let v = UILabel()
        v.font = .textStyleBody1()
        v.textColor = .brainTertiary
        return v
    }()
    
    lazy var educationMenu: UIMenu = UIMenu()
    
    var educationItems: [UIAction] = []
    
    lazy var graduationRadioButton: DLRadioButton = {
        let v = DLRadioButton()
        v.marginWidth = 10
        v.icon = UIImage(named: "btn_radio_off")!
        v.iconSelected = UIImage(named: "btn_radio_on")!
        v.iconColor = .brainDisabled
        v.setTitle("졸업", for: .normal)
        v.titleLabel?.font = UIFont.textStyleBody1()
        v.setTitleColor(.brainTertiary, for: .normal)
        v.tag = 0
        v.addTarget(self, action: #selector(graduationButtonPressed), for: .touchUpInside)
        v.isSelected = true
        return v
    }()
    
    lazy var graduationDropRadioButton: DLRadioButton = {
        let v = DLRadioButton()
        v.marginWidth = 10
        v.icon = UIImage(named: "btn_radio_off")!
        v.iconSelected = UIImage(named: "btn_radio_on")!
        v.iconColor = .brainDisabled
        v.setTitle("중퇴", for: .normal)
        v.titleLabel?.font = UIFont.textStyleBody1()
        v.setTitleColor(.brainTertiary, for: .normal)
        v.tag = 1
        v.addTarget(self, action: #selector(graduationButtonPressed), for: .touchUpInside)
        return v
    }()
    
    
    
    lazy var phoneLabel: UILabel = {
        let v = UILabel()
        v.text = "연락처 *"
        v.font = UIFont.textStyleBody1()
        v.textColor = .brainTertiary
        return v
    }()
    
    lazy var phoneTextField: PaddedTextField = {
        let v = PaddedTextField()
        v.placeholder = "연락처 입력 (예: 01012345678)"
        return v
    }()
    
    lazy var phoneLineView: UIView = {
        let v = UIView()
        v.backgroundColor = .brainBorder
        return v
    }()
    
    
    
    
    lazy var guardianNameLabel: UILabel = {
        let v = UILabel()
        v.text = "보호자 이름"
        v.font = UIFont.textStyleBody1()
        v.textColor = .brainTertiary
        return v
    }()
    
    lazy var guardianNameField: PaddedTextField = {
        let v = PaddedTextField()
        v.placeholder = "보호자 이름 입력"
        return v
    }()
    
    
    
    
    lazy var guardianRelationLabel: UILabel = {
        let v = UILabel()
        v.text = "사용자(수검자)와의 관계"
        v.font = UIFont.textStyleBody1()
        v.textColor = .brainTertiary
        return v
    }()
    
    lazy var guardianDropdownButton: UIButton = {
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
    
    lazy var guardianDropdownLabel: UILabel = {
        let v = UILabel()
        v.font = .textStyleBody1()
        v.textColor = .brainTertiary
        return v
    }()
    
    lazy var guardianMenu: UIMenu = UIMenu()
    
    var guardianItems: [UIAction] = []
    
    
    lazy var guardianPhoneLabel: UILabel = {
        let v = UILabel()
        v.text = "보호자 연락처"
        v.font = UIFont.textStyleBody1()
        v.textColor = .brainTertiary
        return v
    }()
    
    lazy var guardianPhoneField: PaddedTextField = {
        let v = PaddedTextField()
        v.placeholder = "보호자 연락처 입력 (예: 01012345678)"
        return v
    }()
    
    lazy var guardianLineView: UIView = {
        let v = UIView()
        v.backgroundColor = .brainBorder
        return v
    }()
    
   
    
    
    
    
    
    lazy var privacyTitleLabel: UILabel = {
        let v = UILabel()
        v.text = "개인정보 제공 동의 *"
        v.font = UIFont.textStyleBody1()
        v.textColor = .brainTertiary
        return v
    }()
    
    lazy var privacyCheckBoxButton: UIButton = {
        let v = UIButton()
        v.setBackgroundImage(UIImage(named: "ico_login_checkbox_unchecked"), for: .normal)
        v.setBackgroundImage(UIImage(named: "ico_login_checkbox"), for: .selected)
        v.addTarget(self, action: #selector(privacyCheckBoxButtonPressed), for: .touchUpInside)
        return v
    }()
    
    lazy var privacyDescLabel: UILabel = {
        let v = UILabel()
        v.text = "사용자의 검사 결과는 익명화되어 연구에 활용될 수 있음을\n사용자에게 고지하고 개인정보 제공에 대한 동의를 받았습니다."
        v.font = UIFont.textStyleBody4()
        v.numberOfLines = 0
        return v
    }()

    
    
    
    
    lazy var cancelButton: UIButton = {
        let v = UIButton(type: .system)
        v.theBorderColor = .brainBorder
        v.theBorderWidth = 1
        v.theCornerRadius = 12
        v.setTitle("취소", for: .normal)
        v.titleLabel?.font = UIFont.BrainButton1()
        v.backgroundColor = .white
        v.setTitleColor(.brainTertiary, for: .normal)
        return v
    }()
    
    lazy var saveButton: UIButton = {
        let v = UIButton()
        v.theCornerRadius = 12
        v.setTitle("저장", for: .normal)
        v.titleLabel?.font = UIFont.BrainButton1()
        v.setBackgroundImage(image(from: .brainDisabled), for: .normal)
        v.setBackgroundImage(image(from: .brainDisabled), for: [.normal, .highlighted])
        v.setBackgroundImage(image(from: .brainPrimary), for: .selected)
        v.setBackgroundImage(image(from: .brainPrimary), for: [.selected, .highlighted])
        v.setTitleColor(.brainTertiary, for: .normal)
        v.setTitleColor(.brainTertiary, for: [.normal, .highlighted])
        v.setTitleColor(.white, for: .selected)
        v.setTitleColor(.white, for: [.selected, .highlighted])
        return v
    }()
    
    override func loadView() {
        super.loadView()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "사용자 등록"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        view.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(requiredLabel)
        contentView.addSubview(registrationNumberLabel)
        contentView.addSubview(registrationNumberField)
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameField)
    
        contentView.addSubview(birthLabel)
        contentView.addSubview(birthField)
        
        contentView.addSubview(genderLabel)
        contentView.addSubview(genderBackView)
        contentView.addSubview(menRadioButton)
        contentView.addSubview(womenRadioButton)
        
        contentView.addSubview(educationLabel)
        contentView.addSubview(educationDropdownButton)
        educationDropdownButton.addSubview(educationDropdownLabel)
        contentView.addSubview(graduationRadioButton)
        contentView.addSubview(graduationDropRadioButton)
        
        contentView.addSubview(phoneLabel)
        contentView.addSubview(phoneTextField)
        contentView.addSubview(phoneLineView)
        
        contentView.addSubview(guardianNameLabel)
        contentView.addSubview(guardianNameField)
        
        contentView.addSubview(guardianRelationLabel)
        contentView.addSubview(guardianDropdownButton)
        guardianDropdownButton.addSubview(guardianDropdownLabel)
        contentView.addSubview(guardianPhoneLabel)
        contentView.addSubview(guardianPhoneField)
        contentView.addSubview(guardianLineView)
        
        contentView.addSubview(privacyTitleLabel)
        contentView.addSubview(privacyCheckBoxButton)
        contentView.addSubview(privacyDescLabel)
        
        contentView.addSubview(cancelButton)
        contentView.addSubview(saveButton)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(36)
            make.left.equalTo(contentView).offset(46)
        }
        
        requiredLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).offset(30)
            make.right.equalTo(contentView).offset(-32)
        }
        
        registrationNumberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(registrationNumberField)
            make.left.equalTo(contentView).offset(32)
            make.width.equalTo(250)
        }
        
        registrationNumberField.snp.makeConstraints { make in
            make.top.equalTo(requiredLabel.snp.bottom).offset(16)
            make.left.equalTo(registrationNumberLabel.snp.right).offset(16)
            make.right.equalTo(contentView).offset(-32)
            make.height.equalTo(56)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameField)
            make.left.equalTo(contentView).offset(32)
        }
        
        nameField.snp.makeConstraints { make in
            make.top.equalTo(registrationNumberField.snp.bottom).offset(38)
            make.left.right.equalTo(registrationNumberField)
            make.height.equalTo(56)
        }
        
        birthLabel.snp.makeConstraints { make in
            make.centerY.equalTo(birthField)
            make.left.equalTo(contentView).offset(32)
        }
        
        birthField.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(38)
            make.left.right.equalTo(registrationNumberField)
            make.height.equalTo(56)
        }
        
        
        
        
        genderLabel.snp.makeConstraints { make in
            make.centerY.equalTo(genderBackView)
            make.left.equalTo(contentView).offset(32)
        }
        
        genderBackView.snp.makeConstraints { make in
            make.top.equalTo(birthField.snp.bottom).offset(38)
            make.left.right.equalTo(registrationNumberField)
            make.height.equalTo(56)
        }
        
        menRadioButton.snp.makeConstraints { make in
            make.centerY.equalTo(genderBackView)
            make.left.equalTo(genderBackView)
            make.height.equalTo(56)
            make.width.equalTo(100)
        }
        
        womenRadioButton.snp.makeConstraints { make in
            make.centerY.equalTo(genderBackView)
            make.left.equalTo(menRadioButton.snp.right).offset(16)
            make.height.equalTo(56)
            make.width.equalTo(100)
        }
        
        
        
        educationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(educationDropdownButton)
            make.left.equalTo(contentView).offset(32)
        }
        
        educationDropdownButton.snp.makeConstraints { make in
            make.top.equalTo(genderBackView.snp.bottom).offset(16)
            make.left.equalTo(genderBackView)
            make.height.equalTo(56)
            make.width.equalTo(230)
        }
        
        educationDropdownLabel.snp.makeConstraints { make in
            make.centerY.equalTo(educationDropdownButton)
            make.left.equalTo(educationDropdownButton).offset(16)
        }
        
        graduationRadioButton.snp.makeConstraints { make in
            make.centerY.equalTo(educationDropdownButton)
            make.height.equalTo(56)
            make.width.equalTo(100)
            make.left.equalTo(educationDropdownButton.snp.right).offset(24)
        }
        
        graduationDropRadioButton.snp.makeConstraints { make in
            make.centerY.equalTo(educationDropdownButton)
            make.height.equalTo(56)
            make.width.equalTo(100)
            make.left.equalTo(graduationRadioButton.snp.right).offset(16)
        }
        
        
        
        phoneLabel.snp.makeConstraints { make in
            make.centerY.equalTo(phoneTextField)
            make.left.equalTo(contentView).offset(32)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(educationDropdownButton.snp.bottom).offset(16)
            make.left.right.equalTo(registrationNumberField)
            make.height.equalTo(56)
        }
        
        phoneLineView.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(16)
            make.height.equalTo(1)
            make.left.equalTo(phoneLabel)
            make.right.equalTo(phoneTextField)
        }
        
        
        
        guardianNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(guardianNameField)
            make.left.equalTo(contentView).offset(32)
        }
        
        guardianNameField.snp.makeConstraints { make in
            make.top.equalTo(phoneLineView.snp.bottom).offset(16)
            make.left.right.equalTo(registrationNumberField)
            make.height.equalTo(56)
        }
        
        
        
        guardianRelationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(guardianDropdownButton)
            make.left.equalTo(contentView).offset(32)
        }
        
        guardianDropdownButton.snp.makeConstraints { make in
            make.top.equalTo(guardianNameField.snp.bottom).offset(16)
            make.left.right.equalTo(registrationNumberField)
            make.height.equalTo(56)
        }
        
        guardianDropdownLabel.snp.makeConstraints { make in
            make.centerY.equalTo(guardianDropdownButton)
            make.left.equalTo(guardianDropdownButton).offset(16)
        }

        
        
        guardianRelationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(guardianDropdownButton)
            make.left.equalTo(contentView).offset(32)
        }
        
        guardianDropdownButton.snp.makeConstraints { make in
            make.top.equalTo(guardianDropdownButton.snp.bottom).offset(16)
            make.left.right.equalTo(registrationNumberField)
        }
        
        guardianLineView.snp.makeConstraints { make in
            make.top.equalTo(guardianDropdownButton.snp.bottom).offset(16)
            make.height.equalTo(1)
            make.left.equalTo(phoneLabel)
            make.right.equalTo(phoneTextField)
        }
        
        
        
        
        privacyTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(privacyDescLabel)
            make.left.equalTo(contentView).offset(32)
        }
        
        privacyCheckBoxButton.snp.makeConstraints { make in
            make.centerY.equalTo(privacyDescLabel)
            make.size.equalTo(26)
            make.left.equalTo(guardianNameField)
        }
        
        privacyDescLabel.snp.makeConstraints { make in
            make.top.equalTo(guardianLineView.snp.bottom).offset(16)
            make.left.equalTo(privacyCheckBoxButton.snp.right).offset(16)
            make.right.equalTo(contentView).offset(-32)
        }
        
        
        let width = (k320-(44+30+44))/2
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(privacyDescLabel.snp.bottom).offset(16)
            make.left.equalTo(44)
            make.width.equalTo(width)
            make.height.equalTo(70)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(privacyDescLabel.snp.bottom).offset(16)
            make.left.equalTo(cancelButton.snp.right).offset(30)
            make.width.equalTo(width)
            make.height.equalTo(70)
        }
        
        makeMenus()
        
    }
    
    @objc func backButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc func menWomenRadioButtonPressed(sender: DLRadioButton) {
        if sender.tag == 0 {
            //남성
            menRadioButton.isSelected = true
            womenRadioButton.isSelected = false
        } else {
            //여성
            menRadioButton.isSelected = false
            womenRadioButton.isSelected = true
        }
    }
    
    @objc func privacyCheckBoxButtonPressed(sender: UIButton) {
        if sender.isSelected == false {
            sender.isSelected = true
            saveButton.isSelected = true
        } else {
            sender.isSelected = false
            saveButton.isSelected = false
        }
    }
    
    @objc func graduationButtonPressed(sender: DLRadioButton) {
        if sender.tag == 0 {
            //졸업
            graduationRadioButton.isSelected = true
            graduationDropRadioButton.isSelected = false
        } else {
            //중퇴
            graduationRadioButton.isSelected = false
            graduationDropRadioButton.isSelected = true
        }
    }
    
    func makeMenus() {
        for edu in EduLevel.allCases.reversed() {
            educationItems.append(
                UIAction(title: edu.string(), handler: { action in
                    self.educationDropdownLabel.text = edu.string()
                    self.viewModel.selectedEduLevel = edu
                })
            )
        }
        educationDropdownLabel.text = viewModel.selectedEduLevel.string()
        educationMenu = UIMenu(title: "", children: educationItems)
        educationDropdownButton.menu = educationMenu
        educationDropdownButton.showsMenuAsPrimaryAction = true
        
        for guardian in GuardianType.allCases.reversed() {
            guardianItems.append(
                UIAction(title: guardian.string(), handler: { action in
                    self.guardianDropdownLabel.text = guardian.string()
                    self.viewModel.selectedGuardianType = guardian
                })
            )
        }
        guardianDropdownLabel.text = viewModel.selectedGuardianType.string()
        guardianMenu = UIMenu(title: "", children: guardianItems)
        guardianDropdownButton.menu = guardianMenu
        guardianDropdownButton.showsMenuAsPrimaryAction = true
    }
}
