# SwiftUI_MegaBankCurrencyExchangeRate
---
#### A Real-Time Currency Exchange Rate base on MegaBank(兆豐銀行)'s API
---
### Screen Shots
<img src="https://github.com/kr1s0404/SwiftUI_MegaBankCurrencyExchangeRate/blob/main/screenshot/1.png" width="223" height="447">

---

### Table of Contents

- [Description](#description)
- [How To Use](#how-to-use)
- [Author Info](#author-info)

---

## Description

- A simple SwiftUI APP to demonstrate how I implent MegaBank Post API and show all the data on iPhone in real-time 

- Unlike the get API, the MegaBank API has to be POST which is another usage in SwiftUI

- The country flag part was take the currency name and remove the last letter "D" to show country flag. For instance, currency name is "USD", the country flag would be "US", so I used removeLast() founction in the code

- Project was completed using 100% SwiftUI (No Storyboard)

- I use a libary called "SwiftyJson" to get a better result on retrieve post API data

- Design pattern: MVVM(Model-ViewModel-View)

#### Frameworks

- SwiftUI
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)

---

### What I Learned:
- I learned how to call a POST API in SwiftUI
- Show the country flag without using Apple's emoji
- Better understandsing on JSON file
- A new Swift feature, "refreshable" to implent pull to refresh fucntion

---

## How To Use

- Clone the project and run it on Xcode
- The API is from MegaBank(https://www.megabank.com.tw/api/sc/RateExchange/Get_Fx_Currency)
- I will suggest you to use "PostMan" to see what is the JSON data look from the API 

---

## Author Info

- Instagram - [@_kr1s.4](https://www.instagram.com/_kr1s.4/)
- Website - [Github: kr1s0404](https://github.com/kr1s0404)

[Back To The Top](#SwiftUI-HapticDemo)
