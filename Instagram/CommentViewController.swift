//
//  CommentViewController.swift
//  Instagram
//
//  Created by mba2408.starlight kyoei.engine on 2024/10/20.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import SVProgressHUD

class CommentViewController: UIViewController {

    @IBOutlet weak var commentView: UITextView!
    
    var documentId = ""
    var latestSentence = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 枠のカラー
        commentView.layer.borderColor = UIColor.gray.cgColor
        
        // 枠の幅
        commentView.layer.borderWidth = 1.2
        
        // 枠を角丸にする場合
        commentView.layer.cornerRadius = 10.0
        commentView.layer.masksToBounds = true
        
        print(documentId)
        commentView.text = latestSentence

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handlePostButton(_ sender: Any) {
        let postRef = Firestore.firestore().collection(Const.PostPath).document(documentId)
        // FireStoreに投稿データを保存する
        let name = Auth.auth().currentUser?.displayName
        let newComments: [String: Any] = [
            "latest_comments": [
                "updatedAt": FieldValue.serverTimestamp(),
                "updatedBy": name!,
                "sentence": self.commentView.text!,
            ]
        ]
        
        postRef.updateData(newComments)

        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        // 投稿処理が完了したので先頭画面に戻る
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func handleCancelButton(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }

}
