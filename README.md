https://github.com/user-attachments/assets/bfdc5271-efe1-4606-8297-bf3bd29cea07

# LearnConnect

LearnConnect, çeşitli kurslar sunan ve kullanıcıların kurs videolarını izleyerek öğrenme süreçlerini takip etmelerini sağlayan bir mobil uygulamadır. Uygulama, kullanıcıların videoların ilerlemesini kaydetmelerini, izledikleri yerden devam etmelerini sağlar ve video izleme sırasında kullanıcılara daha iyi bir deneyim sunar. Ayrıca, kullanıcıların karanlık mod gibi tercihlerini kaydedebilir ve yönetebilir.

Bu uygulama, UIKit kullanılarak geliştirilmiş daha moder bir arayüz için bazı ekranlar SWIFTUI kullanılarak yapılmıştır. Ayrıca, güçlü **Firebase Auth** ve **Firestore** altyapısı ile kullanıcı yönetimi ve veri depolama işlemleri gerçekleştirilir.

Kurs içerisindeki videolar dammy videolardır. Gerçek kurs videoları çok kolay bir şekilde eklenebiliir.
---

## Özellikler

- **Kurslar ve Videolar**: Farklı kategorilerde kurslar sunulur. Her kursun içerisinde videolar yer alır ve kullanıcılar, her videoyu izlerken izleme ilerlemelerini takip edebilirler.
- **İlerleme Kaydetme**: Kullanıcılar, izledikleri videoların ilerlemelerini kaydeder ve kaldıkları yerden devam edebilirler. Bu özellik, videoların izlenme sürelerini kaydederek kullanıcı deneyimini artırır.
- **Karanlık Mod**: Uygulama, kullanıcıların tercihlerine göre karanlık mod desteği sunar. Karanlık mod, cihazda yapılan tercihlere göre otomatik olarak aktifleştirilir ve her kullanıcı tercihi kaydedilir.
- **Kullanıcı Hesapları**: Firebase Auth kullanılarak kullanıcılar, e-posta ve şifre ile giriş yapabilirler. Uygulama, kullanıcılara kişisel hesap bilgileri ve video izleme ilerlemelerini kaydedebileceği bir alan sunar.
- **Modern Tasarım**: SwiftUI ile geliştirilmiş modern ekranlara sahiptir. SwiftUI sayesinde dinamik ve duyarlı bir kullanıcı deneyimi sağlanır.

## Bonus Özellikler
- Video Hız Kontrolü
- Filtreleme
- Favorilere Ekleme

---

## Kullanılan Teknolojiler

- **UIKit**: Uygulamanın büyük bir kısmı, UIKit kullanılarak geliştirilmiştir. UIKit, iOS uygulamaları için güçlü ve esnek bir çerçeve olup, geleneksel ve kapsamlı bir kullanıcı arayüzü geliştirme deneyimi sunar.
- **SwiftUI**: Uygulamanın bazı ekranları, modern ve duyarlı bir arayüz oluşturmak amacıyla **SwiftUI** ile geliştirilmiştir. SwiftUI sayesinde kullanıcı deneyimi, her cihazda tutarlı ve şık bir şekilde sağlanır. SwiftUI, özellikle daha modern görünümlü ekranlar için tercih edilmiştir.
- **Firebase**: Kullanıcı yönetimi ve veri depolama işlemleri için **Firebase** kullanılır. Firebase Auth ile kullanıcı girişi yapılır, **Firestore** ise video izleme ilerlemeleri ve kullanıcı verileri için kullanılır.
- **AVKit**: Video oynatıcı işlevselliği için **AVKit** kullanılır. Bu sayede videolar sorunsuz bir şekilde oynatılır ve kullanıcılar kaldıkları yerden devam edebilirler.
- **UserDefaults**: Kullanıcı tercihlerinin (karanlık mod gibi) depolanması için kullanılır. Bu, uygulamanın kişiselleştirilmesini sağlar.

---

### Gereksinimler

- iOS 16.0 ve sonrası
- Xcode 14.0 ve sonrası
- Firebase projesi için aktif bir hesap ve yapılandırma


### Klonlama
- git clone https://github.com/EbuzerSimsek/LearnConnect
- cd LearnConnect


