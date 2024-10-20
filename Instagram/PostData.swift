//
//  PostData.swift
//  Instagram
//
//  Created by mba2408.starlight kyoei.engine on 2024/10/19.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class PostData: NSObject {
    var id = ""
    var name = ""
    var caption = ""
    var commentator = ""
    var comment = ""
    var date = ""
    var likes: [String] = []
    var isLiked: Bool = false

    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID

        let postDic = document.data()

        if let name = postDic["name"] as? String {
            self.name = name
        }

        if let caption = postDic["caption"] as? String {
            self.caption = caption
        }
        
        if let comments = postDic["latest_comments"] as? [String: Any] {
            if let updatedBy = comments["updatedBy"] as? String {
                self.commentator = updatedBy
            }
            if let sentence = comments["sentence"] as? String {
                self.comment = sentence
            }
        }

        if let timestamp = postDic["date"] as? Timestamp {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            self.date = formatter.string(from: timestamp.dateValue())
        }

        if let likes = postDic["likes"] as? [String] {
            self.likes = likes
        }

        if let myid = Auth.auth().currentUser?.uid {
            // likesの配列の中にmyidが含まれているかチェックすることで、自分がいいねを押しているかを判断
            if self.likes.firstIndex(of: myid) != nil {
                // myidがあれば、いいねを押していると認識する。
                self.isLiked = true
            }
        }
    }

    override var description: String {
        return "PostData: name=\(name); caption=\(caption); commentator=\(commentator); comment=\(comment); date=\(date); likes=\(likes.count); id=\(id);"
    }
}
