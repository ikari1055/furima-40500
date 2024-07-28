## users

|Column            |Type    |Options      |
|------------------|--------|-------------|
| nickname         | string | null: false |
| email            | string | null: false, unique: true |
| encrypted_password | string | null: false |
| introduction     | text   |
| last_name        | string | null: false |
| first_name       | string | null: false |
| last_name_kana   | string | null: false |
| first_name_kana  | string | null: false |
| birthday         | date   | null: false |

### Association
- has_many :items, dependent: :destroy
- has_one :destination, dependent: :destroy
- has_one :card, dependent: :destroy



## destination

|Column            |Type     |Options      |
|------------------|---------|-------------|
| user_id          | integer | null: false, foreign_key: true |
| last_name        | string  | null: false |
| first_name       | string  | null: false |
| last_name_kana   | string  | null: false |
| first_name_kana  | string  | null: false |
| post_code        | string  | null: false |
| prefecture_id    | integer | null: false |
| city             | string  | null: false |
| address          | string  | null: false |
| building_name    | string  |
| phone_number     | string  |

### Association
- belongs_to :user



## card

|Column       |Type     |Options     |
|-------------|---------|------------|
| user_id     | integer | null: false, foreign_key: true |
| customer_id | string  | null: false |
| card_id     | string  | null: false |

### Association
- belongs_to :user



## category

|Column    |Type    |Options     |
|----------|--------|------------|
| name     | string | null: false |
| ancestry | string |

### Association
- has_many :items
※ancestryは、gem ancestryを使用するため。



## item

|Column         |Type     |Options     |
|---------------|---------|------------|
| name          | string  | null: false |
| price         | integer | null: false |
| description   | text    | null: false |
| condition_id  | integer | null: false |
| shipping_cost_id | integer | null: false |
| shipping_days_id | integer | null: false |
| prefecture_id | integer | null: false |
| category_id   | integer | null: false, foreign_key: true |
| user_id       | integer | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :category
- has_many :images, dependent: :destroy
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :condition
- belongs_to_active_hash :shipping_cost
- belongs_to_active_hash :shipping_days



## image

|Column    |Type     |Options     |
|----------|---------|------------|
| url      | string  | null: false |
| item_id  | integer | null: false, foreign_key: true |

### Association
- belongs_to :item
