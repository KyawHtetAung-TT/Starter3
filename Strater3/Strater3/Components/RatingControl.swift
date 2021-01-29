//
//  RatingControl.swift
//  Strater3
//
//  Created by kyaw htet aung on 2021/01/29.
//

import UIKit

@IBDesignable
class RatingControl: UIStackView {

    @IBInspectable var starSize : CGSize = CGSize(width: 50.0, height: 50.0){
        didSet{
            SetupButton()
            updateButtonRating()
        }
    }
    @IBInspectable var starCount : Int = 5{
        didSet{
            SetupButton()
            updateButtonRating()
        }
    }
    @IBInspectable var rating : Int = 3{
        didSet{
            updateButtonRating()
        }
    }
    var ratingButton = [UIButton]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetupButton()
        updateButtonRating()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        SetupButton()
        updateButtonRating()
    }
    private func SetupButton(){
        clearExistingButton()
        
        for _ in 0..<starCount{
            
        let button = UIButton()
            button.setImage(UIImage(named: "fillstar"), for: .selected)
            button.setImage(UIImage(named: "emptystar"), for: .normal)
            
        button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
        addArrangedSubview(button)
            button.isUserInteractionEnabled = false
            
            ratingButton.append(button)
        }
        
    }
    
    private func updateButtonRating(){
        for (index,button) in ratingButton.enumerated(){
            button.isSelected = index < rating
            
        }
    
    }
    private func clearExistingButton(){
        for button in ratingButton{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButton.removeAll()
    }
}
