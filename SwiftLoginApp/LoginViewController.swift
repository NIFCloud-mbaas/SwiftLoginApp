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
        self.passwordTextField.secureTextEntry = true
        
    }
    
    // Loginボタン押下時の処理
    @IBAction func loginBtn(sender: UIButton) {
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
        NCMBUser.logInWithUsernameInBackground(self.userNameTextField.text, password: self.passwordTextField.text, block:{(user: NCMBUser?, error: NSError!) in
            // TextFieldを空に
            self.cleanTextField()
            
            if error != nil {
                // ログイン失敗時の処理
                self.errorLabel.text = "ログインに失敗しました:\(error.code)"
                print("ログインに失敗しました:\(error.code)")
                
            }else{
                // ログイン成功時の処理
                self.performSegueWithIdentifier("login", sender: self)
                print("ログインに成功しました:\(user?.objectId)")
                
            }
            
        })
        
    }
    
    // SignUp画面へ遷移
    @IBAction func toSignUp(sender: UIButton) {
        // TextFieldを空にする
        cleanTextField()
        // errorLabelを空に
        cleanErrorLabel()
        // キーボードを閉じる
        closeKeyboad()
        
        self.performSegueWithIdentifier("loginToSignUp", sender: self)
        
    }
    
    // 背景タップするとキーボードを隠す
    @IBAction func tapScreen(sender: UITapGestureRecognizer) {
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
