# PaLo

**PaLo**は，ユーザーの1日の移動履歴をバックグラウンドで記録し，可視化するiOSアプリケーションです．
SwiftUIとFirebaseを活用して開発しました．

## 概要 (Overview)
「いつ，どこにいたか」を自動でライフログとして残すことを目的に開発しました．

アプリを閉じている間も位置情報を追跡し，独自のパスとして地図上に描画します．

## 主な機能 (Features)
* **バックグラウンド位置情報追跡**: Core Locationを使用し，アプリがバックグラウンドにある状態でも位置情報を定期的に取得・記録します．
* **移動経路の可視化**: 取得した座標データを地図上（MapKit/Google Maps）にピンやラインとして描画します．
* **データクラウド保存**: 位置情報はFirebase（Firestore）にリアルタイムで同期され，機種変更時などもデータを保持します．
* **UI/UX**: SwiftUIを用いたモダンで直感的なインターフェース．

## 使用技術 (Tech Stack)
* **言語**: Swift
* **フレームワーク**: SwiftUI
* **バックエンド**: Firebase (Authentication, Firestore)
* **ライブラリ/ツール**:
    * Core Location (位置情報)
    * MapKit (地図表示)
    * SPM (Swift Package Manager)

## 技術的なこだわり・工夫点
* **バッテリー消費への配慮**: バックグラウンドでの常時取得によるバッテリー消費を抑えるため，取得頻度や精度（Accuracy）の調整を行いました．
* **MVVMアーキテクチャ**: ViewとLogicを分離し，保守性の高いコード設計を意識しました．

## 環境構築 (Installation)

このプロジェクトをローカルで実行するには，以下の手順が必要です．

1. リポジトリをクローンする
   ```bash
   git clone [https://github.com/your-username/PaLo.git](https://github.com/your-username/PaLo.git)
