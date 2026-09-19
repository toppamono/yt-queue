# YT Queue 端末間同期

YT Queue は Supabase Auth + Row Level Security (RLS) を使い、同じメールアドレスでログインした端末間で再生リストと再生位置を共有します。

## 初回セットアップ

1. Supabase で無料プロジェクトを1つ作成。
2. Dashboard の **SQL Editor** を開き、リポジトリの `supabase_setup.sql` を貼り付けて **Run**。
3. **Connect** パネルから次の2つを控える。
   - Project URL
   - Publishable key（`sb_publishable_...`）
4. **Authentication > Providers > Email** で Email を有効にする。メール確認なしで使う場合は **Confirm email をOFF** にする。
5. YT Queue をデスクトップPCで開き、**同期** → Project URL / Publishable key を入力 → **接続設定を保存**。
6. 同じ画面でメールアドレスと6文字以上のパスワードを入力し、最初の1台だけ **新規登録**。以後は **ログイン** を使う。
7. 「同期済」と表示されたら接続成功。初回同期は既存のローカル再生リストを無視し、空のクラウドリストから開始する。

## 2台目・3台目

ノートPCとAndroidでも同じYT Queueを開き、**同期**から同じ Project URL / Publishable key を登録し、同じメールアドレス＋パスワードで **ログイン** する。

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
- パスワードはYT QueueのlocalStorageには保存しない。Supabase Authのセッションだけをブラウザが保持する。
- Secret key / service_role key は絶対に入力しない。
- RLS により、ログインした本人の行だけ読み書きできます。
