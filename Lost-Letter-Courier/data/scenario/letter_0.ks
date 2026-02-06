;=====ここから多分デフォルト===========================================================================================================================================================
;シナリオ開始ラベル
*start
;===================================

;メッセージウィンドウのクリア
[cm]

;キー操作の初期設定をロード
[start_keyconfig]

;===============手順書ボタン操作====================
; 手帳ボタンを配置（常に表示）
[button fix="true" target="*show_manual" x="40" y="35" graphic="button/button_manual1.png" enterimg="button/button_manual2.png" auto_next=false  time="1000"  name="manual_btn"]
;====================================================


;背景画像を table.jpg に切り替え、フェード時間は 100ms
[bg storage="table.jpg" time="100"]
; CG開け
[cg storage="table.jpg"]

;暗転解除
[mask_off]

;=====ここまで多分デフォルト===========================================================================================================================================================

; スタックの掃除
[clearstack]

[cm]
#ヴロヒア
…ああ、これとかいいんじゃないですか？[p]
#

; 手紙の音
[playse storage="letters_SE.mp3" volume=100 stop=false]

;=====手紙を出す=======================================================================================================================================
[button name="letter0" target="*show_letter0" auto_next="false" x="493" y="113" graphic="letter/letter0_sub.png" enterimg="letter/letter0_sub2.png"]

;[anim]x2 [wa] フェードインアニメーション→その完了を待つ。
[anim name="manual" time=" 0" opacity=" 0"]
[anim name="manual" time="350" opacity="255"]
;wait animation。の意味で、アニメーションが完了するまで次の処理を待つ命令
[wa]

;背景画像を table.jpg に切り替え、フェード時間は 100ms
[bg storage="table_tegami.jpg" time=100]
; CG開け
[cg storage="table_tegami.jpg"]


; クリックでテキスト送りできなくする
[s]

;=========================================================================
;==============================*show_letter1==============================
;=========================================================================
*show_letter0

; いろいろとクリアして有効化
[cm]
[current entity=true]

#
差し出されたのは傘柄の綺麗な手紙だった。[l][r]
封筒に宛先や住所は書かれていないが、中にはちゃんと手紙が入っている。[p]

; 選択肢
[link target="*letter0_read"][mark color="0xff7f50" size=70]これを読む[endmark][endlink][r]
[s]


;===================
*letter0_read

[cm]
#
この手紙を読もう。[p]




;====真エンド条件================================================
; sf.letter_0_Flagを0に初期化
[eval exp="sf.letter_0_Flag = 0"]

; ED1,3，4，5，6を見た場合
[if exp="sf.ending1_wo_mita == 1 && sf.ending3_wo_mita == 1 && sf.ending4_wo_mita == 1 && sf.ending5_wo_mita == 1 && sf.ending6_wo_mita == 1"]
; sf.letter_0_Flagに1を入れる
[eval exp="sf.letter_0_Flag = 1"]
[endif]
;======真エンド条件を達成していない場合==============
; sf.letter_0_Flagが0のとき
[if exp="sf.letter_0_Flag == 0"]
; 画面をフェードアウトしてからletter_0_read.ksへ移動
[jump storage="letter_0_read.ks" time=100]
[endif]

;======真エンド条件を達成している場合==============
; sf.letter_0_Flagが1のとき
; 画面をフェードアウトしてから letter_0_ED にジャンプ
[if exp="sf.letter_0_Flag == 1"]
; letter_0_ED.ksへ移動
[jump storage="letter_0_ED.ks" time=100]
[endif]

;===========================================================================


;========================手順書表示ラベル===========================
; 手順書表示ラベル
*show_manual

; すべてのメッセージ操作入力が無効
[stop_keyconfig]
;====================================================
; 紙をめくる音
[playse storage="Book_SE.mp3" volume=40 stop=false]

; fix="true"より《固定ボタン》として画像を表示
[button fix="true" target="*Sub_Hide" graphic="manual.png" name="manual" auto_next="false" left="-4" top="-2"]


;[anim]x2 [wa] フェードインアニメーション→その完了を待つ。
[anim name="manual" time=" 0" opacity=" 0"]
[anim name="manual" time="350" opacity="255"]
;wait animation。の意味で、アニメーションが完了するまで次の処理を待つ命令
[wa]
;===============stamp====================
;test
[eval exp="console.log('ending1_wo_mita:', sf.ending1_wo_mita)"]
[eval exp="console.log('ending2_wo_mita:', sf.ending2_wo_mita)"]
[eval exp="console.log('ending3_wo_mita:', sf.ending3_wo_mita)"]
[eval exp="console.log('ending4_wo_mita:', sf.ending4_wo_mita)"]
[eval exp="console.log('ending5_wo_mita:', sf.ending5_wo_mita)"]
[eval exp="console.log('ending6_wo_mita:', sf.ending6_wo_mita)"]
[eval exp="console.log('ending7_wo_mita:', sf.ending7_wo_mita)"]

;ending1
[if exp="sf.ending1_wo_mita == 1"]
[button fix="true" target="*Sub_Hide" graphic="stamp_1.png" name="stamp_1" auto_next="false" x="676" y="261"]
[endif]

;ending2
[if exp="sf.ending2_wo_mita == 1"]
[button fix="true" target="*Sub_Hide" graphic="stamp_2.png" name="stamp_2" auto_next="false" x="204" y="609"]
[endif]

;ending3
[if exp="sf.ending3_wo_mita == 1"]
[button fix="true" target="*Sub_Hide" graphic="stamp_3.png" name="stamp_3" auto_next="false" x="960" y="480"]
[endif]

;ending4
[if exp="sf.ending4_wo_mita == 1"]
[button fix="true" target="*Sub_Hide" graphic="stamp_4.png" name="stamp_4" auto_next="false" x="660" y="59"]
[endif]

;ending5
[if exp="sf.ending5_wo_mita == 1"]
[button fix="true" target="*Sub_Hide" graphic="stamp_5.png" name="stamp_5" auto_next="false" x="952" y="20"]
[endif]

;ending6
[if exp="sf.ending6_wo_mita == 1"]
[button fix="true" target="*Sub_Hide" graphic="stamp_6.png" name="stamp_6" auto_next="false" x="730" y="434"]
[endif]

;ending7
[if exp="sf.ending7_wo_mita == 1"]
[button fix="true" target="*Sub_Hide" graphic="stamp_7.png" name="stamp_7" auto_next="false" x="320" y="564"]
[endif]

;ending0
[if exp="sf.letter_0_Flag == 1"]
[button fix="true" target="*Sub_Hide" graphic="stamp_0.png" name="stamp_0" auto_next="false" x="985" y="192"]
[endif]

;====================================================


[return]
;============================================================================

;============================================================================
; 手順書を消すラベル
*Sub_Hide

; manual。という名前の固定ボタンを解放。画面から削除されます。
[clearfix name="manual"]
; 350msかけて透明にしてフェードアウト。
; [anim][wa] フェードアウトアニメーション→その完了を待つ。
[anim name="manual" time="350" opacity="0"]
; フェードアウトが終わるまで待機。
[wa]

;stamp画像を削除
[clearfix name="stamp_0"]
[clearfix name="stamp_1"]
[clearfix name="stamp_2"]
[clearfix name="stamp_3"]
[clearfix name="stamp_4"]
[clearfix name="stamp_5"]
[clearfix name="stamp_6"]
[clearfix name="stamp_7"]


[start_keyconfig]

[return]
;============================================================================



[s]


