//
//  ViewController.swift
//  Calculator
//
//  Created by Siddharth Dave on 21/08/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var ColorWell: UIColorWell!
    
    @IBOutlet weak var numOnScreen: UILabel!
    
    @IBOutlet weak var numOfCalc: UILabel!
    @IBOutlet var button: [UIButton]!
    var working:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ColorWell.selectedColor = UIColor.blue
        
        ColorWell.addTarget(self, action: #selector(self.colorDidChange), for: .valueChanged)
        
        
        if let selectedColor = UserDefaults.standard.value(forKey: "color") as? String {
            let selectedColorObj = selectedColor.colorWithHexString()
            
            self.view.backgroundColor  = selectedColorObj
        }
        
        for button in button
        {
            
            button.layer.cornerRadius = button.frame.size.height / 2
            
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        }
        
        
    }
    
    @objc func colorDidChange(_ sender: UIColorWell) {
        let selectedColor = sender.selectedColor
        view.backgroundColor = selectedColor
        
        if let haxColor = selectedColor?.hexStringFromColor() {
            UserDefaults.standard.set(haxColor, forKey: "color")
        }
        
    }
    
    func ClearAll()
    {
        working = ""
        numOnScreen.text = ""
    }
    
    func addToWorking(value: String)
    {
        if value == "%"
        {
            if !working.isEmpty, let currentValue = Double(working)
            {
                let result = currentValue / 100.0
                working = formatResult(result: result)
            }
        }
        else
        {
            working += value
        }
        
        numOfCalc.text = working
    }
    
    func formatResult(result: Double) -> String
    {
        if result.truncatingRemainder(dividingBy: 1) == 0
        {
            return String(format: "%.0f", result)
        }
        else
        {
            return String(format: "%.2f", result)
        }
    }
    
    
    func validInput() -> Bool
    {
        
        var count = 0
        var funcCharIndexs = [Int]()
        
        for char in working
        {
            if specialCharacter(char: char)
            {
                funcCharIndexs.append(count)
            }
            count += 1
        }
        print(funcCharIndexs)
        
        var previous:Int = -1
        
        for index in funcCharIndexs
        {
            if index == 0
            {
                return false
            }
            if index == working.count - 1
            {
                return false
            }
            
            if previous != -1
            {
                if index - previous == 1
                {
                    return false
                }
            }
            previous = index
        }
        
        return true
    }
    
    func specialCharacter(char: Character) -> Bool
    {
        if char == "*"
        {
            return true
        }
        if char == "/"
        {
            return true
        }
        if char == "+"
        {
            return true
        }
        return false
    }
    
    
    @IBAction func Allclear(_ sender: Any) {
        ClearAll()
    }
    
    @IBAction func Percentage(_ sender: Any) {
        addToWorking(value: "%")
    }
    
    @IBAction func DeleteLastValue(_ sender: Any) {
        
        if !working.isEmpty
        {
            working.removeLast()
            numOnScreen.text = working
        }
    }
    
    @IBAction func Divide(_ sender: Any) {
        addToWorking(value: "/")
    }
    
    @IBAction func Multiple(_ sender: Any) {
        addToWorking(value: "*")
    }
    
    @IBAction func Subtraction(_ sender: Any) {
        addToWorking(value: "-")
    }
    
    @IBAction func Addition(_ sender: Any) {
        addToWorking(value: "+")
    }
    
    @IBAction func EqualTo(_ sender: Any) {
        
        if validInput()
        {
            
            let expression = NSExpression(format: working)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            
            let resultString = formatResult(result: result)
            numOnScreen.text = resultString
        }
        else
        {
            let alert = UIAlertController(title: "Invalid Input", message: "Calculator unable to do math based on input" , preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
        }
        
    }
    
    
    @IBAction func oneTap(_ sender: Any) {
        addToWorking(value: "1")
    }
    
    @IBAction func TwoTap(_ sender: Any) {
        addToWorking(value: "2")
    }
    
    @IBAction func ThreeTap(_ sender: Any) {
        addToWorking(value: "3")
    }
    
    
    @IBAction func FourTap(_ sender: Any) {
        addToWorking(value: "4")
    }
    
    @IBAction func FiveTap(_ sender: Any) {
        addToWorking(value: "5")
    }
    
    @IBAction func SixTap(_ sender: Any) {
        addToWorking(value: "6")
    }
    
    @IBAction func SevenTap(_ sender: Any) {
        addToWorking(value: "7")
    }
    
    @IBAction func EightTap(_ sender: Any) {
        addToWorking(value: "8")
    }
    
    @IBAction func NineTap(_ sender: Any) {
        addToWorking(value: "9")
    }
    
    @IBAction func zeroZeroTap(_ sender: Any) {
        addToWorking(value: "00")
    }
    
    @IBAction func ZeroTap(_ sender: Any) {
        addToWorking(value: "0")
    }
    
    @IBAction func DotTap(_ sender: Any) {
        addToWorking(value: ".")
    }
    

}

