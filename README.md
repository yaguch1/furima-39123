# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| password           | string | null: false               |
| encrypted_password | string | null: false               |
| kanji_sei          | string | null: false               |
| kanji_mei          | string | null: false               |
| kana_sei           | string | null: false               |
| kana_mei           | string | null: false               |
| birth_year         | string | null: false               |
| birth_month        | string | null: false               |
| birth_day          | string | null: false               |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| item_name       | string     | null: false                    |
| explanation     | text       | null: false                    |
| category        | string     | null: false                    |
| condition       | string     | null: false                    |
| shippng_charges | string     | null: false                    |
| region          | string     | null: false                    |
| days_of_ship    | string     | null: false                    |
| price           | string     | null: false                    |
| user_id         | references | null: false, foreign_key: true |


### Association

- belongs_to :user
- has_one :purchase

## purchases テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| post_code        | string     | null: false                    |
| city             | string     | null: false                    |
| address          | text       | null: false                    |
| building         | text       |                                |
| telephone_number | string     | null: false                    |
| user_id          | references | null: false, foreign_key: true |
| item_id          | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user