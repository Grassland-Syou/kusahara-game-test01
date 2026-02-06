
*start
[cm]
[resetfont]
;画面上のテキストやメッセージの履歴をクリアする
;タイトル画面を表示する前に、前のシナリオの内容を消す
@clearstack
;手順書消す
[clearfix]

; ===================================縁どり画像表示===================================

;レイヤを表示
[layopt layer=1 visible=true page=fore]
;縁取り画像を表示
[image layer=1 storage="waku.png" x=0 y=0 zindex=50]

; =====================================================================================

; 起動時チェック※
[if exp="sf.notice_read != true"]
[jump target="*notice"]
[endif]

; ==========
;BGM再生
;time でフェードイン再生
@playbgm time="3000" storage=titleBGM.mp3 loop=true volume=40

; =================================
[if exp="sf.letter_0_Flag == 1"]
;タイトル背景を Title2.jpg に設定
@bg storage ="title2.jpg" time=100
; CG開け
[cg storage="title2.jpg"]
[cg storage="SPtitle2.jpg"]

[else]
;タイトル背景を Title.jpg に設定
;time=100 はフェード時間（ミリ秒）で、ゆっくり切り替える演出
@bg storage ="title.jpg" time=100
; CG開け
[cg storage="title.jpg"]
[cg storage="SPtitle.jpg"]
[endif]
; =================================
;暗転解除
[mask_off]

;次の命令まで 200 ミリ秒待つ
@wait time = 200


;ボタンの設定
;はじめから【配達する】
[button x=868 y=305 graphic="title/button_Haitatu1.png" enterimg="title/button_Haitatu2.png"  target="gamestart" keyfocus="1"]
;つづきから【手紙を読む】
[button x=868 y=405 graphic="title/button_Tegami1.png" enterimg="title/button_Tegami2.png" role="load" keyfocus="2"]


;CGモード【写真を見る】
[button x=868 y=505 graphic="title/button_Syasin1.png" enterimg="title/button_Syasin2.png" storage="cg.ks" keyfocus="3"]
;コンフィグ【Config】
[button x=1048 y=505 graphic="title/button_Config1.png" enterimg="title/button_Config2.png" role="sleepgame" storage="config.ks" keyfocus="4"]


;クレジット
[button x=1076 y=555 graphic="title/credit.png" enterimg="title/credit2.png"  target="go_credit" keyfocus="5"]


;スクリプト区切り
[s]


;========================================
;ラベルを定義
;@jump target="gamestart" などで呼び出すことができる
*gamestart
;========================================


;一番最初のシナリオファイルへジャンプする
;scene1.ks にジャンプして、実際のゲームシナリオが開始される
@jump storage="scene1.ks"
[s]


;================ クレジット即時遷移 =================
*go_credit
[jump storage="credit.ks"]
; ===※==================================================================================
*notice

;背景を黒
[bg storage="black.jpg"]

[backlay]
[ptext page=back text="【ご注意】" size=30 x=110 y=50 color=red vertical=false layer=0]

[ptext page=back text="本作品はフィクションです。" size=30 x=110 y=100 color=white vertical=false layer=0]
[ptext page=back text="実在の人物・団体・事件等とは一切関係ありません。" size=30 x=110 y=150 color=white vertical=false layer=0]

[ptext page=back text="本作品には、自殺を想起させる描写や、" size=30 x=110 y=220 color=white vertical=false layer=0]
[ptext page=back text="人間関係の葛藤、精神的苦痛を伴う表現が含まれます。" size=30 x=110 y=270 color=white vertical=false layer=0]

[ptext page=back text="本作は15歳以上のプレイヤーを対象としています。" size=30 x=110 y=340 color=white vertical=false layer=0]
[ptext page=back text="本作品は、現実世界での行動指針や助言を目的としたものではありません。" size=30 x=110 y=390 color=white vertical=false layer=0]

[ptext page=back text="内容に不安を感じた場合は、" size=30 x=110 y=460 color=white vertical=false layer=0]
[ptext page=back text="ご自身の判断でプレイを中止してください。" size=30 x=110 y=510 color=white vertical=false layer=0]

[ptext page=back text="詳しい注意事項・権利表記については、" size=30 x=110 y=580 color=white vertical=false layer=0]
[ptext page=back text="タイトル画面右下の「※」ボタンからご確認ください。" size=30 x=110 y=630 color=white vertical=false layer=0]

; フラグを立てる
[eval exp="sf.notice_read = true"]

[trans time=5000 layer=0]
[wt]
[l]

;表示したテキストを消去します
[freeimage layer=0]
; タイトルへ戻る
[jump target="*start"]
; =====================================================================================

