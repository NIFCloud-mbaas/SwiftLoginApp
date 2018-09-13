//
//  SignUpViewController.swift
//  SwiftLoginApp
//
//  Created by Natsumo Ikeda on 2016/05/26.
//  Copyright 2017 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
//

import UIKit
import NCMB

class SignUpViewController: UIViewController {
    // User Name
    @IBOutlet weak var userNameTextField: UITextField!
    // Password
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordTextField_second: UITextField!
    
    // errorLabel
    @IBOutlet weak var errorLabel: UILabel!
    

    // 画面表示時に実行される
    override func viewDidLoad() {
        super.viewDidLoad()
        // Passwordをセキュリティ入力に設定
        self.passwordTextField.secureTextEntry = true
        self.passwordTextField_second.secureTextEntry = true
        
    }
    
    // SignUpボタン押下時の距離
    @IBAction func signUpBtn(sender: UIButton) {
        // キーボードを閉じる
        closeKeyboad()
        
        // 入力確認
        if self.userNameTextField.text!.isEmpty || self.passwordTextField.text!.isEmpty || self.passwordTextField_second.text!.isEmpty {
            self.errorLabel.text = "未入力の項目があります"
            // TextFieldを空に
            self.cleanTextField()
            
            return
            
        } else if passwordTextField.text! != passwordTextField_second.text! {
            self.errorLabel.text = "Passwordが一致しません"
            // TextFieldを空に
            self.cleanTextField()
            
            return
            
        }
        
        //NCMBUserのインスタンスを作成
        let user = NCMBUser()
        //ユーザー名を設定
        user.userName = self.userNameTextField.text
        //パスワードを設定
        user.password = self.passwordTextField.text
        
        //会員の登録を行う
        user.signUpInBackgroundWithBlock{(error: NSError!) in
            // TextFieldを空に
            self.cleanTextField()
            
            if error != nil {
                // 新規登録失敗時の処理
                self.errorLabel.text = "ログインに失敗しました:\(error.code)"
                print("ログインに失敗しました:\(error.code)")
                
            } else {
                // 新規登録成功時の処理
                self.performSegueWithIdentifier("signUp", sender: self)
                print("ログインに成功しました:\(user.objectId)")
                
            }
            
        }
        
    }
    
    // 背景タップするとキーボードを隠す
    @IBAction func tapScreen(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
    }
    
    // TextFieldを空にする
    func cleanTextField(){
        userNameTextField.text = ""
        passwordTextField.text = ""
        passwordTextField_second.text = ""
        
    }
    
    // errorLabelを空にする
    func cleanErrorLabel(){
        errorLabel.text = ""
        
    }
    
    // キーボードを閉じる
    func closeKeyboad(){
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        passwordTextField_second.resignFirstResponder()
        
    }
    
}
