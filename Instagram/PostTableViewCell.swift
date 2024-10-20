//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by mba2408.starlight kyoei.engine on 2024/10/19.
//

import UIKit
import FirebaseStorageUI

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!

    @IBOutlet weak var inputBtn: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentatorLabel: UILabel!
    
    @IBOutlet weak var inputLabel: UILabel!
    
    // PostDataの内容をセルに表示
    func setPostData(_ postData: PostData) {
        // 画像の表示
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        postImageView.sd_setImage(with: imageRef)

        // キャプションの表示
        self.captionLabel.text = "\(postData.name) : \(postData.caption)"
        
        // コメントのラベルを表示制御
        if postData.comment.isEmpty {
            self.inputLabel.isHidden = true
        } else {
            self.inputLabel.isHidden = false
        }

        // コメントの表示
        self.commentLabel.text = postData.comment

        // 更新者の表示
//        self.commentatorLabel.text = "更新者 : \(postData.commentator)"
        self.commentatorLabel.text = postData.commentator

        // 日時の表示
        self.dateLabel.text = postData.date

        // いいね数の表示
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"

        // いいねボタンの表示
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
    }
    
}
