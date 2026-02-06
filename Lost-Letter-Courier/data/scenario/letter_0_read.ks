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
[button fix="true" target="*show_manual" x="40" y="35" graphic="button/button_manual1.png" enterimg="button/button_manual2.png" auto_next=false  time="1000" name="manual_btn"]
;====================================================

; =====ここから大体同じ====================================================================================================================
[cm]
#
これは……。[p]

;=====メイン====================
; 手紙の表示処理にジャンプ
[jump target="*show_letter"]
[s]
;===============================




;★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
;-------------------------手紙0を読んだ後----------------------
;★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
*after_letter
;コールスタック解放
[clearstack]
;===============手順書ボタン操作====================
; 手帳ボタンを配置（常に表示）
[button fix="true" target="*show_manual" x="40" y="35" graphic="button/button_manual1.png" enterimg="button/button_manual2.png" auto_next=false  time="1000" name="manual_btn"]
;====================================================

#
…………。[p]

; レイヤーを解放
[freeimage layer=1]
;背景画像を Main.jpg に切り替え、フェード時間は 100ms
[bg storage="Main.jpg" time="100"]
; キャラクター（ヴロヒア）登場
; 画面左端からの絶対座標で表示（例：x=700pxの位置に表示）
[chara_show name="Vrochia" face="angry" left="700"]

;★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
;★★★★★★★★★★★★★★ストーリー★★★★★★★★★★★★
;★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★

[chara_mod  name="Vrochia" face="angry2" ]
#ヴロヒア
………。[p]

#
手紙を読み終わってチラリとヴロヒアを見ると、予想だにしない顔が浮かんでいて思わず肩を揺らす。[l][r]
どちらかと言えば微笑ましいような手紙だったはずだが、とてもそうは思えないような顔だ。[p]

視線に気づいたヴロヒアはぱっと表情をやわらげ、[l][r]
少し気恥ずかしそうに肩を竦めた。[p]


[chara_mod  name="Vrochia" face="normal3" ]
#ヴロヒア
……ほら、これも宛先が曖昧でしょう？[l][r]
身内への手紙みたいですが…。[p]
[chara_mod  name="Vrochia" face="normal" ]

#
トン、と指で手紙を示され視線を移す。[l][r]
言われた通り、確かに差出人はともかく宛先は書かれていない。[p]
文面にも名前は無いし、誰に届ければいいのかはさっぱりだった。[p]

これ、こんな宛先でも送れるの？[p]

聞くにはあの扉が勝手に宛先人へと繋げてくれるらしいが、いまいち信じられなかった。[l][r]
しかしこれまで当たり前に経験してきただろうヴロヒアは当然大仰に頷く。[p]

#ヴロヒア
勿論、送ろうと思えば送れますよ。[p]

[chara_mod  name="Vrochia" face="normal3" ]
#ヴロヒア
…でも、そうですね。[l][r]
これは配達しなくていいんじゃないですか？[p]
#
えっ…？[p]
思ってもみない言葉に目を瞬く。[p]

で、でも。友達の子供に向けての手紙みたいだし…。[p]

生まれる前の子供に向けてらしく、なんとなく慈しみを感じていた。[l][r]
そんな気分がヴロヒアの冷静な言葉に吹き飛ばされる。[p]

[chara_mod  name="Vrochia" face="angry2" ]
#ヴロヒア
まだ生まれてもいない子供相手の手紙です。[l][r]
会ってもないのにされた期待や願いなんて、本人にとっては知りもしないただの重責でしょう？[p]

#
ヴロヒア…？[p]

思わず名前を呼んで、戸惑いを顕わにする。[l][r]
今までの柔和なイメージとは明らかに違った。[p]
―――でも、なぜかどこか懐かしい。[p]

[chara_mod  name="Vrochia" face="normal5" ]
#ヴロヒア
きみは今、たった二通しか配達できないんですから。[p]


; =====ここまで大体同じ====================================================================================================================
; =====ここから同じではない====================================================================================================================


#
ゆっくりと閉口させて、その言葉に頷く。[p]

そう、そうかも。[p]

手元の手紙を見つめ、深く息を吐く。[p]
どうせ取捨選択は必要で、[l][r]
自分よりも長い時間この仕事を経験してきたヴロヒアが言うならきっとそうなのだろう。[p]
でも、この手紙を書いた人、送られるはずだった人を思って、[l][r]
少しだけ寂しい気持ちが脳裏を掠めた。[p]

[chara_mod  name="Vrochia" face="normal" ]
#ヴロヒア
まあ、最後に決めるのはきみです。[l][r]
…どうしますか？[p]

; ======================================================
; いろいろとクリアして有効化
[cm]
[current entity=true]


# この手紙を配達する？
; 文字リンク
[font color="#708090"]配達する[resetfont][r]
[link target="*letter0_eat"][mark color="0xff7f50" size=70]配達しない[endmark][endlink]
[s]
; ======================================================
*letter0_eat
[cm]
#
ヴロヒアがそう言うなら、…やめとこうか。[p]
;====================================================

浅く息を吐いて、手紙を机に置く。[p]
なんだか大事な手紙を手放したような、ひどい思い違いをしているような気がしたが、[l][r]
自分の力量を考えるならどうしようもないことなのだろう。[p]


#ヴロヒア
うん…、いいと思いますよ。[p]
#
ヴロヒアは殊勝なほど優しい声で言った。[p]

#ヴロヒア
…こんな手紙、送られた方も困っちゃうんじゃないですか？[l][r]
そうだ、折角なので消費までしてみましょうか。[p]

#
気になっていた提案をされて、単純にも気分が回復する。[l][r]
不思議な力というのはいつだって心が擽られる。[p]

消費？[l]そういえば、消費ってどうやるの？[p]

[chara_mod  name="Vrochia" face="normal3" ]
#ヴロヒア
大丈夫。[l]ほら、口をあけてみてください。[p]

#
えっ、た、食べるの？[p]

確かに消費には食べる意味もあるかもしれないが、[l][r]
それにしても手紙を食べるというのは聊か抵抗感があった。[p]
驚く様子を見て、ヴロヒアが噴出して笑い声を上げた。[p]

[chara_mod  name="Vrochia" face="happy" ]
#ヴロヒア
あははっ、正解です。[l][r]
配達しない手紙は私たちが食べちゃうんですよ。[p]

#
恐る恐る薄く開いた口の中に、ヴロヒアがさっきの手紙をそっと入れる。[p]

#ヴロヒア
[chara_mod  name="Vrochia" face="tere2" ]
……ほら、どうですか？[p]

#
口を閉じて、絶対においしくない味を待ち構えて……。[p]

…あれ？[l][r]
お、おいしい…！[p]

[chara_mod  name="Vrochia" face="happy" ]
#ヴロヒア
……ふ、ははっ！[l]おいしいですか？[p]

#
驚いたことに手紙は紙の味と言うよりも砂糖菓子のようで、[l][r]
ふんわりと溶けるように口の中で消えていった。[p]
目を見開きながら声を上げると、自分よりも嬉しそうにヴロヒアが笑う。[p]

#ヴロヒア
[chara_mod  name="Vrochia" face="normal" ]
そうやって、配達する手紙としない手紙を選別していってくださいね。[p]
さて、そろそろ時間ですかね。[l][r]
手順は大体わかりましたか？[p]

#
……もう行くの？[p]

一通だけの約束だったのは覚えていたが、それはそうとして寂しさは消えない。[l][r]
不安げな顔を隠せず声にもそれを乗せて呟くと、ヴロヒアはそっと励ましの言葉をかけて肩を叩いた。[p]

#ヴロヒア
そんな不安そうな顔をしないでください。[l][r]
この後は配達する手紙をもってそのドアから出るだけなので、今が一番大変ですよ。[p]
私も、自分の仕事が終われば見に来ますね。[p]

#
何を言われても不安な気持ちは拭えなかったが、彼の優しさに嘘は無い。[l][r]
頷いて迷いながら、少しだけ先延ばしにする言葉を小さく吐いた。[p]

#
その、配達の仕方についてもう少し教えてくれる…？[p]

[chara_mod  name="Vrochia" face="normal3" ]
ヴロヒアは笑って、快くそれに頷いて説明を始める。[p]

#ヴロヒア
いいですよ、……そうですね。[l][r]
[chara_mod  name="Vrochia" face="normal" ]
あのドアをくぐれば、手紙の本当の受取人の元に着きます。[p]

そして簡単に言うなら、[l][r]
こんな不思議な手紙を配達しても、受取人は私たちのことや手紙を不思議には思いません。[p]

[chara_mod  name="Vrochia" face="angry2" ]
ただ、あの頃受け取れなかった手紙を今更受け取る。[l][r]
もう戻れもしないのに、感傷に浸ったり、幸せになったつもりになるだけです。[p]

結局この手紙はぜーんぶ過去の物なんです。[l][r]
未来から過去には送れません。[p]

そして本来送られるはずの無い手紙は滞留しない。[p]

[chara_mod  name="Vrochia" face="normal3" ]
うん。だから本当に、この手紙はちょっとした隠し味みたいなものなんですよ。[l][r]
送り届けられずに続いた未来の今、あの時書かれた手紙を受け取る。[p]

[chara_mod  name="Vrochia" face="normal" ]
取り返しもやり直しもできません。[p]

ただの、思い出です。[p]

#
淡々と言葉を紡ぐヴロヒアの様子は、打って変わって寂しさを感じる。[l][r]
でも、それを言葉にできないのか、喉奥にごくりと飲み下したように見えた。[p]

それに、手を伸ばす。[l][r]
そうしないといけない気がした。[p]

……そうかもしれないけど、[l]…でも、少し寂しいね。[p]

[chara_mod  name="Vrochia" face="trouble3" ]
#ヴロヒア
！[l]
[chara_mod  name="Vrochia" face="happy2" ]
……ふふ。[p]

#
ヴロヒアは天啓を受けたように顔を綻ばせて、肩の力を抜いた。[p]

#ヴロヒア
確かに、本来届けられない手紙を読むことが出来るって言うのは特別かもしれません。[p]


さ、そんなしがない『落とし手紙配達人』の私たちは、せっせと手紙を運びましょうね。[p]

#
嫌に明るいヴロヒアの言葉に、含まれた意味を察して体が揺れる。[l][r]
見られていたのも落書きされたのも知っていたが、改めて言われると羞恥心が首をもたげた。[p]

#
っ！[l]ちょっと、からかわないでよ！[p]

[chara_mod  name="Vrochia" face="happy" ]
#ヴロヒア
あははっ、いいじゃないですか。[l]『落とし手紙配達人』。[l][r]
かわいい命名です。[p]
それにねこちゃんも。とってもかわいくて、私は好きですよ。[p]
#
誉められはしたが、羞恥心は消えない。[l][r]
さっきのヴロヒアも同じ気持ちだったのかと今更わからせられて、ため息が出た。[p]

[chara_mod  name="Vrochia" face="normal" ]
#ヴロヒア
そろそろ本当に行かないと。[l][r]
ひとりでも、残りの仕事頑張ってくださいね。[p]
…それじゃあ、またあとで。[p]

[jump target="*letter0_next"] 



;★★★★★★★★★★★★★★ストーリーおわり★★★★★★★★★★★★★★
;====================================================
*letter0_next
;キャラクター非表示
#
[chara_hide name="Vrochia"]

#
ヴロヒアが部屋を出ていく。[p]
ふと手紙を配達するでもない扉の先がどこに繋がっているのか疑問に思ったが、[l][r]
不思議な空間らしく当たり前のように彼の自室にでも繋がるのだろう。[p]

;===================================================================
; 足音
[playse storage="asi_SE.mp3" volume=40 stop=false]
; 1秒待機
[wait time=1000]
; SE を停止
[stopse name="asi_SE.mp3"]
;===================================================================

;===================================================================
; ドアの開閉音
[playse storage="door_SE.mp3" volume=40 stop=false]
;===================================================================

#
………。[p]

部屋に静寂が落ちる。[l][r]
相変わらず、見覚えのない部屋だったがどこか懐かしい気もするのが不思議だった。[p]
ペンの位置や、なじむ椅子。[p]
知らない家具に、使っていた気配のある雑貨。[p]
きっと確かに、自分はここで過ごしていたのだと色々なものが伝えていた。[p]

目の前には新品のようなポストと擦れた机があって、部屋の壁にはヴロヒアの出て行った扉がある。[l][r]
黄金の光が差す窓の外は何も見えない。[p]

ふと、さっき食べてしまった手紙を思い出した。[p]
紙を食べたはずなのに、なんだか甘くてふわふわとした心地がした。[l][r]
すぐに溶けるようになくなってしまったそれは、また食べてみたいと思わせる程の魅力があった。[p]

落ちたはずの喉や胃に違和感はなかった。[p]
不思議には思うが、そもそもこの空間も仕事もちょっと不思議だ。[l][r]
自分の記憶が頼りない以上、どこまでが普通でどこからが不思議なのかも自信が無かった。[p]

思考を切り替え、胸を撫でながらそっと息をつく。[p]

ヴロヒアの言うには、自分は何か忘れているらしい。[l][r]
確かに仕事の事も、ヴロヒアのこともわからない。[p]
……でも、今やるべきことだけは教えてもらった。[p]


仕事をしよう。[p]
まだ、手紙は残ってる。[p]


; letter_choice.ksへ移動
[jump storage="letter_choice.ks"]

;====================================================



;★★★★★★★★★★★★★★★★★ストーリーはいったん終わり★★★★★★★★★★★★★★★

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

[anim name="letter0" top="+=100" time="500"]
[wa]
[return]
;=================

;==▽==========================================================================
*scroll_down
;=================
[playse storage="pera_SE.mp3" volume=40 stop=false]

[anim name="letter0" top="+=-100" time="500"]
[wa]
[return]
;=================

;==□==========================================================================
*scroll_reset
[playse storage="pera_SE.mp3" volume=40 stop=false]
;=================
; 画像を初期位置に戻す
[anim name="letter0" top=25 time="500"]
[wa]
[return]

;=================
;==→←===================================================

; 手紙が数枚ある場合、表示を変える。
;*change_img1
; 紙をめくる音
;[playse storage="letter_SE.mp3" volume=40 stop=false]

;[image layer=2 name="letter0" storage="../image/letter/letter0.png" x=200 y=25 page=fore time=100 zindex=1]

; 1秒間操作を受け付けない
;[wait time=1000]

;[return]


;[s]

;*change_img2
; 紙をめくる音
;[playse storage="letter_SE.mp3" volume=40 stop=false]

;[image layer=2 name="letter0" storage="../image/letter/letter0_2.png" x=200 y=25 page=fore time=100 zindex=1]

; 1秒間操作を受け付けない
;[wait time=1000]

;[return]


;[s]
;=====================================================
;=================
;================================================================================================




;============================手紙を閉じる処理================================
*close_letter
[playse storage="letter_SE.mp3" volume=40 stop=false]

; 350msかけて透明にしてフェードアウト。
; [anim][wa] フェードアウトアニメーション→その完了を待つ。
[anim name="letter0" time="350" opacity="0"]
[anim name="scroll_down" time="350" opacity="0"]
[anim name="scroll_up" time="350" opacity="0"]
[anim name="scroll_close" time="350" opacity="0"]

; フェードアウトが終わるまで待機。
[wa]


; 画像消す
[freeimage name="letter0" layer=2]
; ボタン消す
[clearfix name="scroll_down"]
[clearfix name="scroll_up"]
[clearfix name="scroll_close"]
[clearfix name="button_reset"]

; 透明な画像を消す
;[clearfix name="clickblock"]

; メッセージウィンドウを表示する
[layopt layer=message0 visible=true]

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
; Flgに1を入れる
[eval exp="f.letter0_clauseFlg = 1"]

;メッセージの解放
[start_keyconfig]



; 閉じるボタンを押してたら元の位置にもどる
[jump target="*after_letter" cond="f.letter0_clauseFlg == 1"]



[return]
;============================================================================

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
[return]
;====================================================

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



;====手紙を表示処理===============================================================

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

; 0を入れる
[eval exp="f.letter0_clauseFlg = 0"]


; 手紙中動かないため
; すべてのメッセージ操作入力が無効
[stop_keyconfig]

; 手紙を表示 layer=2に表示
[image layer=2 name="letter0" storage="../image/letter/letter0.png" x=200 y=25 page=fore time=1000 zindex=1]

; ▽ボタンを押すと下にスクロール
[button  fix="true" layer=2 graphic="button/button_down.png" enterimg="button/button_down2.png" auto_next="false" x="1095" y="176"  target="*scroll_down" name="scroll_down" zindex=2]

; △ボタンを押すと上にスクロール
[button  fix="true" layer=2 graphic="button/button_up.png" enterimg="button/button_up2.png"  auto_next="false" x="1018" y="35" target="*scroll_up" name="scroll_up" zindex=2]

; 閉じるボタン
[button fix=true layer=2 x="39" y="169"   auto_next="false" target="*close_letter" name="scroll_close" zindex=2 graphic="button/button_letter_close.png" enterimg="button/button_letter_close2.png"]



; 手紙が数枚ある場合、表示を変える。ボタン
; → 1枚目へ
;[button x="1061" y="396" graphic="button/button_change1.png" target="*change_img1" fix="true" layer=2  auto_next="false" name="change_img1" zindex=2]

; ← 2枚目へ
;[button x="995" y="479" graphic="button/button_change2.png" target="*change_img2" fix="true" layer=2  auto_next="false" name="change_img2" zindex=3]



; リセットボタン
[button fix=true layer=2 x="43" y="360" auto_next="false"  name="button_reset" target="*scroll_reset" zindex=2 graphic="button/button_scroll_reset.png" enterimg="button/button_scroll_reset2.png"]


; 閉じるボタンを押してたら元の位置にもどる
[jump target="*after_letter" cond="f.letter0_clauseFlg == 1"]


;=========================================================================================
[s]






;====================
; 手紙中動かないため
;*no_op
;[return]
;[s]
;====================

