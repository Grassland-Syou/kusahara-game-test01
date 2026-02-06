;シナリオ開始ラベル
*start
;====================================
; エンドロール開始
;====================================
*endroll_start
; メッセージウィンドウを消す
[layopt layer="message0" visible=false]
[hidemenubutton]
;キャラクター非表示
#
[chara_hide name="Vrochia"]

; ===================================縁どり画像表示===================================

;レイヤを表示
[layopt layer=1 visible=true page=fore]
;縁取り画像を表示
[image layer=1 storage="waku.png" x=0 y=0 zindex=50]

; =====================================================================================


[stop_keyconfig]
; クリック無効
[cm]
;BGMを変更
[xchgbgm storage="EndBGM.mp3" loop=true volume=10 time=2000]
;背景をendroll
[bg storage="endroll.jpg"]

; 白文字
[font color=white size=24]

;レイヤ0を表示状態に
[layopt layer=0 visible=true]


;演出テキストを表示
;レイヤ1に追加
[image layer=0 x=0 y=0 storage="last/last1.png" time=500]
[mtext text="企画・シナリオ・プログラム・イラスト/草原 翔" x=100 y=100 size=50 color=white in_effect="fadeIn" out_effect="fadeOut"]
;画像を削除
[freeimage layer=0  time=500]


;レイヤ1に追加
[image layer=0 x=0 y=0 storage="last/last2.png" time=500]
[mtext text="Music/DOVA-SYNDROME" x=100 y=100 size=50 color="#40e0d0" in_effect="fadeIn" out_effect="fadeOut"]
[mtext text="夏の面影/蒲鉾さちこ" x=100 y=100 size=50 color=white in_effect="fadeIn" out_effect="fadeOut"]
[mtext text="Gentle warmth/ゆうり(from Yuli Audio Craft)" x=100 y=100 size=50 color=white in_effect="fadeIn" out_effect="fadeOut"]
[mtext text="夏の氷華(Summer ice flower)/蒲鉾さちこ" x=100 y=100 size=50 color=white in_effect="fadeIn" out_effect="fadeOut"]
[mtext text="Endless Cord/チョコミント" x=100 y=100 size=50 color=white in_effect="fadeIn" out_effect="fadeOut"]
[mtext text="雨の花/shimtone" x=100 y=100 size=50 color=white in_effect="fadeIn" out_effect="fadeOut"]

;画像を削除
[freeimage layer=0  time=500]

;レイヤ1に追加
[image layer=0 x=0 y=0 storage="last/last3.png" time=500]
[mtext text="SE" x=100 y=100 size=50 color="#40e0d0" in_effect="fadeIn" out_effect="fadeOut"]
[mtext text="OtoLogic" x=100 y=100 size=50 color=white in_effect="fadeIn" out_effect="fadeOut"]
[mtext text="DOVA-SYNDROME" x=100 y=100 size=50 color=white in_effect="fadeIn" out_effect="fadeOut"]
[mtext text="効果音ラボ" x=100 y=100 size=50 color=white in_effect="fadeIn" out_effect="fadeOut"]
[mtext text="On-Jin ～音人～" x=100 y=100 size=50 color=white in_effect="fadeIn" out_effect="fadeOut"]
;画像を削除
[freeimage layer=0  time=500]

;レイヤ1に追加
[image layer=0 x=0 y=0 storage="last/last4.png" time=500]
[mtext text="Font" x=100 y=100 size=50 color="#40e0d0" in_effect="fadeIn" out_effect="fadeOut"]
[mtext text="晩秋レトロミン" x=100 y=100 size=50 color=white in_effect="fadeIn" out_effect="fadeOut"]
[mtext text="刻ゴシック" x=100 y=100 size=50 color=white in_effect="fadeIn" out_effect="fadeOut"]
[mtext text="適当ポエム" x=100 y=100 size=50 color=white in_effect="fadeIn" out_effect="fadeOut"]
[mtext text="しょかきさらり" x=100 y=100 size=50 color=white in_effect="fadeIn" out_effect="fadeOut"]
[mtext text="フラフィーまんまるゴシック" x=100 y=100 size=50 color=white in_effect="fadeIn" out_effect="fadeOut"]
[mtext text="851マカポップ" x=100 y=100 size=50 color=white in_effect="fadeIn" out_effect="fadeOut"]
;画像を削除
[freeimage layer=0  time=500]

;レイヤ1に追加
[image layer=0 x=0 y=0 storage="last/last5.png" time=500]
[mtext text="Illustration" x=100 y=100 size=50 color="#40e0d0" in_effect="fadeIn" out_effect="fadeOut"]
[mtext text="SOZAI GOOD" x=100 y=100 size=50 color=white in_effect="fadeIn" out_effect="fadeOut"]
[mtext text="フリーペンシル" x=100 y=100 size=50 color=white in_effect="fadeIn" out_effect="fadeOut"]
[mtext text="CLIP STUDIO PAINT素材" x=100 y=100 size=50 color=white in_effect="fadeIn" out_effect="fadeOut"]
;画像を削除
[freeimage layer=0  time=500]

;レイヤ1に追加
[image layer=0 x=0 y=0 storage="last/last6.png" time=500]
[mtext text="Game Engine/TyranoScript" x=100 y=100 size=50 color="#40e0d0" in_effect="fadeIn" out_effect="fadeOut"]
;画像を削除
[freeimage layer=0  time=500]

;レイヤ1に追加
[image layer=0 x=0 y=0 storage="last/last7.png" time=500]
[mtext text="Special Thanks/テストプレイヤーの皆さま" x=100 y=100 size=50 color=white in_effect="fadeIn" out_effect="fadeOut"]
;画像を削除
[freeimage layer=0  time=500]

;レイヤ1に追加
[image layer=0 x=0 y=0 storage="last/last8.png" time=500]
[mtext text="© 2025-2026 草原翔" x=100 y=100 size=50 color=white in_effect="fadeIn" out_effect="fadeOut"]
;画像を削除
[freeimage layer=0  time=500]

;レイヤ1に追加
[image layer=0 x=0 y=0 storage="last/last9.png" time=500]
[mtext text="ここまで遊んでくださって、ありがとうございました。" x=100 y=100 size=50 color="#40e0d0" in_effect="fadeIn" out_effect="fadeOut"]

[freeimage layer=0 time=500]


; BGMのフェードアウト
[fadeoutbgm time=2000]

; クリック有効に戻す
[cm]


; 背景をカードへ変更
[bg storage="Vrochia.jpg" time=2000]
; CG開け
[cg storage="Vrochia.jpg"]

[p]

;==============================
; タイトルへ戻る
;==============================
@jump storage="title.ks"
[s]
