//
//  CustomNavigationBar.swift
//  IGNukeList
//
//  Created by Oleksandr Yevdokymov on 08.06.2021.
//

import UIKit

class CustomNavigationBar: UINavigationBar {
  let titleLabel: UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.text = "IGNukeList"
    label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()
  
  let highlightLayer: CAShapeLayer = {
    let layer = CAShapeLayer()
    layer.fillColor = UIColor.lightGray.cgColor
    return layer
  }()

  var statusOn = false
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    layer.addSublayer(highlightLayer)
    addSubview(titleLabel)
    barTintColor = .black
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let titleWidth: CGFloat = 130
    let borderHeight: CGFloat = 4
    
    let path = UIBezierPath()
    path.move(to: .zero)
    path.addLine(to: CGPoint(x: titleWidth, y: 0))
    path.addLine(to: CGPoint(x: titleWidth, y: 0))
    path.addLine(to: CGPoint(x: bounds.width, y: bounds.height - borderHeight / 2))
    path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
    path.addLine(to: CGPoint(x: 0, y: bounds.height))
    path.close()
    highlightLayer.path = path.cgPath
    titleLabel.frame = CGRect(x: 0, y: 0, width: titleWidth, height: bounds.height)
  }

}

