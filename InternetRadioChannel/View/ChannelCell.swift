//
//  ChannelCell.swift
//  InternetRadioChannel
//
//  Created by Abhishek Jaykrishna Khapare on 3/29/18.
//  Copyright © 2018 AbhishekJaykrishnaKhapare. All rights reserved.
//

import UIKit


class ChannelCell: UITableViewCell {

    var radioChannel : Channel? {
        didSet {
            titleLabel.text = radioChannel?.title
            djLabel.text = radioChannel?.dj
            descriptionLabel.text = radioChannel?.description
            setupThumbnailImage()
        }
    }

    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var djLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    var urlString : String?
    func setupThumbnailImage() {
        
        if let imageUrlString = radioChannel?.image {
         urlString = imageUrlString
            self.thumbnailImage.image = nil
            
            if let imageFromCache = imageCache.object(forKey: imageUrlString as AnyObject) as? UIImage {
                thumbnailImage.image = imageFromCache
                return
            }
            
            let channelImageModel = ChannelImageModel()
            channelImageModel.fetchImageData(channelImageStr : imageUrlString){
                data in
                    DispatchQueue.main.async {
                        let imageToCache = UIImage(data: data)
                        
                        if self.urlString == imageUrlString {
                            self.thumbnailImage.image = imageToCache
                        }
                        self.imageCache.setObject(imageToCache!, forKey: imageUrlString as AnyObject)
                        
                }
            }
        }
    }
}
