//
//  ViewController.swift
//  iOSCalcApp
//
//  Created by Mattia Picariello on 13/02/2017.
//  Copyright © 2017 Mattia Picariello. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @IBOutlet var resultLabelTxt: UILabel!
    @IBOutlet var acButton: UIButton!
    var operandValueText : String = ""
    var opType : String = ""
    var initBool : Bool = false
    var operazioneInEsecuzione : String = ""
    var operandValue : Float = 0
    var risultato : Float = 0
    var error = false
    var savedOperandValue : Float = 0

    @IBOutlet var divButton: UIButton!
    @IBOutlet var mulButton: UIButton!
    @IBOutlet var subButton: UIButton!
    @IBOutlet var sumButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func operazioneButtonDidPressed(_ sender: UIButton) {
        let button = sender.currentTitle!
        var button2 : String = ""
        if button != "AC" || button != "C"{
            operandValue = variabile(operandValueText)
        }
        
        switch button {
        case "AC", "C":
            if acButton.title(for: .normal) == "C"{
                if operazioneInEsecuzione == "num"{
                    print("Aoooo")
                    operandValueText.remove(at: operandValueText.index(before: operandValueText.endIndex))
                    operandValue = variabile(operandValueText)
                    print(operandValue)
                    resultLabelTxt.text = "\(convertiVirgola("\(operandValue)"))"
                    if operandValue != 0{
                        operandValueText = "\(operandValue)"
                    } else {
                        operandValueText = ""
                    }
                    print(opType)
                    button2 = opType
                } else if operazioneInEsecuzione == "op"{
                    opType = ""
                } else if operazioneInEsecuzione == "="{
                    operandValue = 0
                    resultLabelTxt.text = "0"
                    operandValueText = ""
                    risultato = 0
                    opType = ""
                    initBool = false
                } else if operazioneInEsecuzione == "not"{
                    risultato = operandValue * (-1)
                    if risultato == Float(){
                        resultLabelTxt.text = "error"
                    } else {
                        resultLabelTxt.text = "\(convertiVirgola("\(risultato)"))"
                    }
                    opType = ""
                    operandValueText = "\(risultato)"
                } else if operazioneInEsecuzione == "%"{
                    risultato = operandValue * 100
                    if risultato == Float(){
                        resultLabelTxt.text = "error"
                    } else {
                        resultLabelTxt.text = "\(convertiVirgola("\(risultato)"))"
                    }
                    opType = ""
                    operandValue = 0
                    operandValueText = "\(risultato)"
                }
                operazioneInEsecuzione = "C"
                cToAC("AC")
            } else if acButton.title(for: .normal) == "AC"{
                operandValue = 0
                resultLabelTxt.text = "0"
                operandValueText = ""
                risultato = 0
                opType = ""
                initBool = false
                operazioneInEsecuzione = "AC"
            }
            
            
        case "=":
            if initBool == false{
                risultato += operandValue
                initBool = true
            }
            operazione(opType:opType)
            
            if error{
                resultLabelTxt.text = "error"
                error = false
            } else {
                resultLabelTxt.text = "\(convertiVirgola("\(risultato)"))"
            }
            
//            if risultato == nil {
//                resultLabelTxt.text = "error"
//            } else {
//                resultLabelTxt.text = "\(convertiVirgola("\(risultato)"))"
//            }
            opType = ""
            initBool = true
            operazioneInEsecuzione = "="
            /////////////////////PROBLEM num post =
        case "%":
            if operazioneInEsecuzione == "="{
                risultato = risultato / 100
                opType = ""
            } else {
                operandValue = operandValue / 100
            }
            resultLabelTxt.text = "\(convertiVirgola("\(operandValue)"))"
            operandValueText = "\(operandValue)"
            operazioneInEsecuzione = "%"
        case "+/-":
            if initBool == false{
                risultato += operandValue
                initBool = true
            }
            if risultato != 0 {
                if operazioneInEsecuzione == "="{
                    risultato = risultato * (-1)
                } else {
                    print(operandValue)
                    risultato = operandValue * (-1)
                }
                
                resultLabelTxt.text = "\(convertiVirgola("\(risultato)"))"
                opType = ""
                operandValueText = "\(risultato)"
                operazioneInEsecuzione = "not"
            }
        default:
            if opType != ""{
                if operazioneInEsecuzione == "op"{
                    if initBool == false{
                        risultato += operandValue
                        initBool = true
                    } else {
                        //reOperazione(opType:opType)
                        operazione(opType:button)
                        resultLabelTxt.text = "\(convertiVirgola("\(risultato)"))"
                    }
                    operazioneInEsecuzione = "op"
                    operandValueText = ""
                } else {
                    operazione(opType:opType)
                    resultLabelTxt.text = "\(convertiVirgola("\(risultato)"))"
                    operazioneInEsecuzione = "op"
                    operandValueText = ""
                }
            } else {
                if initBool == false{
                    risultato += operandValue
                    initBool = true
                } else {
                    operazione(opType:opType)
                    resultLabelTxt.text = "\(convertiVirgola("\(risultato)"))"
                }
                operazioneInEsecuzione = "op"
                operandValueText = ""
            }
        }
        
        resetBorder()
        if button2 == ""{
            switch button {
            case "+":
                opType = "+"
                sumButton.borderWidth = 3
            case "-":
                opType = "-"
                subButton.borderWidth = 3
            case "x":
                opType = "*"
                mulButton.borderWidth = 3
            case "÷":
                opType = "/"
                divButton.borderWidth = 3
            default:
                break
            }
        } else {
            print(button2)
            switch button2 {
            case "+":
                sumButton.borderWidth = 3
            case "-":
                subButton.borderWidth = 3
            case "*":
                mulButton.borderWidth = 3
            case "/":
                divButton.borderWidth = 3
            default:
                break
            }
            button2 = ""
        }
        
        
        
        
    }
    
    @IBAction func zeroButtonDidPressed(_ sender: Any) {
        numero(num: "0")
    }
    
    @IBAction func virgolaButtonDidPressed(_ sender: Any) {
        numero(num: ".")
    }
    
    @IBAction func unoButtonDidPressed(_ sender: Any) {
        numero(num: "1")
    }
    
    @IBAction func dueButtonDidPressed(_ sender: Any) {
        numero(num: "2")
    }
    
    @IBAction func treButtonDidPressed(_ sender: Any) {
        numero(num: "3")
    }
    
    @IBAction func quattroButtonDidPressed(_ sender: Any) {
        numero(num: "4")
    }
    
    @IBAction func cinqueButtonDidPressed(_ sender: Any) {
        numero(num: "5")
    }
    
    @IBAction func seiButtonDidPressed(_ sender: Any) {
        numero(num: "6")
    }
    
    @IBAction func setteButtonDidPressed(_ sender: Any) {
        numero(num: "7")
    }
    
    @IBAction func ottoButtonDidPressed(_ sender: Any) {
        numero(num: "8")
    }
    
    @IBAction func noveButtonDidPressed(_ sender: Any) {
        numero(num: "9")
    }
    
    
    func variabile(_ operandTextField: String?) -> Float{
        if let operand = operandTextField {
            if operand.isEmpty{
                return 0
            } else if operand == "."{
                return 0
            } else {
                return Float(operand)!
            }
        }
        return 0
    }
    
    func operazione(opType:String){
        print(risultato)
        switch opType {
        case "+":
            risultato += operandValue
        case "-":
            risultato -= operandValue
        case "*":
            if operandValue != 0 {
                risultato *= operandValue
            } else {
                risultato = 0
            }
        case "/":
            if operandValue != 0 {
                risultato /= operandValue
            } else {
                risultato = 0
                error = true
            }
            
        default:
            break
        }
        print(risultato)
        savedOperandValue = operandValue
        operandValue = 0
    }
    
    func reOperazione(opType:String){
        print(risultato)
        switch opType {
        case "+":
            risultato -= savedOperandValue
        case "-":
            risultato += savedOperandValue
        case "*":
            if savedOperandValue != 0 {
                risultato /= savedOperandValue
            } else {
                risultato = 0
            }
        case "/":
            if savedOperandValue != 0 {
                risultato *= savedOperandValue
            } else {
                risultato = 0
                error = true
            }
            
        default:
            break
        }
        print(risultato)
        savedOperandValue = 0
    }
    
    func convertiVirgola(_ operandText1: String) -> String{
        var operandText = operandText1
        let camelCasedSring:String
        if operandText.contains("."){
            var splittedString = operandText.components(separatedBy: ".")
            
            var stringa : String = ""
            if  splittedString[0].characters.count > 3 {
                for (index,value) in splittedString[0].characters.enumerated(){
                    if index == (splittedString[0].characters.count - 3){
                        stringa.append(".")
                        stringa.append(value)
                    } else {
                        stringa.append(value)
                    }
                }
                splittedString[0] = stringa
            }
            
            
            if splittedString.count == 2{
                if splittedString[1] == "0"{
                    camelCasedSring = splittedString[0]
                } else {
                    camelCasedSring = splittedString.joined(separator: ",")
                }
            } else {
                camelCasedSring = splittedString.joined(separator: ",")
            }
            
        } else {
            
            
            var stringa : String = ""
            if  operandText.characters.count > 3 {
                for (index,value) in operandText.characters.enumerated(){
                    if index == (operandText.characters.count - 3){
                        stringa.append(".")
                        stringa.append(value)
                    } else {
                        stringa.append(value)
                    }
                }
            } else {
                stringa = operandText
            }
            camelCasedSring = stringa
        }
        
        return camelCasedSring
    }
    
    func cToAC(_ string:String){
        acButton.setTitle(string, for: .normal)
    }
    
    func numero(num:String){
        print(operazioneInEsecuzione)
        if operazioneInEsecuzione == "=" /*|| operazioneInEsecuzione == "C" || operazioneInEsecuzione == "AC"*/{
            initBool = false
            risultato = 0
            operandValueText = num
            resultLabelTxt.text = "\(convertiVirgola("\(operandValueText)"))"
            operazioneInEsecuzione = "num"
            cToAC("C")
        } else {
            var stringa = operandValueText.replacingOccurrences(of: ".", with: "")
            stringa = operandValueText.replacingOccurrences(of: ",", with: "")
            if stringa.characters.count < 9 {
                if operazioneInEsecuzione != "C"{
                    operandValueText.append(num)
                } else {
                    var splittedString = operandValueText.components(separatedBy: ".")
                    var stringa2 = ""
                    if splittedString[1] == "0"{
                        stringa2 = operandValueText.replacingOccurrences(of: ".", with: "")
                        stringa2.remove(at: stringa2.index(before: stringa2.endIndex))
                    } else if splittedString[1] == "00"{
                        stringa2 = operandValueText
                        stringa2.remove(at: stringa2.index(before: stringa2.endIndex))
                    } else {
                        stringa2 = operandValueText
                        
                    }
                    stringa2.append(num)
                    operandValueText = stringa2
                }
                resultLabelTxt.text = "\(convertiVirgola("\(operandValueText)"))"
                if stringa.characters.count >= 6 {
                    resultLabelTxt.font = resultLabelTxt.font.withSize(62)
                } else {
                    resultLabelTxt.font = resultLabelTxt.font.withSize(93)
                }
                operazioneInEsecuzione = "num"
                cToAC("C")
            }
        }
        resetBorder()
    }
    
    func resetBorder(){
        sumButton.borderWidth = 0.5
        subButton.borderWidth = 0.5
        mulButton.borderWidth = 0.5
        divButton.borderWidth = 0.5
    }
    
    func resetBorder(_ op: String){
        switch op {
        case "+":
            subButton.borderWidth = 0.5
            mulButton.borderWidth = 0.5
            divButton.borderWidth = 0.5
        case "-":
            sumButton.borderWidth = 0.5
            mulButton.borderWidth = 0.5
            divButton.borderWidth = 0.5
        case "*":
            subButton.borderWidth = 0.5
            sumButton.borderWidth = 0.5
            divButton.borderWidth = 0.5
        case "/":
            subButton.borderWidth = 0.5
            mulButton.borderWidth = 0.5
            sumButton.borderWidth = 0.5
        default:
            sumButton.borderWidth = 0.5
            subButton.borderWidth = 0.5
            mulButton.borderWidth = 0.5
            divButton.borderWidth = 0.5
        }

    }
    
    func setBorder(_ op: String){
        switch op {
        case "+":
            sumButton.borderWidth = 3
        case "-":
            subButton.borderWidth = 3
        case "*":
            mulButton.borderWidth = 3
        case "/":
            divButton.borderWidth = 3
        default:
            sumButton.borderWidth = 3
            subButton.borderWidth = 3
            mulButton.borderWidth = 3
            divButton.borderWidth = 3
        }
        
    }
    
}
