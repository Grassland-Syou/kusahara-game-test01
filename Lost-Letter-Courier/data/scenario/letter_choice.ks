;=====ここから多分デフォルト===========================================================================================================================================================
;シナリオ開始ラベル
*start
;===================================
;メッセージのカラー設定
[deffont color="black"]
[font color="black"]

;メッセージウィンドウのクリア
[cm]

;キー操作の初期設定をロード
[start_keyconfig]

;===============
; 一括で変数の初期化
[iscript]

; 手紙を何枚読んだか
f.letter_total = 0
; 選んだ手紙の道選び
f.letter_read_number = 0

[endscript]
;===============
; 手紙ボタン初期化
[eval exp="sf.letter1_Haitatsu = 0"]
[eval exp="sf.letter2_Haitatsu = 0"]
[eval exp="sf.letter3_Haitatsu = 0"]
[eval exp="sf.letter4_Haitatsu = 0"]
[eval exp="sf.letter5_Haitatsu = 0"]
;----------------------------------------



;===============手順書ボタン操作====================
; 手帳ボタンを配置（常に表示）
[button fix="true" target="*show_manual" x="40" y="35" graphic="button/button_manual1.png" enterimg="button/button_manual2.png" auto_next=false  time="1000" name="manual_btn"]
;====================================================

;背景画像を table.jpg に切り替え、フェード時間は 100ms
[bg storage="table.jpg" time="100"]
;[bg storage="table_test.jpg" time="100"]


; letter_totalが0ならHaitatsu_2に初期値2を入れる
[call target="*Haitatsu_2" cond="f.letter_total == 0"]



;=====手紙選択===========================================================================================================================================================
*letter_choice

; スタックの掃除
[clearstack]
[deffont color="black"]
[cm]
#
どの手紙を読もうか。[p]

; 手紙ボタンを表示
[if exp="f.letter3_Haitatsu == 2"]
[button name="letter3" target="*show_letter3" auto_next="false" x="208" y="51" graphic="letter/letter3_sub.png" enterimg="letter/letter3_sub2.png"]
[endif]

; 手紙ボタンを表示
[if exp="f.letter2_Haitatsu == 2"]
[button name="letter2" target="*show_letter2" auto_next="false" x="648" y="60" graphic="letter/letter2_sub.png" enterimg="letter/letter2_sub2.png"]
[endif]

; 手紙ボタンを表示
[if exp="f.letter4_Haitatsu == 2"]
[button name="letter4" target="*show_letter4" auto_next="false" x="448" y="184" graphic="letter/letter4_sub.png" enterimg="letter/letter4_sub2.png"]
[endif]

; 手紙ボタンを表示
[if exp="f.letter1_Haitatsu == 2"]
[button name="letter1" target="*show_letter1" auto_next="false" x="39" y="87" graphic="letter/letter1_sub.png" enterimg="letter/letter1_sub2.png"]
[endif]

; 手紙ボタンを表示
[if exp="f.letter5_Haitatsu == 2"]
[button name="letter5" target="*show_letter5" auto_next="false" x="802" y="235" graphic="letter/letter5_sub.png" enterimg="letter/letter5_sub2.png"]
[endif]

; クリックでテキスト送りできなくする
[s]

;===========================================================================
;=======*show_letter1=======================================================
;===========================================================================
*show_letter1
; いろいろとクリアして有効化
[cm]
[current entity=true]

# サクラ柄の手紙にする？
; 文字リンク
[link target="*letter1_read"][mark color="0xff7f50" size=70]これを読む[endmark][endlink][r]
[link target="*letter_choice"][mark color="0xff7f50" size=70]別の手紙を読む[endmark][endlink]
[s]
;===================
*letter1_read
[cm]
#
サクラ柄の手紙を読もう。[p]
; 画面をフェードアウトしてから letter_read_1 にジャンプ
[jump target="*letter_read_1"]
;===========================================================================
;========*show_letter2======================================================
;===========================================================================
*show_letter2
; いろいろとクリアして有効化
[cm]
[current entity=true]

# かわいらしい手紙にする？
; 文字リンク
[link target="*letter2_read"][mark color="0xff7f50" size=70]これを読む[endmark][endlink][r]
[link target="*letter_choice"][mark color="0xff7f50" size=70]別の手紙を読む[endmark][endlink]
[s]
;===================
*letter2_read
[cm]
#
かわいらしい手紙を読もう。[p]
; 画面をフェードアウトしてから letter_read_2 にジャンプ
[jump target="*letter_read_2"]
;===========================================================================
;==============================*show_letter3================================
;===========================================================================
*show_letter3
; いろいろとクリアして有効化
[cm]
[current entity=true]

# シンプルな手紙にする？
; 文字リンク
[link target="*letter3_read"][mark color="0xff7f50" size=70]これを読む[endmark][endlink][r]
[link target="*letter_choice"][mark color="0xff7f50" size=70]別の手紙を読む[endmark][endlink]
[s]
;===========================================================================
*letter3_read
[cm]
#
シンプルな手紙を読もう。[p]
; 画面をフェードアウトしてから letter3_read にジャンプ
[jump target="*letter_read_3"]
;===========================================================================
;==============================*show_letter4================================
;===========================================================================
*show_letter4
; いろいろとクリアして有効化
[cm]
[current entity=true]

# 綺麗な手紙にする？
; 文字リンク
[link target="*letter4_read"][mark color="0xff7f50" size=70]これを読む[endmark][endlink][r]
[link target="*letter_choice"][mark color="0xff7f50" size=70]別の手紙を読む[endmark][endlink]
[s]

;===========================================================================
*letter4_read
[cm]
#
綺麗な手紙を読もう。[p]
; 画面をフェードアウトしてから letter4_read にジャンプ
[jump target="*letter_read_4"]
;===========================================================================
;========*show_letter5======================================================
;===========================================================================
*show_letter5
; いろいろとクリアして有効化
[cm]
[current entity=true]

# …簡素な手紙にする？
; 文字リンク
[link target="*letter5_read"][mark color="0xff7f50" size=70]これを読む[endmark][endlink][r]
[link target="*letter_choice"][mark color="0xff7f50" size=70]別の手紙を読む[endmark][endlink]
[s]
;===========================================================================
*letter5_read
[cm]
#
簡素な手紙を読もう。[p]
; 画面をフェードアウトしてから letter5_read にジャンプ
[jump target="*letter_read_5"]
;===========================================================================




;===========================================================================
;========                         =======
;========     ここからread系      =======
;========                         =======
;===========================================================================

;===========================================================================
;=====手紙１を読む==========================================================
;===========================================================================
*letter_read_1

[cm]
#
これは……。[p]

; 手紙1を読むことを選んだ
[eval exp="f.letter_read_number = 1"]
; letter1_closeFlgに0を入れる
[eval exp="f.letter1_closeFlg = 0"]
; 手紙を呼ぶ画面へ行く
[jump target="*show_letter"]

;=======================================
;=====手紙１を読んだ後==================
;=======================================

*after_letter1

;コールスタック解放
[clearstack]
;========================

#
……。[p]

ぱっと見では誰への手紙かはわからない。[p]
ただ、きっと好きな人へ向けた手紙なのだということだけが伝わった。[l][r]
そしておそらくこれを書いた人は女性だろうということも。[p]
これからの希望に満ちた、明るい手紙だ。[p]

この手紙を配達するか、しないかを考えないといけない。[p]


[font color="#dc143c"]配達できる数は限られている。[resetfont][p]

; いろいろとクリアして有効化
[cm]
[current entity=true]

# この手紙を配達する？
; 文字リンク
[link target="*letter1_go"][mark color="0xff7f50" size=70]配達する[endmark][endlink][r]
[link target="*letter1_eat"][mark color="0xff7f50" size=70]消費する[endmark][endlink]
[s]

;=======================================
;=====手紙１を配達する==================
;=======================================
*letter1_go
[cm]
#
これは配達しようかな。[p]

; letter1_Haitatsuに1を入れる
[eval exp="f.letter1_Haitatsu = 1"]

[jump target=*letter1_next] 
;=======================================
;=====手紙１を食べる====================
;=======================================
*letter1_eat
[cm]
#
これは、諦めよう。[p]

; letter1_Haitatsuに0を入れる
[eval exp="f.letter1_Haitatsu = 0"]

[jump target=*letter1_next] 

;===========================================================================
;=====手紙２を読む==========================================================
;===========================================================================
*letter_read_2

[cm]
#
これは……。[p]

; 手紙2を読むことを選んだ
[eval exp="f.letter_read_number = 2"]
; letter2_closeFlgに0を入れる
[eval exp="f.letter2_closeFlg = 0"]

; 手紙を呼ぶ画面へ行く
[jump target="*show_letter"]

*after_letter2
;コールスタック解放
[clearstack]

#
……。[p]
随分と可愛らしい手紙に、どことない羞恥心と申し訳なさが襲う。[l][r]
ラブレターのようだが、肝心の重大発表は書かれていない。[p]
…でも、これは当時誰にも届かなかったのだ。[p]

この手紙を配達するか、しないかを考えないといけない。[p]

[font color="#dc143c"]配達できる数は限られている。[resetfont][p]

; いろいろとクリアして有効化
[cm]
[current entity=true]

# この手紙を配達する？
; 文字リンク
[link target="*letter2_go"][mark color="0xff7f50" size=70]配達する[endmark][endlink][r]
[link target="*letter2_eat"][mark color="0xff7f50" size=70]消費する[endmark][endlink]
[s]

;=======================================
;=====手紙１を配達する==================
;=======================================
*letter2_go
[cm]
#
これは配達しようかな。[p]

; letter2_Haitatsuに1を入れる
[eval exp="f.letter2_Haitatsu = 1"]

[jump target=*letter2_next] 
;=======================================
;=====手紙１を食べる====================
;=======================================
*letter2_eat
[cm]
#
これは、諦めよう。[p]

; letter2_Haitatsuに0を入れる
[eval exp="f.letter2_Haitatsu = 0"]

[jump target=*letter2_next] 
;===========================================================================
;=====手紙３を読む==========================================================
;===========================================================================
*letter_read_3
[cm]
#
これは……。[p]

; 手紙3を読むことを選んだ
[eval exp="f.letter_read_number = 3"]
; letter3_closeFlgに0を入れる
[eval exp="f.letter3_closeFlg = 0"]

; 手紙を呼ぶ画面へ行く
[jump target="*show_letter"]

*after_letter3
;コールスタック解放
[clearstack]

#
……。[p]

達筆だった。読みにくいほどに。[p]
おじいさんからの手紙らしく、厳しさと優しさを感じる文面だ。[p]
受け取るはずだった人が何か大変なことをしてしまったみたいで、[l][r]
おじいさんは心配してるみたいだったが当時この手紙は届けられていない。[p]

この手紙を配達するか、しないかを考えないといけない。[p]

[font color="#dc143c"]配達できる数は限られている。[resetfont][p]

; いろいろとクリアして有効化
[cm]
[current entity=true]

# この手紙を配達する？
; 文字リンク
[link target="*letter3_go"][mark color="0xff7f50" size=70]配達する[endmark][endlink][r]
[link target="*letter3_eat"][mark color="0xff7f50" size=70]消費する[endmark][endlink]
[s]


;=======================================
;=====手紙３を配達する==================
;=======================================
*letter3_go
[cm]
#
これは配達しようかな。[p]

; letter3_Haitatsuに1を入れる
[eval exp="f.letter3_Haitatsu = 1"]

[jump target=*letter3_next] 
;=======================================
;=====手紙３を食べる====================
;=======================================
*letter3_eat
[cm]
#
これは、諦めよう。[p]

; letter3_Haitatsuに0を入れる
[eval exp="f.letter3_Haitatsu = 0"]

[jump target=*letter3_next] 
;===========================================================================
;=====手紙４を読む==========================================================
;===========================================================================
*letter_read_4
[cm]
#
これは……。[p]

; 手紙4を読むことを選んだ
[eval exp="f.letter_read_number = 4"]
; letter4_closeFlgに0を入れる
[eval exp="f.letter4_closeFlg = 0"]

; 手紙を呼ぶ画面へ行く
[jump target="*show_letter"]

*after_letter4
;コールスタック解放
[clearstack]

#
……。[p]

これは、死んだ両親に向けてだろうか？[p]
そしてこの人自身も、今にも亡くなってしまいそうな雰囲気がある。[p]
…この名前、見覚えがあるような？[p]

この手紙を配達するか、しないかを考えないといけない。[p]
[font color="#dc143c"]配達できる数は限られている。[resetfont][p]

; いろいろとクリアして有効化
[cm]
[current entity=true]

# この手紙を配達する？
; 文字リンク
[link target="*letter4_go"][mark color="0xff7f50" size=70]配達する[endmark][endlink][r]
[link target="*letter4_eat"][mark color="0xff7f50" size=70]消費する[endmark][endlink]
[s]


;=======================================
;=====手紙４を配達する==================
;=======================================
*letter4_go
[cm]
#
これは配達しようかな。[p]

; letter4_Haitatsuに1を入れる
[eval exp="f.letter4_Haitatsu = 1"]

[jump target=*letter4_next] 
;=======================================
;=====手紙４を食べる====================
;=======================================
*letter4_eat
[cm]
#
これは、諦めよう。[p]

; letter4_Haitatsuに0を入れる
[eval exp="f.letter4_Haitatsu = 0"]

[jump target=*letter4_next] 
;===========================================================================
;=====手紙５を読む==========================================================
;===========================================================================
*letter_read_5
[cm]
#
これは……。[p]

; 手紙5を読むことを選んだ
[eval exp="f.letter_read_number = 5"]
; letter5_closeFlgに0を入れる
[eval exp="f.letter5_closeFlg = 0"]

; 手紙を呼ぶ画面へ行く
[jump target="*show_letter"]

*after_letter5
;コールスタック解放
[clearstack]

#
……。[p]

これって、手紙、なのだろうか？[p]
すごく酷いことが乱暴に書いてある気がするし、[l][r]
手紙と言うよりメモの切れ端だろう。[p]

この手紙を配達するか、しないかを考えないといけない。[p]
[font color="#dc143c"]配達できる数は限られている。[resetfont][p]

; いろいろとクリアして有効化
[cm]
[current entity=true]

# この手紙を配達する？
; 文字リンク
[link target="*letter5_go"][mark color="0xff7f50" size=70]配達する[endmark][endlink][r]
[link target="*letter5_eat"][mark color="0xff7f50" size=70]消費する[endmark][endlink]
[s]

;=======================================
;=====手紙５を配達する==================
;=======================================
*letter5_go
[cm]
#
これは配達しようかな。[p]

; letter5_Haitatsuに1を入れる
[eval exp="f.letter5_Haitatsu = 1"]

[jump target=*letter5_next] 
;=======================================
;=====手紙５を食べる====================
;=======================================
*letter5_eat
[cm]
#
これは、諦めよう。[p]

; letter5_Haitatsuに0を入れる
[eval exp="f.letter5_Haitatsu = 0"]

[jump target=*letter5_next] 
; =========================================
;========手紙の選択パート終了==============
;==========================================



; ===手紙選択に戻る===================================================

*letter1_next

; letter_totalに+1をする
[eval exp="f.letter_total = f.letter_total + 1"]

; ====================
; もしletter_totalが5ならletter_judgeに移動
[jump target="*letter_judge" cond="f.letter_total==5"]
; ====================

; ジャンプ
[jump target="*letter_choice"]

; ===手紙選択に戻る===================================================

*letter2_next

; letter_totalに+1をする
[eval exp="f.letter_total = f.letter_total + 1"]

; ====================
; もしletter_totalが5ならletter_judgeに移動
[jump target="*letter_judge" cond="f.letter_total==5"]
; ====================

; ジャンプ
[jump target="*letter_choice"]

; ===手紙選択に戻る===================================================

*letter3_next

; letter_totalに+1をする
[eval exp="f.letter_total = f.letter_total + 1"]

; ====================
; もしletter_totalが5ならletter_judgeに移動
[jump target="*letter_judge" cond="f.letter_total==5"]
; ====================

; ジャンプ
[jump target="*letter_choice"]

; ===手紙選択に戻る===================================================

*letter4_next

; letter_totalに+1をする
[eval exp="f.letter_total = f.letter_total + 1"]

; ====================
; もしletter_totalが5ならletter_judgeに移動
[jump target="*letter_judge" cond="f.letter_total==5"]
; ====================

; ジャンプ
[jump target="*letter_choice"]

; ===手紙選択に戻る===================================================

*letter5_next

; letter_totalに+1をする
[eval exp="f.letter_total = f.letter_total + 1"]

; ====================
; もしletter_totalが5ならletter_judgeに移動
[jump target="*letter_judge" cond="f.letter_total==5"]
; ====================

; ジャンプ
[jump target="*letter_choice"]



;===================================================================
;======ボタン=======================================================
;===================================================================

; ==================△▽ボタンを押したときの動作=============================
; 今度は[anim]で同じことをしています。
; +=100というように指定することで、いまいる位置を基準に移動量を指定できます。
; (単にleft="100"とすると、これは画面上の左から100pxの位置を目標として
; アニメーションしてしまいます。)
; その完了を[wa]で待ちます。


;==△==========================================================================
*scroll_up
;=================
; ぺらりと音を鳴らす
[playse storage="pera_SE.mp3" volume=40 stop=false]

; 手紙1を読むことを選んだのであれば
[if exp="f.letter_read_number == 1"]
[anim name="letter1" top="+=100" time="500"]
[wa]
[return]
; 手紙2を読むことを選んだのであれば
[elsif exp="f.letter_read_number == 2"]
[anim name="letter2" top="+=100" time="500"]
[wa]
[return]
[elsif exp="f.letter_read_number == 3"]
[anim name="letter3" top="+=100" time="500"]
[wa]
[return]
[elsif exp="f.letter_read_number == 4"]
[anim name="letter4" top="+=100" time="500"]
[wa]
[return]
[elsif exp="f.letter_read_number == 5"]
[anim name="letter5" top="+=100" time="500"]
[wa]
[return]
[else]
#
エラーだ…。sorry...1[p]
作者に教えてあげてください。[p]
[endif]

;=================

;==▽==========================================================================
*scroll_down
;=================
; ぺらりと音を鳴らす
[playse storage="pera_SE.mp3" volume=40 stop=false]

[if exp="f.letter_read_number == 1"]
[anim name="letter1" top="+=-100" time="500"]
[wa]
[return]
[elsif exp="f.letter_read_number == 2"]
[anim name="letter2" top="+=-100" time="500"]
[wa]
[return]
[elsif exp="f.letter_read_number == 3"]
[anim name="letter3" top="+=-100" time="500"]
[wa]
[return]

[elsif exp="f.letter_read_number == 4"]
[anim name="letter4" top="+=-100" time="500"]
[wa]
[return]

[elsif exp="f.letter_read_number == 5"]
[anim name="letter5" top="+=-100" time="500"]
[wa]
[return]

[else]
#
エラーだ…。sorry...2[p]
作者に教えてあげてください。[p]
[endif]


;=================

;==□==========================================================================
*scroll_reset
; ぺらりと音を鳴らす
[playse storage="pera_SE.mp3" volume=40 stop=false]
;=================
; 画像を初期位置に戻す
[if exp="f.letter_read_number == 1"]
[anim name="letter1" top=25 time="100"]
[wa]
[return]
[elsif exp="f.letter_read_number == 2"]
[anim name="letter2" top=25 time="100"]
[wa]
[return]

[elsif exp="f.letter_read_number == 3"]
[anim name="letter3" top=25 time="100"]
[wa]
[return]

[elsif exp="f.letter_read_number == 4"]
[anim name="letter4" top=25 time="100"]
[wa]
[return]

[elsif exp="f.letter_read_number == 5"]
[anim name="letter5" top=25 time="100"]
[wa]
[return]

[else]
#
エラーだ…。sorry...3[p]
作者に教えてあげてください。[p]
[endif]

;================================================================================================

*scroll_reset2
; 画像を初期位置に戻すkomatta...
[if exp="f.letter_read_number == 1"]
[anim name="letter1" top=25 time=0]
[return]
[elsif exp="f.letter_read_number == 2"]
[anim name="letter2" top=25 time=0]
[return]

[elsif exp="f.letter_read_number == 3"]
[anim name="letter3" top=25 time=0]
[return]

[elsif exp="f.letter_read_number == 4"]
[anim name="letter4" top=25 time=0]
[return]

[elsif exp="f.letter_read_number == 5"]
[anim name="letter5" top=25 time=0]
[return]

[else]
#
エラーだ…。sorry...4[p]
作者に教えてあげてください。[p]
[endif]

;==→←===================================================

; 手紙が数枚ある場合、表示を変える。
*change_img1
; 紙をめくる音
[playse storage="letter_SE.mp3" volume=40 stop=false]


[if exp="f.letter_read_number == 1"]
[image layer=2 name="letter1" storage="../image/letter/letter1.png" x=200 y=25 page=fore time=100 zindex=1 page=fore]
[jump target="*scroll_reset2"]
[wa]
; 1秒間操作を受け付けない
[wait time=1000]
[return]

[elsif exp="f.letter_read_number == 2"]
[image layer=2 name="letter2" storage="../image/letter/letter2.png" x=200 y=25 page=fore time=100 zindex=1 page=fore]

[jump target="*scroll_reset2"]
[wa]
; 1秒間操作を受け付けない
[wait time=1000]

[return]

[elsif exp="f.letter_read_number == 3"]
; 手紙が一枚なので何もない
; 1秒間操作を受け付けない
[wait time=1000]
[return]

[elsif exp="f.letter_read_number == 4"]
[image layer=2 name="letter4" storage="../image/letter/letter4.png" x=200 y=25 page=fore time=100 zindex=1 page=fore]

[jump target="*scroll_reset2"]
[wa]
; 1秒間操作を受け付けない
[wait time=1000]

[return]

[elsif exp="f.letter_read_number == 5"]
; 手紙が一枚なので何もない
; 1秒間操作を受け付けない
[wait time=1000]
[return]

[else]
#
エラーだ…。sorry...5[p]
作者に教えてあげてください。[p]
[endif]


; 1秒間操作を受け付けない
[wait time=1000]

[return]


[s]

*change_img2
; 紙をめくる音
[playse storage="letter_SE.mp3" volume=40 stop=false]


[if exp="f.letter_read_number == 1"]
[image layer=2 name="letter1" storage="../image/letter/letter1_2.png" x=200 y=25 page=fore time=100 zindex=1 page=fore]

[jump target="*scroll_reset2"]
[wa]
; 1秒間操作を受け付けない
[wait time=1000]

[return]
[elsif exp="f.letter_read_number == 2"]
[image layer=2 name="letter2" storage="../image/letter/letter2_2.png" x=200 y=25 page=fore time=100 zindex=1 page=fore]

[jump target="*scroll_reset2"]
[wa]
; 1秒間操作を受け付けない
[wait time=1000]

[return]

[elsif exp="f.letter_read_number == 3"]
; 手紙が一枚なので何もない
; 1秒間操作を受け付けない
[wait time=1000]
[return]

[elsif exp="f.letter_read_number == 4"]
[image layer=2 name="letter4" storage="../image/letter/letter4_2.png" x=200 y=25 page=fore time=100 zindex=1 page=fore]

[jump target="*scroll_reset2"]
[wa]
; 1秒間操作を受け付けない
[wait time=1000]

[return]

[elsif exp="f.letter_read_number == 5"]
; 手紙が一枚なので何もない
; 1秒間操作を受け付けない
[wait time=1000]
[return]

[else]
#
エラーだ…。sorry...6[p]
作者に教えてあげてください。[p]
[endif]

; 1秒間操作を受け付けない
[wait time=1000]

[return]

[s]
;=====================================================








;============================手紙を閉じる処理================================
*close_letter
; ぺらりと音を鳴らす
[playse storage="letter_SE.mp3" volume=40 stop=false]

; 350msかけて透明にしてフェードアウト。
; [anim][wa] フェードアウトアニメーション→その完了を待つ。

[if exp="f.letter_read_number == 1"]
[anim name="letter1" time="350" opacity="0"]

[elsif exp="f.letter_read_number == 2"]
[anim name="letter2" time="350" opacity="0"]

[elsif exp="f.letter_read_number == 3"]
[anim name="letter3" time="350" opacity="0"]

[elsif exp="f.letter_read_number == 4"]
[anim name="letter4" time="350" opacity="0"]

[elsif exp="f.letter_read_number == 5"]
[anim name="letter5" time="350" opacity="0"]

[else]
#
エラーだ…。sorry...7[p]
作者に教えてあげてください。[p]
[endif]

[anim name="scroll_down" time="350" opacity="0"]
[anim name="scroll_up" time="350" opacity="0"]
[anim name="scroll_close" time="350" opacity="0"]

; フェードアウトが終わるまで待機。
[wa]


[if exp="f.letter_read_number == 1"]
; 画像消す
[freeimage name="letter1" layer=2]
; letterX_closeFlgに1を入れる
[eval exp="f.letter1_closeFlg = 1"]

[elsif exp="f.letter_read_number == 2"]
; 画像消す
[freeimage name="letter2" layer=2]
; letterX_closeFlgに1を入れる
[eval exp="f.letter2_closeFlg = 1"]

[elsif exp="f.letter_read_number == 3"]
; 画像消す
[freeimage name="letter3" layer=2]
; letterX_closeFlgに1を入れる
[eval exp="f.letter3_closeFlg = 1"]

[elsif exp="f.letter_read_number == 4"]
; 画像消す
[freeimage name="letter4" layer=2]
; letterX_closeFlgに1を入れる
[eval exp="f.letter4_closeFlg = 1"]

[elsif exp="f.letter_read_number == 5"]
; 画像消す
[freeimage name="letter5" layer=2]
; letterX_closeFlgに1を入れる
[eval exp="f.letter5_closeFlg = 1"]

[else]
#
エラーだ…。sorry...8[p]
作者に教えてあげてください。[p]
[endif]

; ボタン消す
[clearfix name="scroll_down"]
[clearfix name="scroll_up"]
[clearfix name="scroll_close"]
[clearfix name="button_reset"]

; 矢印ボタンを消す
[clearfix name="change_img1"]
[clearfix name="change_img2"]


; メッセージウィンドウを表示する
[layopt layer=message0 visible=true]
;===============手順書ボタン操作====================
; 手帳ボタンを配置（常に表示）
[button fix="true" target="*show_manual" x="40" y="35" graphic="button/button_manual1.png" enterimg="button/button_manual2.png" auto_next=false  time="1000" name="manual_btn"]
;====================================================


;====================================================
; ロールボタン配置
 
;オートボタン
[button name="role_button" role="auto" graphic="button/auto.png" enterimg="button/auto2.png" x="740" y="540"]
 
;スキップボタン
[button name="role_button" role="skip" graphic="button/skip.png" enterimg="button/skip2.png" x="840" y="540"]
 
;バックログボタン
[button name="role_button" role="backlog" graphic="button/log.png" enterimg="button/log2.png" x="940" y="540"]
 
;コンフィグボタン（※sleepgame を使用して config.ks を呼び出しています）
[button name="role_button" role="sleepgame" graphic="button/sleep.png" enterimg="button/sleep2.png" storage="config.ks" x="1040" y="540"]
 
;メッセージウィンドウ非表示ボタン
[button name="role_button" role="window" graphic="button/close.png" enterimg="button/close2.png" x="1140" y="540"]

;;ロールボタン追加終わり
;====================================================

;メッセージの解放
[start_keyconfig]

; 閉じるボタンを押してたら元の位置にもどる
;[jump target="*after_letter"]

[if exp="f.letter_read_number == 1"]
; 閉じるボタンを押してたら元の位置にもどる
[jump target="*after_letter1"]

[elsif exp="f.letter_read_number == 2"]
; 閉じるボタンを押してたら元の位置にもどる
[jump target="*after_letter2"]

[elsif exp="f.letter_read_number == 3"]
; 閉じるボタンを押してたら元の位置にもどる
[jump target="*after_letter3"]

[elsif exp="f.letter_read_number == 4"]
; 閉じるボタンを押してたら元の位置にもどる
[jump target="*after_letter4"]

[elsif exp="f.letter_read_number == 5"]
; 閉じるボタンを押してたら元の位置にもどる
[jump target="*after_letter5"]
[else]
#
エラーだ…。sorry...9[p]
作者に教えてあげてください。[p]
[endif]

;メッセージの解放
[start_keyconfig]

[return]
;============================================================================



;============================================================================
;===============================手紙選択後===================================
;============================================================================



;============================================================================

*letter_judge

; どのEDにいくかという判定値
[eval exp="sf.letter_ED = 0"]

[cm]
#
さて、5通全て読み終わった。[p]
この選択に悔いはない。[p]

配達に行こう。[p]
[cm]
#
; 文字リンク
[link target="*LetsGO"][mark color="0xff7f50" size=70]扉を開ける[endmark][endlink]
[s]

*LetsGO
;==========
; 足音
[playse storage="asi_SE.mp3" volume=40 stop=false]
; 1秒待機
[wait time=1000]
; SE を停止
[stopse name="asi_SE.mp3"]
; ドアの開閉音
[playse storage="door_SE.mp3" volume=40 stop=false]
;==========

;ここで5通の手紙の判定をする。
; letterX_Haitatsuを判定
; 初期値2
; 多分数値はgo=1,eat=0
;[eval exp="f.letter1_Haitatsu = 1"]
;[eval exp="f.letter2_Haitatsu = 1"]
;[eval exp="f.letter3_Haitatsu = 1"]
;[eval exp="f.letter4_Haitatsu = 1"]
;[eval exp="f.letter5_Haitatsu = 1"]

;============================================================================
;============ED選択==========================================================
;============================================================================


; 3通以上の手紙がgoの場合、BADEND（ED1）
; 全部を足した数が3以上
[if exp="f.letter1_Haitatsu + f.letter2_Haitatsu + f.letter3_Haitatsu + f.letter4_Haitatsu + f.letter5_Haitatsu >= 3"]
[eval exp="sf.letter_ED = 1"]

; 全ての手紙がeatの場合、LOSSEREND（ED2）
; 全部を足した数が0
[elsif exp="f.letter1_Haitatsu + f.letter2_Haitatsu + f.letter3_Haitatsu + f.letter4_Haitatsu + f.letter5_Haitatsu == 0"]
[eval exp="sf.letter_ED = 2"]

; (ED3)
; letter1,letter2=go
[elsif exp="f.letter1_Haitatsu == 1 && f.letter2_Haitatsu == 1 && f.letter3_Haitatsu == 0 && f.letter4_Haitatsu == 0 && f.letter5_Haitatsu == 0"]
[eval exp="sf.letter_ED = 3"]

; (ED4)
; letter2,letter3=go
[elsif exp="f.letter1_Haitatsu == 0 && f.letter2_Haitatsu == 1 && f.letter3_Haitatsu == 1 && f.letter4_Haitatsu == 0 && f.letter5_Haitatsu == 0"]
[eval exp="sf.letter_ED = 4"]

; (ED5)
; letter1,letter5=go
[elsif exp="f.letter1_Haitatsu == 1 && f.letter2_Haitatsu == 0 && f.letter3_Haitatsu == 0 && f.letter4_Haitatsu == 0 && f.letter5_Haitatsu == 1"]
[eval exp="sf.letter_ED = 5"]

; (ED6)
; letter5,letter4=go
[elsif exp="f.letter1_Haitatsu == 0 && f.letter2_Haitatsu == 0 && f.letter3_Haitatsu == 0 && f.letter4_Haitatsu == 1 && f.letter5_Haitatsu == 1"]
[eval exp="sf.letter_ED = 6"]

; 全部を足した数が2なおかつsf.letter_EDが3,4,5,6ではない(特殊意外)
; (ED7)
;[if exp="f.letter1_Haitatsu + f.letter2_Haitatsu + f.letter3_Haitatsu + f.letter4_Haitatsu + f.letter5_Haitatsu == 2" ]
[elsif exp="f.letter1_Haitatsu + f.letter2_Haitatsu + f.letter3_Haitatsu + f.letter4_Haitatsu + f.letter5_Haitatsu == 2 && sf.letter_ED != 3 && sf.letter_ED != 4 && sf.letter_ED != 5 && sf.letter_ED != 6"]
[eval exp="sf.letter_ED = 7"]

; 全部を足した数が1（１通だけ配達）
; (EDなし)
[elsif exp="f.letter1_Haitatsu + f.letter2_Haitatsu + f.letter3_Haitatsu + f.letter4_Haitatsu + f.letter5_Haitatsu == 1"]
[eval exp="sf.letter_ED = 8"]

[else]
#
エラーだ…。sorry...10 どのEDにもいけなかったってこと？？？？[p]
作者に教えてあげてください。[p]
[endif]


; ======================
; 画面を2秒で黒フェードアウト
;暗転開始
[mask effect="fadeInDownBig" time=2000]

; ======================
;手順書消す
[clearfix]
;====================================================
; ロールボタン配置
 
;オートボタン
[button name="role_button" role="auto" graphic="button/auto.png" enterimg="button/auto2.png" x="740" y="540"]
 
;スキップボタン
[button name="role_button" role="skip" graphic="button/skip.png" enterimg="button/skip2.png" x="840" y="540"]
 
;バックログボタン
[button name="role_button" role="backlog" graphic="button/log.png" enterimg="button/log2.png" x="940" y="540"]
 
;コンフィグボタン（※sleepgame を使用して config.ks を呼び出しています）
[button name="role_button" role="sleepgame" graphic="button/sleep.png" enterimg="button/sleep2.png" storage="config.ks" x="1040" y="540"]
 
;メッセージウィンドウ非表示ボタン
[button name="role_button" role="window" graphic="button/close.png" enterimg="button/close2.png" x="1140" y="540"]

;;ロールボタン追加終わり
;====================================================


;============================================================================
; 全ての手紙がeatの場合、LOSSEREND（ED2）====================================
;============================================================================
; 全ての手紙がeatの場合、LOSSEREND（ED2）
[if exp="sf.letter_ED == 2"]

; ending2.ksの*endingstory2にジャンプ
[jump storage="ending2.ks" target="*endingstory2"]

[endif]
; ==============================================================================================================

;============================================================================
; 3通以上の手紙がgoの場合、BADEND（ED1）=====================================
;============================================================================
[if exp="sf.letter_ED == 1"]

; ending1.ksの*endingstory1にジャンプ
[jump storage="ending1.ks" target="*endingstory1"]

[endif]
;====================================================================================================================================

;============================================================================
; その順当ＥＤ前ストーリー===================================================
;============================================================================
; ending_storyへ
[jump target="*ending_story"]
; =================================

; ED1,2以外こっちへ行くはず
*ending_story
[cm]
; BGMフェードイン
[fadeinbgm storage=EDBGM2.mp3 loop=true time=3000 volume=40]

;背景画像を sky.jpg に切り替え
[bg storage="sky.jpg"]

;暗転解除
[mask_off]

; クリック待機
[l]
#
扉を開く。[l][r]
この扉の先には、いつかの日この手紙を受け取れなかった誰かがいる。[p]

…行こう。[p]

; ごそごそとした音
[playse storage="gasagoso_SE.mp3" volume=40 stop=false]
; 2秒待機（2000ミリ秒）
[wait time=2000]

[cm]
;===================================================================

;===================================================================
;======letter1を配達する選択肢を選んだ時================================================================================================================
;===================================================================
[if exp="f.letter1_Haitatsu == 1" ]

; letter_story.ksの*letter1_choiceにジャンプ
[call storage="letter_story.ks" target="*letter1_choice"]

; 戻ってくる↓

[endif]

;===================================================================
;======letter2を配達する選択肢を選んだ時================================================================================================================
;===================================================================

[if exp="f.letter2_Haitatsu == 1" ]

; letter_story.ksの*letter2_choiceにジャンプ
[call storage="letter_story.ks" target="*letter2_choice"]

; 戻ってくる↓

[endif]


;===================================================================
;======letter3を配達する選択肢を選んだ時================================================================================================================
;===================================================================
; 一通目に2の手紙も選んだ場合の少し特殊なそれ
[if exp="f.letter3_Haitatsu == 1 && f.letter2_Haitatsu == 1"]

; letter_story.ksの*letter1_choice_1にジャンプ
[call storage="letter_story.ks" target="*letter3_choice_1"]

; 戻ってくる↓

[endif]

;===================================================================
;2の手紙は選ばなかった
[if exp="f.letter3_Haitatsu == 1 && f.letter2_Haitatsu !== 1"]

; letter_story.ksの*letter1_choice_2にジャンプ
[call storage="letter_story.ks" target="*letter3_choice_2"]

; 戻ってくる↓

[endif]

;===================================================================
;======letter4を配達する選択肢を選んだ時================================================================================================================
;===================================================================

[if exp="f.letter4_Haitatsu == 1" ]

; letter_story.ksの*letter4_choiceにジャンプ
[call storage="letter_story.ks" target="*letter4_choice"]

; 戻ってくる↓

[endif]

;===================================================================
;======letter5を配達する選択肢を選んだ時================================================================================================================
;===================================================================

[if exp="f.letter5_Haitatsu == 1" ]

; letter_story.ksの*letter5_choiceにジャンプ
[call storage="letter_story.ks" target="*letter5_choice"]

; 戻ってくる↓

[endif]

;===================================================================


;======全ての配達を終えた。=============================================================


;暗転開始
[mask effect="fadeInDownBig" time=2000]

[cm]
;コールスタック解放
[clearstack]
;★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
;====letter1,letter2=goのため、ED3へ
;★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
[if exp="sf.letter_ED == 3"]
;★★★★★★
; ending3.ksの*endingstory3にジャンプ
[jump storage="ending3.ks" target="*endingstory3"]
;★★★★★★

[endif]
;===================================================================

;★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
;====letter2,letter3=goのため、ED4へ
;★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★

[if exp="sf.letter_ED == 4"]

;★★★★★★
; ending4.ksの*endingstory4にジャンプ
[jump storage="ending4.ks" target="*endingstory4"]
;★★★★★★

[endif]


;★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
;====letter1,letter5=goのため、ED5へ
;★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★

[if exp="sf.letter_ED == 5"]

;★★★★★★
; ending5.ksの*endingstory5にジャンプ
[jump storage="ending5.ks" target="*endingstory5"]
;★★★★★★

[endif]


;★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
;====letter5,letter4=goのため、ED6へ
;★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
[if exp="sf.letter_ED == 6"]

;★★★★★★
; ending6.ksの*endingstory6にジャンプ
[jump storage="ending6.ks" target="*endingstory6"]
;★★★★★★

[endif]

;★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
;====全部を足した数が2なおかつsf.letter_EDが3,4,5,6ではない(特殊意外)のため、ED7へ
;====全部を足した数が1（１通だけ配達）のため、ED8へ
;★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★

[if exp="sf.letter_ED == 7 || sf.letter_ED == 8"]

;★★★★★★
; ending7.ksの*endingstory7にジャンプ
[jump storage="ending7.ks" target="*endingstory7"]
;★★★★★★

[endif]

;★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
;====手紙を読む===============================================================

*show_letter
;===================================================================
; 紙をめくる音
[playse storage="letter_SE.mp3" volume=40 stop=false]
;===================================================================
; メッセージウィンドウを消す
[layopt layer="message0" visible=false]
;多分その他メニューのボタンを消す
@layopt layer=fix visible=false


;縁取り画像を表示
[image layer=1 storage="waku.png" x=0 y=0 ]

;レイヤを表示
[layopt layer=2 visible=true page=fore]


; 手紙中動かないため
; すべてのメッセージ操作入力が無効
[stop_keyconfig]


[if exp="f.letter_read_number == 1"]
; 手紙1を表示 layer=2に表示
[image layer=2 name="letter1" storage="../image/letter/letter1.png" x=240 y=25 page=fore time=1000 zindex=1]

[elsif exp="f.letter_read_number == 2"]
; 手紙2を表示 layer=2に表示
[image layer=2 name="letter2" storage="../image/letter/letter2.png" x=240 y=25 page=fore time=1000 zindex=1]

[elsif exp="f.letter_read_number == 3"]
; 手紙3を表示 layer=2に表示
[image layer=2 name="letter3" storage="../image/letter/letter3.png" x=240 y=25 page=fore time=1000 zindex=1]

[elsif exp="f.letter_read_number == 4"]
; 手紙4を表示 layer=2に表示
[image layer=2 name="letter4" storage="../image/letter/letter4.png" x=240 y=25 page=fore time=1000 zindex=1]

[elsif exp="f.letter_read_number == 5"]
; 手紙5を表示 layer=2に表示
[image layer=2 name="letter5" storage="../image/letter/letter5.png" x=240 y=25 page=fore time=1000 zindex=1]

[else]
#
エラーだ…。sorry...11[p]
作者に教えてあげてください。[p]
[endif]


; 手紙の表示が終わったらここに来るはず

;=====共通ボタンを表示==============================================================

; ▽ボタンを押すと下にスクロール
[button  fix="true" layer=2 graphic="button/button_down.png" enterimg="button/button_down2.png" auto_next="false" x="1095" y="176"  target="*scroll_down" name="scroll_down" zindex=2]

; △ボタンを押すと上にスクロール
[button  fix="true" layer=2 graphic="button/button_up.png" enterimg="button/button_up2.png"  auto_next="false" x="1018" y="35" target="*scroll_up" name="scroll_up" zindex=2]

; 閉じるボタン
[button fix=true layer=2 x="39" y="169"   auto_next="false" target="*close_letter" name="scroll_close" zindex=2 graphic="button/button_letter_close.png" enterimg="button/button_letter_close2.png"]

; リセットボタン
[button fix=true layer=2 x="43" y="360" 0 auto_next="false"  name="button_reset" target="*scroll_reset" zindex=2 graphic="button/button_scroll_reset.png" enterimg="button/button_scroll_reset2.png"]

; 手紙が数枚ある場合、表示を変える。ボタン
; ← 1枚目へ
[button x="1032" y="512" graphic="button/button_change1.png"  enterimg="button/button_change1_2.png" target="*change_img1" fix="true" layer=2  auto_next="false" name="change_img1" zindex=2]

; → 2枚目へ
[button x="1081" y="348" graphic="button/button_change2.png"  enterimg="button/button_change2_2.png" target="*change_img2" fix="true" layer=2  auto_next="false" name="change_img2" zindex=3]



;[if exp="f.letter_read_number == 1"]
; 閉じるボタンを押してたら元の位置にもどる
;[jump target="*after_letter1" cond="f.letter1_closeFlg==1"]

;[elsif exp="f.letter_read_number == 2"]
; 閉じるボタンを押してたら元の位置にもどる
;[jump target="*after_letter2" cond="f.letter1_closeFlg==1"]

;[elsif exp="f.letter_read_number == 3"]
; 閉じるボタンを押してたら元の位置にもどる
;[jump target="*after_letter3" cond="f.letter1_closeFlg==1"]

;[elsif exp="f.letter_read_number == 4"]
; 閉じるボタンを押してたら元の位置にもどる
;[jump target="*after_letter4" cond="f.letter1_closeFlg==1"]

;[elsif exp="f.letter_read_number == 5"]
; 閉じるボタンを押してたら元の位置にもどる
;[jump target="*after_letter5" cond="f.letter1_closeFlg==1"]

;[else]
;#
;エラーだ…。sorry...12[p]
;作者に教えてあげてください。[p]
;[endif]

[s]
;=========================================================================================



;============================================================================
;============================================================================
;============================================================================
;============================================================================
*Haitatsu_2
; letter_Haitatsuに2を入れる

[eval exp="f.letter1_Haitatsu = 2"]
[eval exp="f.letter2_Haitatsu = 2"]
[eval exp="f.letter3_Haitatsu = 2"]
[eval exp="f.letter4_Haitatsu = 2"]
[eval exp="f.letter5_Haitatsu = 2"]
[return]
[s]
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
[s]
;============================================================================

;============================================================================
; 手順書を消すラベル
*Sub_Hide

; manual。という名前の固定ボタンを解放。画面から削除されます。
[clearfix name="manual"]

;stamp画像を削除
[clearfix name="stamp_0"]
[clearfix name="stamp_1"]
[clearfix name="stamp_2"]
[clearfix name="stamp_3"]
[clearfix name="stamp_4"]
[clearfix name="stamp_5"]
[clearfix name="stamp_6"]
[clearfix name="stamp_7"]

;メッセージの解放
[start_keyconfig]

[return]
;============================================================================
[s]

;====================
; 手紙中動かないため
;*no_op
;[return]
;[s]
;====================

