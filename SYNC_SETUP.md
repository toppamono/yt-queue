# YT Queue 端末間同期

YT Queue は Supabase Auth + Row Level Security (RLS) を使い、同じメールアドレスでログインした端末間で再生リストと再生位置を共有します。

## 初回セットアップ

1. Supabase で無料プロジェクトを1つ作成。
2. Dashboard の **SQL Editor** を開き、リポジトリの `supabase_setup.sql` を貼り付けて **Run**。
3. **Connect** パネルから次の2つを控える。
   - Project URL
   - Publishable key（`sb_publishable_...`）
4. **Authentication > URL Configuration** で以下を設定。
   - Site URL: `https://tsujinomix.github.io/yt-queue/`
   - Redirect URLs: `https://tsujinomix.github.io/yt-queue/`
5. YT Queue をデスクトップPCで開き、**同期** → Project URL / Publishable key を入力 → **接続設定を保存**。
6. 同じ画面でメールアドレスを入力し、**ログインメールを送信**。届いたMagic Linkを開く。
7. 「同期済」と表示されたら、そのPCの現在のリストがクラウドへ保存される。

## 2台目・3台目

ノートPCとAndroidでも同じYT Queueを開き、**同期**から同じ Project URL / Publishable key を登録し、同じメールアドレスでログインする。

クラウドに既存リストがあれば自動で読み込みます。

## 同期対象

- 再生リスト
- 並び順
- 動画タイトル
- 現在選択中の動画
- 各動画の再生位置
- 視聴済み状態
- 再生速度

通常は変更後数秒でクラウド保存し、別端末も数秒間隔で確認します。

## セキュリティ

- 使用するのは Publishable key のみ。
- Secret key / service_role key は絶対に入力しない。
- RLS により、ログインした本人の行だけ読み書きできます。
