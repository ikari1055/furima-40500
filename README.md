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
- has_many :order_histories
- has_many :items


## addresses

|Column            |Type     |Options      |
|------------------|---------|-------------|
| post_code        | string  | null: false |
| prefecture_id    | integer | null: false |
| city             | string  | null: false |
| address          | string  | null: false |
| building_name    | string  |
| phone_number     | string  | null: false |
| order_history    |references  |null: false, foreign_key: true |


### Association
- belongs_to : order_history

## items

|Column         |Type     |Options     |
|---------------|---------|------------|
| name          | string  | null: false |
| price         | integer | null: false |
| description   | text    | null: false |
| condition_id  | integer | null: false |
| shipping_cost_id | integer | null: false |
| shipping_day_id | integer | null: false |
| prefecture_id | integer | null: false |
| category_id   | integer | null: false |
| user          |references  |null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order_history


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
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one : address