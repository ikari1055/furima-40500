## users

|Column            |Type    |Options      |
|------------------|--------|-------------|
| nickname         | string | null: false |
| email            | string | null: false, unique: true |
| encrypted_password | string | null: false |
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
| post_code        | string  | null: false |
| prefecture_id    | integer | null: false |
| city             | string  | null: false |
| address          | string  | null: false |
| building_name    | string  |
| phone_number     | string  |

### Association
- belongs_to :user


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
| user          | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :category
- has_many :images, dependent: :destroy
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :condition
- belongs_to_active_hash :shipping_cost
- belongs_to_active_hash :shipping_days

## comments
|Column   |	Type	    |Options               |
|user_id	|references	|null: false, FK: true |
|item_id	|references	|null: false, FK: true |
|text	    |text	      |null: false           |

