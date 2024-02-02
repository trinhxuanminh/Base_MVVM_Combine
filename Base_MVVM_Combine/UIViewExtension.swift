//
//  UIViewExtension.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import UIKit

extension UIView {
  func nearestAncestor<T>(ofType type: T.Type) -> T? {
    if let view = self as? T {
      return view
    }
    return superview?.nearestAncestor(ofType: type)
  }
  
  class func loadNib() -> Self {
    return Bundle.main.loadNibNamed(String(describing: Self.className), owner: nil)?.first as! Self
  }
  
  func asImage() -> UIImage {
    let renderer = UIGraphicsImageRenderer(bounds: bounds)
    return renderer.image { rendererContext in
      layer.render(in: rendererContext.cgContext)
    }
  }
  
  func hideKeyboardWhenTappedAround() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tap.cancelsTouchesInView = false
    addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    endEditing(true)
  }
}

@IBDesignable extension UIView {
  @IBInspectable var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    } set {
      layer.cornerRadius = newValue
    }
  }
  
  @IBInspectable var shadowRadius: CGFloat {
    get {
      return layer.shadowRadius
    } set {
      layer.shadowRadius = newValue
    }
  }
  
  @IBInspectable var shadowOpacity: CGFloat {
    get {
      return CGFloat(layer.shadowOpacity)
    } set {
      layer.shadowOpacity = Float(newValue / 100)
    }
  }
  
  @IBInspectable var shadowOffset: CGSize {
    get {
      return layer.shadowOffset
    } set {
      layer.shadowOffset = newValue
    }
  }
  
  @IBInspectable var shadowColor: UIColor? {
    get {
      guard let cgColor = layer.shadowColor else {
        return nil
      }
      return UIColor(cgColor: cgColor)
    } set {
      layer.shadowColor = newValue?.cgColor
    }
  }
  
  @IBInspectable var borderColor: UIColor? {
    get {
      guard let cgColor = layer.borderColor else {
        return nil
      }
      return UIColor(cgColor: cgColor)
    } set {
      layer.borderColor = newValue?.cgColor
    }
  }
  
  @IBInspectable var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    } set {
      layer.borderWidth = newValue
    }
  }
}

extension UIView {
  func loadNibNamed() {
    Bundle.main.loadNibNamed(String(describing: Self.className), owner: self)
  }
  
  func addDashedBorder(lineDashPattern: [NSNumber], color: UIColor, cornerRadius: CGFloat, borderWidth: CGFloat) {
    let shapeLayer = CAShapeLayer()
    let frameSize = frame.size
    let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

    shapeLayer.bounds = shapeRect
    shapeLayer.position = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = color.cgColor
    shapeLayer.lineWidth = borderWidth
    shapeLayer.lineJoin = CAShapeLayerLineJoin.round
    shapeLayer.lineDashPattern = lineDashPattern
    shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: cornerRadius).cgPath

    layer.addSublayer(shapeLayer)
  }
}

extension UIView {
  private func standardizeRect(_ rect: CGRect) -> CGRect {
    return CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height)
  }
  
  var left: CGFloat {
    get {
      return frame.minX
    }
    set(left) {
      var frame = standardizeRect(self.frame)
      
      frame.origin.x = left
      self.frame = frame
    }
  }
  
  var top: CGFloat {
    get {
      return frame.minY
    }
    set(top) {
      var frame = standardizeRect(self.frame)
      
      frame.origin.y = top
      self.frame = frame
    }
  }
  
  var right: CGFloat {
    get {
      return frame.maxX
    }
    set(right) {
      var frame = standardizeRect(self.frame)
      
      frame.origin.x = right - frame.size.width
      self.frame = frame
    }
  }
  
  var bottom: CGFloat {
    get {
      return frame.maxY
    }
    set(bottom) {
      var frame = standardizeRect(self.frame)
      
      frame.origin.y = bottom - frame.size.height
      self.frame = frame
    }
  }
  
  var width: CGFloat {
    get {
      return frame.width
    }
    set(width) {
      var frame = standardizeRect(self.frame)
      
      frame.size.width = width
      self.frame = frame
    }
  }
  
  var height: CGFloat {
    get {
      return frame.height
    }
    set(height) {
      var frame = standardizeRect(self.frame)
      
      frame.size.height = height
      self.frame = frame
    }
  }
  
  var centerX: CGFloat {
    get {
      return frame.midX
    }
    set(centerX) {
      center = CGPoint(x: centerX, y: center.y)
    }
  }
  
  var centerY: CGFloat {
    get {
      return center.y
    }
    set(centerY) {
      center = CGPoint(x: center.x, y: centerY)
    }
  }
  
  var size: CGSize {
    get {
      return standardizeRect(frame).size
    }
    set(size) {
      var frame = standardizeRect(self.frame)
      
      frame.size = size
      self.frame = frame
    }
  }
}
