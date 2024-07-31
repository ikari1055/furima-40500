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
- has_many :order_histories, dependent: :destroy
- has_many :items, dependent: :destroy


## destinations

|Column            |Type     |Options      |
|------------------|---------|-------------|
| post_code        | string  | null: false |
| prefecture_id    | integer | null: false |
| city             | string  | null: false |
| address          | string  | null: false |
| building_name    | string  |
| phone_number     | string  | null: false |

### Association
- belongs_to : order_histories

## items

|Column         |Type     |Options     |
|---------------|---------|------------|
| name          | string  | null: false |
| price         | integer | null: false |
| description   | text    | null: false |
| condition_id  | integer | null: false |
| shipping_cost_id | integer | null: false |
| shipping_days_id | integer | null: false |
| prefecture_id | integer | null: false |
| category_id   | integer | null: false |
| user_id       |references  |null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to_active_hash :category
- has_one :order_histories, dependent: :destroy
- belongs_to_active_hash :prefecture


## comments

|Column   |	Type	    |Options               |
|---------|-----------|----------------------|
| user_id | integer    | null: false, foreign_key: true |
| item_id | integer    | null: false, foreign_key: true |
| text    | text       | null: false           |

### Association
- belongs_to :user
- belongs_to :item


## order_histories

|Column   |	Type	    |Options               |
|---------|-----------|----------------------|
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one : destinations