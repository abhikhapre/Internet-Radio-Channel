//
//  FetchChannelImage.swift
//  InternetRadioChannel
//
//  Created by Abhishek Jaykrishna Khapare on 3/29/18.
//  Copyright © 2018 AbhishekJaykrishnaKhapare. All rights reserved.
//

import Foundation


class ChannelImageModel : NSObject {
   
    func fetchImageData(channelImageStr: String, ChannelImageData:@escaping(Data)->Void){
       
        let url = URL(string: channelImageStr)
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            guard let data = data else {return}
            ChannelImageData(data)
            
        }).resume()
    }
    
}
