//
//  RadioChannelDetailController.swift
//  InternetRadioChannel
//
//  Created by Abhishek Jaykrishna Khapare on 3/29/18.
//  Copyright © 2018 AbhishekJaykrishnaKhapare. All rights reserved.
//

import UIKit

/*
 This screen displays the detail Properties about the Radio Channel
 
 */

class RadioChannelDetailController: UIViewController {

    @IBOutlet weak var channelImage: UIImageView!
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var channelDjLabel: UILabel!
    @IBOutlet weak var channelDjEmailLabel: UILabel!
    @IBOutlet weak var channelNoOfListenersLabel: UILabel!
    @IBOutlet weak var channelGenreLabel: UILabel!
    
    var radioChannel : Channel?
    let channelImageModel = ChannelImageModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
      fetchChannelImage()
        channelTitleLabel.text = radioChannel?.title ?? "N/A"
        channelDjLabel.text = radioChannel?.dj ?? "N/A"
        channelDjEmailLabel.text = radioChannel?.djmail ?? "N/A"
        channelNoOfListenersLabel.text = radioChannel?.listeners ?? "N/A"
        channelGenreLabel.text = radioChannel?.genre ?? "N/A"
    }
    
    func fetchChannelImage(){
        guard let channelImage = radioChannel?.image else {return}
        channelImageModel.fetchImageData(channelImageStr : channelImage){
             data in
            DispatchQueue.main.async {
                self.channelImage.image = UIImage(data: data)
            }
        }
    }
  
}
