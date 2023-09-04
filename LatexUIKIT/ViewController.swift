//
//  ViewController.swift
//  LatexUIKIT
//
//  Created by Divya Panthi on 01/09/2023.
//

import UIKit
import iosMath

class ViewController: UIViewController {
    
    lazy var mathLabel: MTMathUILabel = {
        
        let label = MTMathUILabel()
                                                
        label.latex = "The equation is x = \\frac{-b \\pm \\sqrt{b^2-4ac}}{2a}"
        
        label.displayErrorInline = true
        
        label.fontSize = 20
        
        return label
        
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white

        view.addSubview(mathLabel)

        mathLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            mathLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            mathLabel.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20),
            
            mathLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mathLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ])
        
    }

}

