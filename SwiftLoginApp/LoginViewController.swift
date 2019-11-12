//
//  LoginViewController.swift
//  SwiftLoginApp
//
//  Created by Natsumo Ikeda on 2016/05/26.
//  Copyright 2017 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
//

import UIKit
import NCMB

class LoginViewController: UIViewController {
    // User Name
    @IBOutlet weak var userNameTextField: UITextField!
    // Password
    @IBOutlet weak var passwordTextField: UITextField!
    // errorLabel
    @IBOutlet weak var errorLabel: UILabel!
    
    // 画面表示時に実行される
    override func viewDidLoad() {
        super.viewDidLoad()
        // Passwordをセキュリティ入力に設定する
        self.passwordTextField.isSecureTextEntry = true
        
    }
    
    // Loginボタン押下時の処理
    @IBAction func loginBtn(_ sender: UIButton) {
        // キーボードを閉じる
        closeKeyboad()
        
        // 入力確認
        if self.userNameTextField.text!.isEmpty || self.passwordTextField.text!.isEmpty {
            self.errorLabel.text = "未入力の項目があります"
            // TextFieldを空に
            self.cleanTextField()
            
            return
            
        }
        
        // ユーザー名とパスワードでログイン
        NCMBUser.logInInBackground(userName: self.userNameTextField.text!, password: self.passwordTextField.text!, callback:{ result in
            // TextFieldを空に
            DispatchQueue.main.sync {
                self.cleanTextField()
            }
            
            switch result {
                case .success:
                    // ログイン成功時の処理
                    DispatchQueue.main.sync {
                        self.performSegue(withIdentifier: "login", sender: self)
                    }
                    let user:NCMBUser = NCMBUser.currentUser!
                    print("ログインに成功しました:\(String(describing: user.objectId))")
                case let .failure(error):
                    // 保存に失敗した場合の処理
                    DispatchQueue.main.sync {
                        self.errorLabel.text = "ログインに失敗しました:\(error)"
                    }
                    print("ログインに失敗しました:\(error)")
            }
        })
        
    }
    
    // SignUp画面へ遷移
    @IBAction func toSignUp(_ sender: Any) {
        // TextFieldを空にする
        cleanTextField()
        // errorLabelを空に
        cleanErrorLabel()
        // キーボードを閉じる
        closeKeyboad()
        
        self.performSegue(withIdentifier: "loginToSignUp", sender: self)
        
    }
    
    // 背景タップするとキーボードを隠す
    @IBAction func tapScreen(_sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
    }
    
    // TextFieldを空にする
    func cleanTextField(){
        userNameTextField.text = ""
        passwordTextField.text = ""
        
    }
    
    // errorLabelを空にする
    func cleanErrorLabel(){
        errorLabel.text = ""
        
    }
    
    // キーボードを閉じる
    func closeKeyboad(){
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
    }

}
