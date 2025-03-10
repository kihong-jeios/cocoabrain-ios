//
//  TmtTestVC.swift
//  CocoaBrain
//
//  Created by Kai on 3/9/25.
//

import UIKit

class TmtTestVC: UIViewController {
    
    let viewModel: TmtViewModel = TmtViewModel()
    
    lazy var contentView: UIView = {
        let v = UIView()
        return v
    }()
    
    var points: [CGPoint] = []
    
    var currentPointIndex: Int = 0
    
    var lineLayer: CAShapeLayer?

    var type: TmtIntroType
    var inspectData: AMO_UserInspectListData
    init(type: TmtIntroType, inspectData: AMO_UserInspectListData) {
        self.type = type
        self.inspectData = inspectData
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        viewModel.prepare(type: type)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    // 선을 그리는 함수
    func setupLine() {
        let path = UIBezierPath()
        path.move(to: points[currentPointIndex])
        
        lineLayer = CAShapeLayer()
        lineLayer?.path = path.cgPath
        lineLayer?.strokeColor = UIColor.black.cgColor
        lineLayer?.lineWidth = 1.0
        view.layer.insertSublayer(lineLayer!, below: contentView.layer)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: view)
            updateLine(to: currentPoint)
        }
    }

    // 선을 업데이트하는 함수
    func updateLine(to newPoint: CGPoint) {
        let arrowPath = createArrow(from: points[currentPointIndex], to: newPoint, tailWidth: 2.0, headWidth: 2.0, headLength: 2.0)
        lineLayer?.path = arrowPath.cgPath
        checkArrowInCircle(arrowEndPoint: newPoint)
    }
    
    func checkArrowInCircle(arrowEndPoint: CGPoint) {
        let distance = sqrt(pow(arrowEndPoint.x - points[currentPointIndex+1].x, 2) + pow(arrowEndPoint.y - points[currentPointIndex+1].y, 2))
        if distance <= 20 {
            currentPointIndex = currentPointIndex + 1
            if currentPointIndex < points.count - 1 {
                setupLine()
                
            } else {
                print("end")
                switch type {
                case .typeA:
                    let vc = TmtIntroVC(type: .typeB, inspectData: inspectData)
                    self.navigationController?.pushViewController(vc, animated: true)
                case .typeB:
                    let vc = TmtResultVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        } else {
            
        }
    }
    
    func createArrow(from start: CGPoint, to end: CGPoint, tailWidth: CGFloat, headWidth: CGFloat, headLength: CGFloat) -> UIBezierPath {
        let length = sqrt(pow(end.x - start.x, 2) + pow(end.y - start.y, 2))
        let tailLength = length - headLength

        let points: [CGPoint] = [
            CGPoint(x: 0, y: tailWidth / 2),
            CGPoint(x: tailLength, y: tailWidth / 2),
            CGPoint(x: tailLength, y: headWidth / 2),
            CGPoint(x: length, y: 0),
            CGPoint(x: tailLength, y: -headWidth / 2),
            CGPoint(x: tailLength, y: -tailWidth / 2),
            CGPoint(x: 0, y: -tailWidth / 2)
        ]

        let cosine = (end.x - start.x) / length
        let sine = (end.y - start.y) / length
        let transform = CGAffineTransform(a: cosine, b: sine, c: -sine, d: cosine, tx: start.x, ty: start.y)

        let path = UIBezierPath()
        path.move(to: points[0].applying(transform))

        for point in points.dropFirst() {
            path.addLine(to: point.applying(transform))
        }

        path.close()

        return path
    }
}

extension TmtTestVC: TmtViewModelDelegate {
    func didUpdateCircles() {
        switch type {
        case .typeA:
            for c in viewModel.circles {
                let circleView = TmtCircleView(isWhite: c.isWhite, number: c.number)
                view.addSubview(circleView)
                let x = c.x * (k320 / 1.1)
                let y = c.y * k480
                circleView.frame = CGRect(x: x, y: y, width: 48, height: 48)
                points.append(CGPoint(x: circleView.frame.midX, y: circleView.frame.midY))
            }
            
        case .typeB:
            for c in viewModel.circles {
                let circleView = TmtCircleView(isWhite: c.isWhite, number: c.number)
                view.addSubview(circleView)
                let x = c.x * (k320 / 1.1)
                let y = c.y * k480
                circleView.frame = CGRect(x: x, y: y, width: 48, height: 48)
                
                if c.isWhite == true && c.number % 2 != 0 || c.isWhite == false && c.number % 2 == 0 {
                    points.append(CGPoint(x: circleView.frame.midX, y: circleView.frame.midY))
                }
            }
        }
       
        setupLine()
    }
}

class TmtCircleView: UIView {
    
    lazy var numberLabel: UILabel = {
        let v = UILabel()
        v.font = UIFont.BrainTmtNumber()
        v.textColor = .brainBackground
        v.textAlignment = .center
        return v
    }()
    
    init(isWhite: Bool, number: Int) {
        super.init(frame: .zero)
        theCornerRadius = 24
        addSubview(numberLabel)
        
        if isWhite == true {
            backgroundColor = .white
            theBorderColor = .black
            theBorderWidth = 3
            numberLabel.textColor = .black
        } else {
            backgroundColor = .black
            numberLabel.textColor = .white
        }
        numberLabel.text = String(number)
        numberLabel.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
