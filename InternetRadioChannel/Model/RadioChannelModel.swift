//
//  RadioChannelModel.swift
//  InternetRadioChannel
//
//  Created by Abhishek Jaykrishna Khapare on 3/29/18.
//  Copyright © 2018 AbhishekJaykrishnaKhapare. All rights reserved.
//

import Foundation

class RadioChannelModel : NSObject{
    
    var radioChannel : RadioChannel?
    
    func fetchRadioData(urlString : String, ChannelData:@escaping(RadioChannel)->Void){
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            do{
                let radioChannels = try JSONDecoder().decode(RadioChannel.self, from: data)
                self.radioChannel = radioChannels
            }catch let jsonError{
                print("Error : ", jsonError)
                
                
            }
            if let radioChannel = self.radioChannel{
                ChannelData(radioChannel)
            }
            }.resume()
    }
}
