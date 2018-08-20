# 【iOS Swift】アプリにログイン機能をつけよう！
![画像1](/readme-img/001.png)

## 概要
* [ニフクラ mobile backend](https://mbaas.nifcloud.com/)の『会員管理機能』を利用してSwiftアプリにログイン機能を実装したサンプルプロジェクトです
* 簡単な操作ですぐに [ニフクラ mobile backend](https://mbaas.nifcloud.com/)の機能を体験いただけます★☆

## ニフクラ mobile backendって何？？
スマートフォンアプリのバックエンド機能（プッシュ通知・データストア・会員管理・ファイルストア・SNS連携・位置情報検索・スクリプト）が**開発不要**、しかも基本**無料**(注1)で使えるクラウドサービス！

注1：詳しくは[こちら](https://mbaas.nifcloud.com/price.htm)をご覧ください

![画像2](/readme-img/002.png)

## 動作環境
* Mac OS X 10.10(Yosemite)
* Xcode ver. 7.2.1
* Simulator ver. 9.2

※上記内容で動作確認をしています。


## 手順
### 1. [ニフクラ mobile backend](https://mbaas.nifcloud.com/)の会員登録とログイン→アプリ作成

* 上記リンクから会員登録（無料）をします。登録ができたらログインをすると下図のように「アプリの新規作成」画面が出るのでアプリを作成します

![画像3](/readme-img/003.png)

* アプリ作成されると下図のような画面になります
* この２種類のAPIキー（アプリケーションキーとクライアントキー）はXcodeで作成するiOSアプリに[ニフクラ mobile backend](https://mbaas.nifcloud.com/)を紐付けるために使用します

![画像4](/readme-img/004.png)

* 動作確認後に会員情報が保存される場所も確認しておきましょう

![画像5](/readme-img/005.png)

#### 2. GitHubからサンプルプロジェクトのダウンロード
* 下記リンクをクリックしてプロジェクトをダウンロードをMacにダウンロードします
 * __[SwiftLoginApp](https://github.com/natsumo/SwiftLoginApp/archive/master.zip)__

### 3. Xcodeでアプリを起動
* ダウンロードしたフォルダを開き、「SwiftLoginApp.xcworkspace」をダブルクリックしてXcode開きます(白い方です)

![画像09](/readme-img/009.png)

![画像6](/readme-img/006.png)

* 「SwiftLoginApp.xcodeproj」（青い方）ではないので注意してください！
![画像08](/readme-img/008.png)

### 4. APIキーの設定

* `AppDelegate.swift`を編集します
* 先程[ニフクラ mobile backend](https://mbaas.nifcloud.com/)のダッシュボード上で確認したAPIキーを貼り付けます

![画像07](/readme-img/007.png)

* それぞれ`YOUR_NCMB_APPLICATION_KEY`と`YOUR_NCMB_CLIENT_KEY`の部分を書き換えます
 * このとき、ダブルクォーテーション（`"`）を消さないように注意してください！
* 書き換え終わったら`command + s`キーで保存をします

### 5. 動作確認
* Xcode画面で左上の実行ボタン（さんかくの再生マーク）をクリックします

![画像12](/readme-img/012.png)

* __ビルド時にエラーが発生した場合の対処方法__
 * Xcodeのバージョンが古い場合`import NCMB`にエラーが発生し、上手くSDKが読み込めないことがあります
 * その場合は[【Swift】SDKの読み込みにuse framework!が使えない場合の対処方法](http://goo.gl/Z1D0K3)をご覧いただき、別の読み込み方法をお試しください

* シミュレーターが起動したら、Login画面が表示されます
* 初回は__`SignUp`__ ボタンをクリックして、会員登録を行います

![画像14](/readme-img/014.png)

* `User Name`と`Password`を２つ入力して![画像13](/readme-img/013.png)ボタンをタップします
* 会員登録が成功するとログインされ、下記画面が表示されます
 * このときmBaaS上に会員情報が作成されます！
 * ログインに失敗した場合は画面にエラーコードが表示されます
 * 万が一エラーが発生した場合は、[こちら](https://mbaas.nifcloud.com/doc/current/rest/common/error.html)よりエラー内容を確認いただけます

![画像15](/readme-img/015.png)

* __`Logout`__ ボタンをタップするとログアウトし、元の画面に戻ります
* 登録された会員情報を使ってLogin画面からログインが可能です（操作は同様です）

-----

* 保存に成功したら、[ニフクラ mobile backend](https://mbaas.nifcloud.com/)のダッシュボードから「会員管理」を確認してみましょう！

![画像1](/readme-img/001.png)

## 解説
サンプルプロジェクトに実装済みの内容のご紹介

#### SDKのインポートと初期設定
* ニフクラ mobile backend の[ドキュメント（クイックスタート）](https://mbaas.nifcloud.com/doc/current/introduction/quickstart_ios.html)をSwift版に書き換えたドキュメントをご用意していますので、ご活用ください
 * [SwiftでmBaaSを始めよう！(＜CocoaPods＞でuse_framewoks!を有効にした方法)](http://qiita.com/natsumo/items/57d3a4d9be16b0490965)
 * [＜CocoaPods＞SwiftでmBaaSを始めよう！](http://qiita.com/natsumo/items/b2d18d87d57300c8d81c)

#### ロジック
 * `Main.storyboard`でデザインを作成し、`LoginViewController.swift`,`SignUpViewController.swift`,`LogoutViewController.swift`にロジックを書いています
 * ログイン、会員登録、ログアウト部分の処理は以下のように記述されます　※ただし、左記処理以外のコードは除いています

`LoginViewController.swift`

```swift
// ログイン
NCMBUser.logInWithUsernameInBackground(self.userNameTextField.text, password: self.passwordTextField.text, block:{(user: NCMBUser?, error: NSError!) in
    if error != nil {
        // ログイン失敗時の処理

    }else{
        // ログイン成功時の処理

    }
})
```

`SignUpViewController.swift`

```swift
//会員登録
user.signUpInBackgroundWithBlock{(error: NSError!) in
    if error != nil {
        // 新規登録失敗時の処理

    }else{
        // 新規登録成功時の処理

    }
}
```

`LogoutViewController.swift`

```swift
// ログアウト
NCMBUser.logOut()
```

## 参考
* ニフクラ mobile backend の[ドキュメント（会員管理）](https://mbaas.nifcloud.com/doc/current/user/basic_usage_ios.html)をSwift版に書き換えたドキュメントをご用意していますので、ご活用ください
 * [Swiftでログイン機能をつけてみよう！](http://qiita.com/natsumo/items/25c97182fab4db5629b1)
* 同じ内容の【Objective-C】版もご用意しています
 * https://github.com/natsumo/ObjcLoginApp
