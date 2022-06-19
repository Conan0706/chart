フォルダ構造
・/config : 
データベースに関する情報記載
    /database.yml - データベース名などの情報を記載

・/db : 
現在のテーブル情報を記載
    /migrate - テーブルの作成・変更を行う際に作成したファイルを格納
    /schema.rb - 現在のテーブルの情報を一覧化

・/public : 
プロジェクト内で共有して使用するファイルを格納
    ・/css - cssファイルを格納
        /modaal.min.js - モーダル情報を記載 (引用：https://shu-naka-blog.com/website/modaal-js/)
    ・/js - JavaScriptファイルを格納
        /modaal.min.js - モーダル情報を記載 (引用：https://shu-naka-blog.com/website/modaal-js/)

・/views :
実際に表示される画面を書いているファイルを格納、erbファイル
    /home.erb - チャート表示画面
    /index.erb - 最初に表示される画面、ログイン画面
    /sign_up.erb - 新規登録画面

/app.rb - Rubyコードを記載


