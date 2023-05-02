//
//  APIHelper.swift
//  Pet Generator
//
//  Created by Vitor Sousa on 01/05/2023.
//

import Foundation

class APIHelper {
    static let shared = APIHelper()
    
    let imageWidth = 450
    let imageHeight = 350
    
    func generatePet(pet: AllowedPets, completion: @escaping (Pet) -> Void) {
        let randomNumber = generateRandomNumber(min: 500, max: 9000)
        let photoUrl = getPetPhotoUrl(pet: pet)
        
        generateUser { user in
            let pet = Pet.init(
                animal: pet,
                name: user.name.first,
                quote: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus in.",
                age: user.dob.age,
                likes: randomNumber,
                photoUrl: photoUrl
            )
            
            completion(pet)
        }
    }
    
    private func generateUser(completion: @escaping((User) -> Void)) {
        let userUrl = getUserUrl()
        
        URLSession.shared.dataTask(with: userUrl) { data, _, _ in
            if let d = data {
                let decoder = JSONDecoder()
                
                do {
                    let users = try decoder.decode(UserApiData.self, from: d)
                    let firstUser = users.results.first
                    
                    if firstUser == nil {
                        print("The API broke.")
                        return
                    }
                    
                    completion(firstUser!)
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print("Either network error or the API broke.")
            }
        }.resume()
    }
    
    private func getUserUrl() -> URL {
        let urlString = "https://randomuser.me/api/?inc=gender,name,dob&nat=fr,us&gender=male&noinfo"
        
        return URL(string: urlString)!
    }
    
    private func getPetPhotoUrl(pet: AllowedPets) -> URL {
        let urlString = "https://source.unsplash.com/random/\(imageWidth)x\(imageHeight)/?\(pet)"
        
        return URL(string: urlString)!
    }
}

func generateRandomNumber(min: Int, max: Int) -> Int {
    let randomNum = Int(arc4random_uniform(UInt32(max) - UInt32(min)) + UInt32(min))
    return randomNum
}
