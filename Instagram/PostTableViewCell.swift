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
    
    // セルのリサイクル対策での初期化処理を行う
    override func prepareForReuse() {
        super.prepareForReuse()
        self.commentLabel.attributedText = nil
    }
    
    // PostDataの内容をセルに表示
    func setPostData(_ postData: PostData) {
        // 画像の表示
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        postImageView.sd_setImage(with: imageRef)
        
        // キャプションの表示
        self.captionLabel.text = "\(postData.name) : \(postData.caption)"
        
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
        
        let endNum = postData.comments.count
        let attributedString = NSMutableAttributedString()
        
        // 行間の設定
        let lineSpaceStyle = NSMutableParagraphStyle()
        lineSpaceStyle.lineSpacing = 10

        for n in 0 ..< endNum {
            let commentSrc = postData.comments[n]
            
            let commentator = commentSrc["commentator"] as? String
            let commentatorStr = NSMutableAttributedString(
                string: commentator! + "\n",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 14),
                    .foregroundColor: UIColor.gray
                ]
            )
            
            attributedString.append(commentatorStr)
            
            var sentence = commentSrc["sentence"] as? String
            if n < (endNum-1) {
                sentence! += "\n"
            }
            let sentenceStr = NSMutableAttributedString(
                string: sentence!,
                attributes: [
                    .font: UIFont.systemFont(ofSize: 18),
                    .paragraphStyle: lineSpaceStyle
                ]
            )
            
            attributedString.append(sentenceStr)
        }
        
        self.commentLabel.attributedText = attributedString
    }
}
