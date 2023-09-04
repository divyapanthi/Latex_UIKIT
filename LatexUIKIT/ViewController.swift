//
//  ViewController.swift
//  LatexUIKIT
//
//  Created by Divya Panthi on 01/09/2023.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!

    override func viewDidLoad() {
        
        super.viewDidLoad()

        webView = WKWebView()
        
        webView.navigationDelegate = self
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
        
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
                
        loadHTMLWithEquations()
        
    }
    
    func loadHTMLWithEquations() {
        
        let inputString = """
                It seems that the student is facing some difficulties finding the combined standard deviation. They must remember that if \(latexToMathML(latex: "\\sigma_{2}")) and \(latexToMathML(latex: "\\sigma_{2}")) are the standard derivation of the two series of data with \(latexToMathML(latex: "n1")) and \(latexToMathML(latex: "n2")) number of observations, respectively, then the combined standard deviation of the two series of data is given by \(latexToMathML(latex: "\\sigma_{12}=\\sqrt{\\frac{n_{1} \\sigma_{1}^{2}+n_{2} \\sigma_{2}^{2}+n_{1} d_{1}^{2}+n_{2} d_{2}^{2}}{n_{1}+n_{2}}}")) where \(latexToMathML(latex: "d_{1}=\\overline{x_{1}}-\\overline{x_{12}}")) and \(latexToMathML(latex: "d_{2}=\\overline{x_{2}}-\\overline{x_{12}}"))
        """

        let htmlContent = """
        <!DOCTYPE html>
        <html>
        <head>
            <script type="text/javascript" async src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML"></script>
        </head>
        <body>
            <p>\(inputString)</p>
        </body>
        </html>
        """

        webView.loadHTMLString(htmlContent, baseURL: nil)
        
    }
    
    func latexToMathML(latex: String) -> String {
        // Convert LaTeX to MathML
        let escapedLatex = latex.replacingOccurrences(of: "\"", with: "\\\"")
        return "<span class='math' id='math' style='display: inline-block;'>\\( \(escapedLatex) \\)</span>"
    }
 
}

