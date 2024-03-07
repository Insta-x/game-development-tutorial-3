# Requirements
Godot Version: 4.2.1

# Tutorial 3
## Features
Mengikuti tutorial, pada project ini terdapat fitur basic seperti menggerakkan karakter player secara horizontal dan vertikal. Pergerakan horizontal dengan berjalan, sedangkan vertikal dengan melompat dan jatuh. Jenis node yang digunakan adalah `CharacterBody2D` agar memberikan kontrol penuh kepada developer untuk membuat pergerakan yang lebih sesuai dan bisa melakukan tuning agak feel game lebih enak.

Karena terdapat beberapa states yang akan digunakan pada project ini, saya menggunakan bantuan *addons* `Godot State Charts` yang merupakan salah satu jenis implementasi *State Machines* namun dengan sedikit modifikasi agar lebih fleksibel.

Beberapa fitur yang ditambahkan mengikuti latihan mandiri adalah:
- *Double Jump* sesuai deskripsinya memberikan kemampuan kepada player untuk melompat sekali lagi setelah melompat sekali. Implementasi hanya dengan bantuan variable tracker untuk memberitahu apakah masih bisa melompat lagi.
- *Dashing* memberikan kemampuan kepada player untuk bergerak secara cepat setelah *double tapping* ke salah satu arah horizontal. Implementasi dibantu dengan membuat *code* khusus untuk mengecek input *double tapping* dari player. Selain itu, karena perilaku player berubah ketika *dashing*, maka ini merupakan *state* sendiri yang berbeda dari *state* biasa.
- *Crouching* memberikan kemampuan kepada player untuk menunduk sehingga *collision* lebih kecil dan bisa melewati tempat yang lebih sempit dengan kecepatan gerak yang lebih lambat. Implementasi dengan membuat *state* baru khusus untuk *crouching* dan membuat `CollisionShape2D` yang baru khusus untuk *crouching* yang dinyalakan ketika sedang berada di *state crouching*.

Fitur tambahan terakhir adalah menambahkan animations untuk player agar terlihat lebih menarik. Implementasi menggunakan `AnimationPlayer` dan kemudian memanggil `play()` menggunakan *code*. Animation yang dimasukkan adalah:
- `idle`, ketika player tidak bergerak.
- `walking`, ketika player berjalan.
- `jumping`, ketika player melompat.
- `falling`, ketika player jatuh.
- `dashing`, ketika player *dashing*.
- `crouching`, ketika player sedang *crouching*.

# Tutorial 5
Animation player sudah menggunakan spritesheet yang dianimasikan dengan `AnimationPlayer` karena lebih flexible.

Untuk objek baru, dibuat dino dengan spritesheet yang dianimasikan dengan `AnimatedSprite`. Dino akan mengeluarkan suara marah jika disentuh oleh player.

Player juga mendapatkan audio baru ketika dia meloncat. Audio dibuat dengan rekaman tepuk tangan pada Audacity. Digunakan node `AudioStreamPlayer2D` untuk memainkan audionya.

BGM ditaruh pada main scene dengan menggunakan node `AudioStreamPlayer` agar bisa terdengar di mana saja.

# Credits
- Dino Spritesheets: https://arks.itch.io/dino-characters by [@ScissorMarks](https://twitter.com/ScissorMarks)
- Anger Audio : https://freesound.org/people/MATRIXXX_/sounds/527636/