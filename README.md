# README
# 概要
テックキャンプの最終課題にて作成したアプリケーションを紹介します。また本資料では、自身で実装した箇所、および開発を通じて得られた経験についても紹介します。

# アプリケーション概要
フリーマーケットのアプリケーションを作成しました。
## 接続先情報
- URL http://18.178.152.156/
- ID: kengo
- Pass: s72ifea3
# テスト用アカウント等
## 購入者用
- メールアドレス: tadasi22@gmail.com
- パスワード: tadashi22
## 購入用カード情報
- 番号：4242424242424242
- 期限：12/20
- セキュリティコード：123
## 出品者用
- メールアドレス: kengo11@gmail.com 
- パスワード: kengo11

# 開発状況
## 開発環境
- Ruby/Ruby on Rails/MySQL/Github/AWS/Visual Studio Code
## 開発期間と平均作業時間
- 開発期間：2週間
- 1日あたりの平均作業時間：10時間
## 開発体制
- 人数：3人
- アジャイル型開発（スクラム）
- Trelloによるタスク管理

# 担当箇所一覧と確認方法
## 商品購入
![buy](https://user-images.githubusercontent.com/62418207/82053047-a5256000-96f7-11ea-8812-424a10832def.gif)
## ユーザー関連
![login](https://user-images.githubusercontent.com/62418207/82029010-51a01b80-96d1-11ea-9cea-f6960fe922d6.gif)
## マイページ
![my](https://user-images.githubusercontent.com/62418207/82067094-35b96b80-970b-11ea-8468-dd710a5a3914.gif)
# 各担当箇所の詳細
- payjpを使用しクレジットカードの登録、削除、商品購入
- ウィザード形式を使用しユーザーの個人情報の新規登録、削除、編集
- ユーザーマイページ関連

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|email|string|null: false| [](メールアドレス)
|phone_number|string|| [](電話番号)
|password|string|null: false| [](パスワード)
|birthday_year_id|integer|null: false|
|birthday_moon_id|integer|null: false|
|birthday_day_id|integer|null: false|
|self_introduce|text|-------| [](自己紹介文)

## Association
- has_many :items
- has_many :comments
- has_one :address
- has_one :card 
- has_many :sns_credentials
- belongs_to_active_hash :birth_year
- belongs_to_active_hash :birth_moom
- belongs_to_active_hash :birth_day     


## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer||
|name|text|null: false| [](商品名)
|content|string|null: false| [](商品の説明)
|brand|string|| [](ブランド)
|category|references|null: false, default: 0| [](カテゴリー)
|condition|references|null: false| [](商品の状態)
|size|references|null: false, default: 0| [](商品のサイズ)
|delivery_date|references|null: false, default: 0| [](配送日)
|delivery_fee|references|null: false, default: 0| [](配送料の負担)
|prefecture|references|null: false, default: 0| [](発送元の地域)
|delivery_way|references|null: false, default: 0| [](配送方法)
|price|integer|null: false| [](販売価格)
|buyer_id|integer|foreign_key: true|

### Association
- belongs_to :user
- has_many :category
- has_many :comments, dependent: :destroy
- has_many :images, dependent: :destroy
- accepts_nested_attributes_for :images, allow_destroy: true
- belongs_to_active_hash :condition, resence: true 
- belongs_to_active_hash :size, presence: true
- belongs_to_active_hash :delivery_date, presence: true
- belongs_to_active_hash :delivery_fee, presence: true
- belongs_to_active_hash :prefecture, presence: true
- belongs_to_active_hash :delivery_way, presence: true 


## Commentsテーブル(中間テーブル)
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|
|item|reference|null: false|
|user|reference|null: false|
|text|text|null: false|

### Association
- belongs_to :user
- belongs_to :item


## Cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|

## Association
- belongs_to :user


## Address
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|
|postal_code|string|null: false| [](郵便番号)
|prefecture_code|string|null: false| [](都道府県)
|city_name|string|null: false| [](市)
|street|string|null: false| [](番地、町)

## Association
- belongs_to :user


## categoryテーブル
|Column|Type|Options|
|------|----|-------|
|item|references|| 
|name|string|null: false| [](カテゴリー)

## Association
- has_many :items
- has_ancestry


## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|src|string|| 
|item_id|references|null: false|

## Association
- belongs_to :item
- mount_uploader :src, ImageUploader


## sns_credentialsテーブル
|Column|Type|Options|
|------|----|-------|
|provider|string||
|uid|string||
|user|references|foreign_key: true|
### Association
- belongs_to :user, optional: true, dependent: :destroy