## users

|Column            |Type    |Options      |
|------------------|--------|-------------|
| nickname         | string | null: false |
| email            | string | null: false, unique: true |
| user_password    | string | null: false |
| introduction     | text   |
| last_name        | string | null: false |
| first_name       | string | null: false |
| last_name_kana   | string | null: false |
| first_name_kana  | string | null: false |
| birthday         | date   | null: false |

### Association
- has_many :products dependent: :destroy
- belongs_to :destination dependent: :destroy
- belongs_to :card dependent: :destroy



## destination

|Column            |Type     |Options      |
|------------------|---------|-------------|
| user_id          | integer | null: false, foreign_key:true |
| last_name        | string  | null: false |
| first_name       | string  | null: false |
| last_name_kana   | string  | null: false |
| first_name_kana  | string  | null: false |
| post_code        | string  | null: false |
| prefecture       | string  | null: false |
| city             | string  | null: false |
| address          | string  | null: false | 
| building_name    | string 
| phone_number     | string 

### Association
- belongs_to :user



## card

|Column       |Type     |Options     |
|-------------|---------|------------|
| user_id     | integer | null:false,foreign_key:true |
| customer_id | string  | null:false |
| card_id     | string  | null:false |

### Association
- belongs_to :user



## category

|Column    |Type    |Options     |
|----------|--------|------------|
| name     | string | null:false |
| ancestry | string |


### Association
- has_many :products
※ancestryは、gem ancestryを使用するため。



## item

|Column         |Type     |Options     |
|---------------|---------|------------|
| name          | string  | null:false |
| price         | string  | null:false |
| description   | string  | null:false |
| condition     | string  | null:false |
| cost          | string  | null:false |
| days          | string  | null:false |
| prefecture_id | string  | null:false |
| category_id   | integer | null:false,foreign_key:true |
| user_id       | integer | null:false,foreign_key:true |


### Association
- belongs_to :user dependent: :destroy
- belongs_to :category dependent: :destroy
- belongs_to :brand dependent: :destroy
- has_many :images dependent: :destroy
- belongs_to_active_hash :prefecture



## image

|Column      |Type     |Options     |
|------------|---------|------------|
| image      | string  | null:false |
| product_id | integer | null:false,foreign_key:true |

### Association
- belongs_to :product



## Tabel名

|Column|Type|Options|
|------|----|-------|
（ここに追記していく）


### Association
（ここに追記していく）