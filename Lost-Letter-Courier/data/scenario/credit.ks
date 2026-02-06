;シナリオ開始ラベル
*start
;====================================
; credit開始
;====================================

;メッセージウィンドウのクリア
[cm]
;レイヤの表示をクリア
[clearfix]
[freeimage layer=1]
;キー操作の初期設定をロード
[start_keyconfig]
;背景をbg_base
[bg storage="bg_base.png"]

;===LINK==================================================

[button x=1095 y=555 fix=true graphic="title/Link.png" enterimg="title/Link2.png" layer=2 auto_next="false" zindex=2 target="*LINK_URL"]


;=====================================================


; スタックの掃除
[clearstack]

[cm]

; すべてのメッセージ操作入力が無効
[stop_keyconfig]

;=====メイン====================
[jump target="*show_credit"]
[s]
;===============================

; クリック有効に戻す
[cm]

;==============================
; タイトルへ戻る
;==============================
@jump storage="title.ks"
[s]


;★★★★★★★★★★★★★★★★★



; ==================△▽ボタンを押したときの動作=============================
; 今度は[anim]で同じことをしています。
; +=100というように指定することで、いまいる位置を基準に移動量を指定できます。
; (単にleft="100"とすると、これは画面上の左から100pxの位置を目標として
; アニメーションしてしまいます。)
; その完了を[wa]で待ちます。

;==△==========================================================================
*scroll_up
;=================
[playse storage="pera_SE.mp3" volume=40 stop=false]

[anim name="creditpaper" top="+=200" time="500"]
[wa]
[return]
;=================

;==▽==========================================================================
*scroll_down
;=================
[playse storage="pera_SE.mp3" volume=40 stop=false]

[anim name="creditpaper" top="+=-200" time="500"]
[wa]
[return]
;=================

;==□==========================================================================
*scroll_reset
[playse storage="pera_SE.mp3" volume=40 stop=false]
;=================
; 画像を初期位置に戻す
[anim name="creditpaper" top=25 time="500"]
[wa]
[return]

;=================

[s]

;=====================================================







;============================手紙を閉じる処理================================
*close_credit
[playse storage="letter_SE.mp3" volume=40 stop=false]

; 350msかけて透明にしてフェードアウト。
; [anim][wa] フェードアウトアニメーション→その完了を待つ。
[anim name="creditpaper" time="350" opacity="0"]
[anim name="scroll_down" time="350" opacity="0"]
[anim name="scroll_up" time="350" opacity="0"]
[anim name="scroll_close" time="350" opacity="0"]

; フェードアウトが終わるまで待機。
[wa]


; 画像消す
[freeimage name="creditpaper" layer=2]
; ボタン消す
[clearfix name="scroll_down"]
[clearfix name="scroll_up"]
[clearfix name="scroll_close"]
[clearfix name="button_reset"]


;メッセージの解放
[start_keyconfig]

; Flgに1を入れる
[eval exp="tf.Flg = 1"]

; 閉じるボタンを押してたら元の位置にもどる
@jump storage="title.ks" cond="tf.Flg == 1"



[return]
;============================================================================
;====手紙を表示処理===============================================================

*show_credit
;===================================================================
; 紙をめくる音
[playse storage="letter_SE.mp3" volume=40 stop=false]
;===================================================================

;レイヤを表示
[layopt layer=2 visible=true page=fore]

; Flgに0を入れる
[eval exp="tf.Flg = 0"]

; すべてのメッセージ操作入力が無効
[stop_keyconfig]

; 手紙を表示 layer=2に表示
[image layer=2 name="creditpaper" storage="creditpaper.png" x=200 y=25 page=fore time=1000 zindex=1]

; ▽ボタンを押すと下にスクロール
[button  fix="true" layer=2 graphic="config/arrow_down.png" enterimg="config/arrow_down.png" auto_next="false" x="1095" y="280"  target="*scroll_down" name="scroll_down" zindex=2]

; △ボタンを押すと上にスクロール
[button  fix="true" layer=2 graphic="config/arrow_up.png" enterimg="config/arrow_up.png"  auto_next="false" x="1095" y="180" target="*scroll_up" name="scroll_up" zindex=2]

; 閉じるボタン
[button fix=true layer=2 x="1095" y="35" auto_next="false" target="*close_credit" name="scroll_close" zindex=2 graphic="config/c_btn_back.png" enterimg="config/c_btn_back2.png"]



; リセットボタン
[button fix=true layer=2 x="43" y="150" 0 auto_next="false"  name="button_reset" target="*scroll_reset" zindex=2 graphic="button/button_scroll_reset.png" enterimg="button/button_scroll_reset2.png"]



; 閉じるボタンを押してたら元の位置にもどる
@jump storage="title.ks" cond="tf.Flg == 1"


;=========================================================================================
[s]

*LINK_URL
;クリック待ちを挟む
[web url="https://form.run/@LostLetterCourier-Form"]
[return]
[s]

