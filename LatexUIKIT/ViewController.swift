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
    
    var equation1 = "It seems that the student is facing some difficulties 20$ finding the combined $x^2$ standard deviation. They must remember that if $\\sigma_{1}$ and $\\sigma_{2}$ are the standard derivation of the two series of data with n1 and n2 number of observations, respectively, then the combined standard deviation of the two series of data is given by `\\sigma_{12}=\\sqrt{\\frac{n_{1} \\sigma_{1}^{2}+n_{2} \\sigma_{2}^{2}+n_{1} d_{1}^{2}+n_{2} d_{2}^{2}}{n_{1}+n_{2}}}`, where `d_{1}=\\overline{x_{1}}-\\overline{x_{12}}` and `d_{2}=\\overline{x_{2}}-\\overline{x_{12}}`."
    
    var equation2 = "If `C(n,r-1)=36`, `C(n,r)=84` and `C(n,r+1)=126`, find the value of $n$ and $r$. \nयदि `C(n,r-1)=36`, `C(n,r)=84` र `C(n,r+1)=126` छ भने `n` र `r` को value पत्ता लगाऊ |"
    
//    var equation3 = "y=A sin 2\pi(\frac{t}{T}-\frac{x}{\lamda})"
    
    var equation5 = "y=A sin (\\omegat-kx)"
    
    var equation4 = "The quadratic formula is `x=\\frac{-b\\pm\\sqrt{b^2-4ac}}{2a}` and it has zeros at the roots of `f(x)=ax^2+bx+c`."
    

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
    
        let inputString = equation4
        
        let processedString = processEquationsInText(inputString)
                
        let htmlContent = """
        <!DOCTYPE html>
        <html>
        <head>
            <style>
            </style>
            <script type="text/javascript" async src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML"></script>
        </head>
        <body>
            <p style = "font-size:50px">\(processedString)</p>
        </body>
        </html>
        """

        webView.loadHTMLString(htmlContent, baseURL: nil)
        
    }
    
    func processEquationsInText(_ text: String) -> String {
        
        var processedText = text

        let pattern = #"(?<!`)(?<!\\)(\$\\[^$]+\$)(?![`\\])"#
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: text.utf16.count)
        
        let matches = regex.matches(in: text, options: [], range: range)
        
        for match in matches.reversed() {
            let equationRange = Range(match.range(at: 1), in: text)!
            let equation = String(text[equationRange])
            
            // Ensure starting and ending backticks without dollar signs
            let modifiedEquation = "`" + equation.dropFirst(2).dropLast(1) + "`"
            
            // Replace the original equation with the modified one
            processedText.replaceSubrange(equationRange, with: modifiedEquation)
            
        }
        
        return processedText
    }
    
    func latexToMathML(latex: String) -> String {

        let escapedLatex = latex.replacingOccurrences(of: "\"", with: "\\\"")
        
        return "<span class='math' id='math' style='display: inline-block;'>\\( \(escapedLatex) \\)</span>"
        
    }
    
}


// $..$
// $$..$$
// $\\
// \\


//let singleDollarPattern = #"(?<!`)(?<!\\)(\$[^$]+\$)(?![`\\])"#
//let singleDollarRegex = try! NSRegularExpression(pattern: singleDollarPattern)
//processedText = singleDollarRegex.stringByReplacingMatches(in: processedText, options: [], range: NSRange(location: 0, length: processedText.utf16.count), withTemplate: "`$1`")
//
//let dollarSlashPattern = #"(?<!`)(?<!\\)(\$\\[^$]+\$)(?![`\\])"#
//let dollarSlashRegex = try! NSRegularExpression(pattern: dollarSlashPattern)
//processedText = dollarSlashRegex.stringByReplacingMatches(in: processedText, options: [], range: NSRange(location: 0, length: processedText.utf16.count), withTemplate: "`$1`")



//        let inputString = """
//                It seems that the student is facing some difficulties finding the combined standard deviation. They must remember that if \(latexToMathML(latex: "\\sigma_{2}")) and \(latexToMathML(latex: "\\sigma_{2}")) are the standard derivation of the two series of data with \(latexToMathML(latex: "n1")) and \(latexToMathML(latex: "n2")) number of observations, respectively, then the combined standard deviation of the two series of data is given by \(latexToMathML(latex: "\\sigma_{12}=\\sqrt{\\frac{n_{1} \\sigma_{1}^{2}+n_{2} \\sigma_{2}^{2}+n_{1} d_{1}^{2}+n_{2} d_{2}^{2}}{n_{1}+n_{2}}}")) where \(latexToMathML(latex: "d_{1}=\\overline{x_{1}}-\\overline{x_{12}}")) and \(latexToMathML(latex: "d_{2}=\\overline{x_{2}}-\\overline{x_{12}}"))
//        """


//
//let singleDollarPattern = #"(?<!`)(?<!\\)(\$[^$]+\$)(?![`\\])"#
//let dollarSlashPattern = #"(?<!`)(?<!\\)(\$\\[^$]+\$)(?![`\\])"#
//let backTickPattern = #"(?<!`)(?<!\\)(\`[^$]+\`)(?![`\\])"#
