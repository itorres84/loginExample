//
//  ViewController.swift
//  Login
//
//  Created by Israel Torres Alvarado on 02/03/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtEmail: UITextField! {
        didSet {
            txtEmail.keyboardType = .emailAddress
            txtEmail.autocorrectionType = .no
        }
    }
    
    @IBOutlet weak var txtPassword: UITextField! {
        didSet {
            txtPassword.keyboardType = .default
            txtPassword.isSecureTextEntry = true
            txtPassword.delegate = self
            
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "eye.png"), for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
            button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
            button.addTarget(self, action: #selector(self.showPassword), for: .touchUpInside)
            
            txtPassword.rightView = button
            txtPassword.rightViewMode = .always
            
            txtPassword.layer.borderColor = UIColor.red.cgColor
            txtPassword.layer.borderWidth = 1.0
            
        }
    }
    
    @IBOutlet weak var indicator: UIActivityIndicatorView! {
        didSet {
            indicator.isHidden = true
            indicator.hidesWhenStopped = true
        }
    }
    
    @IBOutlet weak var segmentColor: UISegmentedControl! {
        didSet {
            segmentColor.selectedSegmentTintColor = .red
        }
    }
    
    @IBOutlet weak var btnLogin: UIButton!
    
    let userRepository = UserRepository()
    
    var email: String = ""
    var password: String = ""
    
    var timer: Timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func showPassword(_ sender: Any) {
        
        print(txtPassword.isSecureTextEntry)
        txtPassword.isSecureTextEntry = !txtPassword.isSecureTextEntry
    
    }

    @IBAction func singIn(_ sender: Any) {
        
        guard let email = txtEmail.text, let password = txtPassword.text else {
            print("No se puede iniciar sesion con estos datos")
            return
        }
        
        if email != "", password != "" {
             
            self.email = email
            self.password = password
            self.indicator.isHidden = false
            self.indicator.startAnimating()
            timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.login), userInfo: nil, repeats: true)
            
            
           
        } else {
            print("Falta algun dato para iniciar sesion")
            mostrarAlerta(title: "Error", message: "Falta algun dato para iniciar sesion")
        }
    
    }
    
    @objc func login() {
    
        timer.invalidate()
        indicator.stopAnimating()
        if userRepository.login(email: email , passwordView: password) {
            print("Usuario valido....")
            mostrarAlerta(title: "", message: "Bienvenido eres un usuario valido..")
        } else {
            print("Usuario invalido....")
            mostrarAlerta(title: "Error", message: "Usuario invalido....")
        }
    
    }
    
    func mostrarAlerta(title: String, message: String) {
        
        let alertLogin = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let accionAlert = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertLogin.addAction(accionAlert)
        
        self.present(alertLogin, animated: true, completion: nil)

    }
    
    
    @IBAction func valueChanged(_ sender: UISlider) {
    
        print(sender.value)
        
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            sender.selectedSegmentTintColor = .red
            btnLogin.backgroundColor = .red
            
        case 1:
            sender.selectedSegmentTintColor = .green
            btnLogin.backgroundColor = .green
        case 2:
            sender.selectedSegmentTintColor = .blue
            btnLogin.backgroundColor = .blue
        default:
            print("index no controlado : \(sender.selectedSegmentIndex)")
        }
        
    }
    
    
    
}

extension ViewController {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.login()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        txtPassword.layer.borderColor = UIColor.clear.cgColor
        txtPassword.layer.borderWidth = 0.0
    }
    
}

