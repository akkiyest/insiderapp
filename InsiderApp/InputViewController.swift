//
//  InputViewController.swift
//  InsiderApp
//
//  Created by Akihiro Itoh on 2016/10/22.
//  Copyright © 2016年 akihiro.itoh. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {
    var JAN:String = ""
    var titles:[String?] = []
    var msg:[String?] = []
    var counts:Int = 0
    //数字を入力させる。
    //var maxinput:Int = PlayerControll.sharedHQ.inputnum
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Number: UILabel!
    @IBOutlet weak var Keywords: UITextField!
    let numberToolbar: UIToolbar = UIToolbar()
    
    @IBOutlet weak var imageview: UIImageView!
    override func viewDidLoad(){
        super.viewDidLoad()
        imageview.image = #imageLiteral(resourceName: "scene2")
        
        numberToolbar.barStyle = UIBarStyle.blackTranslucent
        numberToolbar.items=[
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "確定", style: UIBarButtonItemStyle.plain, target: self, action: #selector(settingViewController.boopla))
        ]
        
        
        numberToolbar.sizeToFit()
        Name.inputAccessoryView = numberToolbar
        Keywords.inputAccessoryView = numberToolbar

    }
    
    override func viewDidAppear(_ animated: Bool) {
        titles.append("Welcome to Insider Orig!ns")
        super.viewDidLoad()
        let RAN1 = arc4random_uniform(2)
        if RAN1 == 1 {
            msg.append("じゃんけん・勝ち残りで出題者役のプレイヤーを決めてください。")
        } else {
            msg.append("じゃんけん・負け残りで出題者役のプレイヤーを決めてください。")
        }
        
        //インサイダーがいないモード実装
        //先行して[0]の名前に「インサイダーは居ない」と、ランダムのキーワードをログから取る、countを１回まわす
        if PlayerControll.sharedHQ.gisinmode == 1{
            rolling()
        }
        
        let messages: UIAlertController? = UIAlertController(title: titles[0], message:self.msg[0],preferredStyle:UIAlertControllerStyle.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            self.inputFirst()
            })
        messages?.addAction(defaultAction)
        present(messages!, animated: true, completion: nil)
        print(PlayerControll.sharedHQ.PASSCODEs)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //カウントを1回すメソッド
    func rolling(){
        counts += 1
    }
    
    func inputFirst(){
        let messages:UIAlertController = UIAlertController(title: "入力を順に行います。", message:"出題者役プレイヤーの\n右隣のプレイヤーが\n端末を受け取ったら\nOKを押してください。",preferredStyle:UIAlertControllerStyle.alert)
        let defaultAction2nd: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            self.appers()
        })
        messages.addAction(defaultAction2nd)
        self.present(messages, animated: true, completion: nil)
    }
    
    func appers(){
        Number.text? = PlayerControll.sharedHQ.PASSCODEs[self.counts]
    }
    
    //パスワードをチェックする
    func disappercheck(){
        Number.text = "****"
        let messages:UIAlertController = UIAlertController(title: "パスコードチェック", message:"パスコードを入力してください",preferredStyle:UIAlertControllerStyle.alert)
        messages.addTextField(configurationHandler: {(text:UITextField!) -> Void in
        })
        let inputpasscode = messages.textFields![0] as UITextField
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            if PlayerControll.sharedHQ.PASSCODEs[self.counts] == inputpasscode.text! {
                self.OK()
            }else{
                //違ったときの処理
                self.wrong()
            }
        })
        messages.addAction(defaultAction)
        self.present(messages, animated: true, completion: nil)

    }
    //進むボタンの処理
    @IBAction func goButton(_ sender: AnyObject) {
        if  Name.text! == ""{
            let messages:UIAlertController = UIAlertController(title: "注意", message:"名前がありません。",preferredStyle:UIAlertControllerStyle.alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
            })
            messages.addAction(defaultAction)
            self.present(messages, animated: true, completion: nil)
            
        } else if Keywords.text! == ""{
            let messages:UIAlertController = UIAlertController(title: "注意", message:"キーワードが未入力です。",preferredStyle:UIAlertControllerStyle.alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
            })
            messages.addAction(defaultAction)
            self.present(messages, animated: true, completion: nil)
            
        }
        
        
        
        let messages:UIAlertController = UIAlertController(title: "確認", message:Name.text!+"さん\nキーワードは"+Keywords.text!,preferredStyle:UIAlertControllerStyle.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            self.disappercheck()
        })
        messages.addAction(defaultAction)
        self.present(messages, animated: true, completion: nil)
        
    }
    
    func OK(){
        //PlayerControllにデータを渡す記述をする
        PlayerControll.sharedHQ.Names[self.counts] = Name.text!
        PlayerControll.sharedHQ.Keywords[self.counts] = Keywords.text!
        //消す
        Name.text = ""
        Keywords.text = ""
        let messages:UIAlertController = UIAlertController(title: "確認しました。", message:"パスコードを\n記憶しておいてください。",preferredStyle:UIAlertControllerStyle.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            if self.counts == PlayerControll.sharedHQ.PlayerNum{
                self.endInput()
            }else{
                self.nextplayer()
            }
        })
        messages.addAction(defaultAction)
        self.present(messages, animated: true, completion: nil)
    }
    //次のプレイヤーに手渡されるときの処理
    func nextplayer(){
        let messages:UIAlertController = UIAlertController(title: "受け渡してください", message:PlayerControll.sharedHQ.Names[self.counts]!+"さんの右隣の人ですか？",preferredStyle:UIAlertControllerStyle.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            self.rolling()
            if self.counts == PlayerControll.sharedHQ.PlayerNum{
                self.endInput()
            } else {
            self.appers()
            }
        }
        )
        messages.addAction(defaultAction)
        self.present(messages, animated: true, completion: nil)
    }
    //パスコード確認が間違っていたときの処理
    func wrong(){
        let messages:UIAlertController = UIAlertController(title: "パスコードが異なります", message:"もう一度確認して入力してください",preferredStyle:UIAlertControllerStyle.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            self.appers()
        })
        messages.addAction(defaultAction)
        self.present(messages, animated: true, completion: nil)
        
    }
    //最後の入力が終わったときのダイアログ
    func endInput(){
        print(PlayerControll.sharedHQ.Keywords)
        print(PlayerControll.sharedHQ.Names)
        print(PlayerControll.sharedHQ.PASSCODEs)
        let messages:UIAlertController = UIAlertController(title: "端末を手渡してください", message:"出題者役のプレイヤーがOKを\nを押してください。",preferredStyle:UIAlertControllerStyle.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            let targetViewController = self.storyboard?.instantiateViewController(withIdentifier: "checkAnswer")
            self.present(targetViewController!, animated: true, completion: nil)
        })
        messages.addAction(defaultAction)
        self.present(messages, animated: true, completion: nil)
        
    }
    
    //入力を中止するときのメソッド
    @IBAction func stopInput(_ sender: AnyObject) {
    PlayerControll.sharedHQ.destroy()
    dismiss(animated: true, completion: nil )
    }
    
    func boopla(){
        Name.resignFirstResponder()
        Keywords.resignFirstResponder()
    }
    
    
}
