# Chocobook

## サイト概要
チョコレートスイーツのレシピサイト

### サイトテーマ
チョコレートの歴史や栄養を学びながら<br>
様々なチョコレートスイーツレシピを紹介するサイト。<br>
レシピの閲覧は会員登録不要で可能ですが、<br>
自分が作ったチョコレートスイーツの<br>
レシピを投稿するには会員登録が必要です。

### テーマを選んだ理由
世界中、多くの国々で人々から愛され、子供から大人までみんなが大好きなチョコレート。<br>
実はその歴史は深く、元々は飲み物として食されていました。<br>
また、チョコレートの原料であるカカオ豆には抗酸化作用として<br>
ポリフェノールが豊富に含まれています。

世界中には様々なチョコレートスイーツが存在します。<br>
本サイトではチョコレートに関する歴史や栄養といった知識を交え、<br>
様々なチョコレートスイーツレシピを紹介し、<br>
チョコレートの魅力を多くの方に伝わればいいなと思い、<br>
このテーマにしました。

### ターゲットユーザ
- チョコレートが好きな方
- 甘いものが好きな方
- 料理、お菓子作りが好きな方

### 主な利用シーン
- チョコレートに興味がある
- チョコレートスイーツを作るとき
- チョコレートレシピを検索する時、また自分が作ったチョコレートレシピを投稿する時

## 実装機能リスト
https://docs.google.com/spreadsheets/d/19YhdSgJyfXNRdhzw2skeaBo5lZrJRiKnih9b0EeQAfs/edit?usp=sharing

## 設計書
- ●ER図:https://drive.google.com/file/d/13kVQ-WDM7FlkcDHIKGhWIY9djNezkTvf/view?usp=sharing
- ●ワイヤーフレーム
- 会員側:https://drive.google.com/file/d/10s3_TEb9cQiUv7jKT0-R6pilPDrY1GRT/view?usp=sharing
- 管理側:https://drive.google.com/file/d/12Eevk7HGhEVVw78iqC-ESh0T6vnYm2gS/view?usp=sharing
- ●テーブル定義書:https://docs.google.com/spreadsheets/d/1KvDmRBbLGMmldZCAfC9FIPV0ec3RYPT1wpjFuTz_AFU/edit?usp=sharing
- ●詳細設計:https://docs.google.com/spreadsheets/d/13Q9GRcC0KOgpWawwW1uIqFyubpJuKydwvSUaB6bK7Tk/edit?usp=sharing

## Gem

### ログイン機能
gem 'devise'

### レイアウト
gem 'bootsnap', '>= 1.4.4'
gem 'jquery-rails'

### 動的フォーム実装機能
gem 'cocoon'
gem 'jquery-rails'

### ページネーション機能
gem 'kaminari','~> 1.2.1'

### バリデーション日本語化
gem 'rails-i18n'

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

