## アプリケーションの概要
Solidusを用いたECサイト。

## 実装内容
- 商品詳細ページ（例：https://ec-potepan-kk.herokuapp.com/potepan/products/3）
- カテゴリー別アーカイブページ（例：https://ec-potepan-kk.herokuapp.com/potepan/categories/7）
- トップページ（https://ec-potepan-kk.herokuapp.com/potepan）

## 技術的ポイント
- Dockerを用いたRails開発環境構築
- Rails製OSSのSolidusのキャッチアップ
- AWS S3への画像保存
- RSpecでテスト記述
- Ajaxを用いた非同期処理（セレクトボックスの項目に応じた画像の切り替え）
- Fat Controllerを避けるため、一部ロジックをモデルで定義
- Bootstrapによるレスポンシブ対応
- Rubocopを使用したコード規約に沿った開発
- 提出したプルリクエストに現役Webエンジニア3人以上からレビューを受けて修正し、マージ承認をもらってからマージするという流れで開発

## アプリケーションの機能
### 商品詳細ページ
- 商品詳細の表示
- 関連商品出力

### カテゴリー別アーカイブページ
- カテゴリーごとの商品一覧表示
- 商品カテゴリーツリーの動的表示

### 検索
- Web APIを使用した予測変換の表示

## 環境
■フレームワーク
　Ruby on Rails
■インフラ
　heroku, Docker
■データベース
　MySQL