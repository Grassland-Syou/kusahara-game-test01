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

言うにはあの扉が勝手に宛先人へと繋げてくれるらしいが、いまいち信じられなかった。[l][r]
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

産まれる前の子供に向けてらしく、なんとなく慈しみを感じていた。[l][r]
そんな気分がヴロヒアの冷静な言葉に吹き飛ばされる。[p]

[chara_mod  name="Vrochia" face="angry2" ]
#ヴロヒア
まだ生まれてもいない子供相手の手紙です。[l][r]
会ってもないのにされた期待や願いなんて、本人にとっては知りもしないただの重責でしょう？[p]

#
ヴロヒア…？[p]

思わず名前を呼んで、戸惑いを顕わにする。[l][r]
今までの柔和なイメージとは明らかに違った。[p]

[chara_mod  name="Vrochia" face="normal5" ]
#ヴロヒア
きみは今、たった二通しか配達できないんですから。[p]


; =====ここまで大体同じ====================================================================================================================
; =====ここから同じではない====================================================================================================================

#
……。[p]
; ===特別追加====================
そう、そうかな？[p]

手元の手紙を見つめ、首を捻る。[l][r]
この手紙を書いた人がいて、送られるはずだった人がいる。[p]
その気持ちを受け取った最後の砦が、自分だった。[p]

; ===============================
[chara_mod  name="Vrochia" face="normal" ]
#ヴロヒア
まあ、最後に決めるのはきみです。[l][r]
…どうしますか？[p]

; ===特別追加====================
#
……。[p]
……？[p]



掴んでいた手紙が、不思議と重く感じられる。[l][r]
不意に指先から記憶の欠片が零れ落ちた。[p]

; ===============================

; いろいろとクリアして有効化
[cm]
[current entity=true]

# この手紙……。
; 選択肢
[link target="*letter0_go"][mark color="0xff7f50" size=70]受け取る[endmark][endlink][r]
[link target="*letter0_eat0"][mark color="0xff7f50" size=70]消費する[endmark][endlink]
[s]
; ======================================================
; ====================特殊エンド用======================
; ==============地獄に留まることを選んだ幸福============
; ======================================================
*letter0_go
; =======================
;BGM再生
;time でフェードイン再生
@playbgm time="3000" storage=titleBGM.mp3 loop=true  volume=30
[cm]
; =======================

[skipstop]
[chara_mod  name="Vrochia" face="wow" ]
#ヴロヒア
えっ。[p]
#
驚いた顔のヴロヒアに、そっと手紙を撫でながら頷く。[l][r]
なぜか、今まで微かにも無かったはずの自分の記憶が朧気に蘇っていた。[p]

これ、この手紙…。[l][r]
差出人って、……もしかしてヴロヒア？[p]

[chara_mod  name="Vrochia" face="wow3" ]
#ヴロヒア
………！[p]
#
信じられないような顔で真っすぐと見つめられ、やっぱり、と嘆息が漏れた。[l][r]
少しだけ居心地の悪い気分で笑って、頭を振る。[p]
まだ、記憶の波がごちゃついていた。[p]

#ヴロヒア
な、なんで……。[p]

#
信じられない様子でヴロヒアが声を震わせながら聞き返した。[l][r]
手紙を机において、先ほどポストから取り出してきたはずの手紙の束を改めて見つめた。[p]
答えは全部、[l]ここにある。[p]

……この手紙、本当にこの部屋のポストから取り出したの？[p]

部屋にシンとした空気が漂う。[l][r]
…そう、ポストにあった手紙は5通だ。[p]
6通目になるこの手紙は、きっとこの部屋じゃないどこかから[l][r]
『誰か』によって配達されてきた。[p]

#
問いかけられたヴロヒアはその綺麗な瞳をきゅうっと細めて、自嘲するように笑った。[p]

[chara_mod  name="Vrochia" face="trouble2" ]
#ヴロヒア
……あー。[l][r]
よく、見てますね。[p]

#
その言葉には諦めと肯定と、寂しさが滲んでいた。[p]

その、いろいろと、思い出して…。[p]

責めているわけじゃなかった。[l][r]
むしろ責められるべきは自分で、記憶のなかった一瞬ですら許しがたい。[p]


[chara_mod  name="Vrochia" face="wow" ]
#ヴロヒア
え…？[p]
#
……ずっと、ありがとう。[l]それと、忘れてごめん。[p]

#ヴロヒア
……ぁ。[p]

#
ヴロヒアが目を見開いて、はくりと口を閉ざす。[l][r]
間抜けな顔なのに、どこか揮発するような悦びがあった。[p]

#
過去の記憶が微かに蘇った今、[l][r]
ようやく目覚めたくせに記憶をなくしていた自分が酷い薄情者に思えた。[p]
寂し気な顔をしたヴロヒア[l][r]
それでも優しくはにかんで、嬉しさを露わにしたヴロヒア[p]
優しくイチから教えてくれたヴロヒア[p]
その全部を申し訳ないと思うのに、泣きたくなるほど、嬉しい。[p]

生まれないまま死んだ魂なんかを、拾って、育ててくれてたんだ。[p]

[chara_mod  name="Vrochia" face="trouble2" ]
#ヴロヒア
……。[p]
[chara_mod  name="Vrochia" face="mu" ]
運命だと、思ったんです。[p]
#
うん。[p]

#
目を伏せて、懺悔するようにヴロヒアは呟く。[p]

#ヴロヒア
……自分の浅慮の結果を、贖罪する機会だと。[p]

#
顔を反らすヴロヒアは本気で過去を後悔しているようだった。[l][r]
それが今の自分には嬉しくて、唇が持ち上がる。[p]

許しを得たくて、僕を育ててた？[p]

#ヴロヒア
っ……！[l][r]
…………は、じめは、そうでした。[p]

#
ふ、ははっ、今は違うんだ。[l]ほんとに？[p]

苦々し気な表情のヴロヒアとは裏腹に、笑いながら答えると視線がぶつかる。[l][r]
笑っている僕を信じられないように驚愕色に顔を染めて、後ろに後ずさった。[p]

[chara_mod  name="Vrochia" face="wow3" ]
#ヴロヒア
なん、なんで…。[p]

#
なんで笑えるかって？[l][r]
そんなの、ヴロヒアのおかげだ。[p]


思ったよりもたおやかな声が出て、自分でも嬉しくなる。[l][r]
記憶がほとんどない時でも、ヴロヒアの顔を見て安心感を覚えた。[p]
自分ができる前の朧げな魂にすら、記憶にこびりつくような何かがあったのだ。[p]
この世界での、不完全な存在の確率なんてちっとも想像ができない。[l][r]
それでも、それが大変で、特別で、難しいことだけは理解できた。[p]

時空の歪んだこの世界で、どれだけの時間を一緒に過ごしたんだろうか。[p]
どれだけのモノを、君に費やさせたんだろうか。[p]

その全てをちゃんと覚えていないことが申し訳なくて、歯がゆくて苦しかった。[l][r]
一緒に過ごした時間を、思い出を、共有できないことが悲しい。[p]

それでも、忘れられないことがある。[p]


#
ヴロヒアに拾われて、育ててもらえて。[l][r]
―――愛してもらえて、よかったって思ってる。[p]

[chara_mod  name="Vrochia" face="mu2" ]

#ヴロヒア
……あ。[l][r]
…っはは、本気ですか？[p]
きみの両親を、めちゃくちゃにした元凶ですよ？[l][r]
……きみには、怒る権利があります。[p]

#
自嘲気味に呟くヴロヒアに、首を振って答える。[l][r]
正直な話、会ったこともない両親への情は目の前の育ての親と比べるとほとんど無かった。[p]
薄情だろうか。[l][r]
でも、だって、事実だ。[p]
確かに母親への憧憬や憐憫はあるけれど、今の自分にとって彼女はまだただの他人だ。[l][r]
自分にとっての家族というのは、どう取り繕っても目の前のたった一人だけだった。[p]
ヴロヒアは自分が悪いって言うけど、悪い人なんて、きっといくらでも、どこにでもいる。[p]

そりゃ、生まれられなかったって言うのは少しは残念に思うけど……。[p]

[chara_mod  name="Vrochia" face="normal4" ]

目を見る。[l][r]
逸らされる事の無いようにそっと手で服を引いて、それこそ子供みたいに視線を強請った。[p]

今が一番、幸せだって自信をもって言えるよ。[p]

井の中の蛙だろうか。[p]
でも、それだっていい。[p]
全てを知ることはできないのだから、自分の知る中で一番幸せならそれこそ世界で一番の幸福だろう。[p]

あ、一番大事なことも。[l][r]
ヴロヒアの事も幸せにできたから、やっぱり今が、一番幸せ。[p]
[chara_mod name="Vrochia" face="trouble3" ]

……こんなに欲張りなこと、ある？[p]

呆然と夕日色の瞳が僕を貫く。[l][r]
瞬きをするたびに伝わる困惑と驚愕の視線に、やっぱりおかしくって苦笑が漏れた。[p]

昔はもっと冷たい色をしていた気がするそれも、すっかり穏やかだ。[p]
夕焼けの奥に、雨の名残を閉じ込めたような。[p]

#
僕を拾ったこと、後悔してる？[p]

随分ずるい質問だった。[l][r]
答えがわかるほどに、自分は君からの言葉と行動を貰った。[p]
思った通り、ヴロヒアははじけるように顔を上げて否定の声を上げる。[p]

[chara_mod  name="Vrochia" face="wow4" ]
#ヴロヒア
っまさか！[l][r]
……まさに、天からの、贈り物だと。[p]
[chara_mod  name="Vrochia" face="mu" ]
きみにとっては、……違う。[p]
#
…ヴロヒアは、僕を拾って不幸だった？[p]

[chara_mod  name="Vrochia" face="sad6" ]

#ヴロヒア
…いいえ、いいえ。[p]

[chara_mod  name="Vrochia" face="tere3" ]
幸せ、でした。本当に、心の底から[l][r]
―――きっと幸せとは、きみの形をしているのだと、。[p]

[chara_mod  name="Vrochia" face="trouble3" ]

#
ヴロヒアが自分の言葉に驚いたように息を止める。[p]

ほっと、知らず知らずのうちに息を吐いた。[p]
そりゃあ、いくら愛された自覚があってもこんな風にうだうだ言われたら不安にもなる。[l][r]
少しくらい自信を持ってほしかった。[p]

ああ、でも、これがヴロヒアだ。[p]

僕も、幸せだよ。[l]心の底から。[l][r]
きっと幸せをくれる天使は、ヴロヒアのかたちをしてるね。[p]

[chara_mod  name="Vrochia" face="wow4" ]

#ヴロヒア
…………本当に？[p]

#
記憶を取り戻した僕のその一言は、きっと今のヴロヒアに一番衝撃を与えた。[l][r]
だって僕は、ここが[font color="#ffd700"]天国[resetfont]ではないことを知っている。[p]

#

本当に。[l][r]
息子の言う事が信じられない？[p]

[chara_mod  name="Vrochia" face="wow3" ]
#ヴロヒア
息子…。[p]

#
ヴロヒアが呟いて、ようやっと視線が本当に交わった気がした。[p]

#ヴロヒア
しん、しんじます。[l][r]
[chara_mod  name="Vrochia" face="wow2" ]
私の、息子の言う事ですから…。[p]

#
そう言ってくれたことが嬉しくて、くすくすと笑いながら固いヴロヒアに抱き着く。[p]


#
ヴロヒアの罪も、悪行も、蛮行も何もかも。[l][r]
なにも、許されなくっていい。[p]

ヴロヒアが言葉を探すように手をさ迷わせる。[l][r]
それを待たずに、僕は笑って言ってやった。[p]

#
僕たち一緒に、立派な共犯者だ。[p]


; =============
;キャラクター非表示
#
[chara_hide name="Vrochia"]
[cm]
; 背景を
[bg storage="black.jpg" time=100]
; =============


ぎゅうっと力を込めて、変わらない身長には積み上げられなかった年月を思った。[p]
ヴロヒアの後悔も懺悔も、不安も贖罪も。[l][r]
そんなものは知ったことではないし、そもそも背負い過ぎだ。[p]

でも、その重荷を背負ってしまうのがヴロヒアなら、否定するよりももっと沢山の幸せでいっぱいになるといい。[p]
君の心臓にまとわりつくような絶望を、揺らぐことのない朝暉で溶かしてしまおう。[p]

許しが欲しいのなら与えてやりたかった。[p]
頬を伝う後悔の涙を拭ってやりたかった。[p]

幸せにしたいのだと手を引いてくれたその背中を、[l][r]
されるがままじゃなくて引き留めて抱きしめて、一緒に幸せになりたかった。[p]

君が願ったんじゃない。[l][r]
僕が願った。[p]

この、君から何もかもを奪い去っては底を知らない地獄を[l][r]
黎明を背に受けて一緒に笑いながら進んでいこう。[p]

; =============
; 背景をEDカードへ変更
[bg storage="SPtitle2.jpg" time=100]
; CG開け
[cg storage="SPtitle2.jpg"]
; =============
#
行こう、ヴロヒア！[p]
僕ってきっと、こうして君の手を引くために生まれてきたんだ！[p]



; ED0を見たというフラグ建て
[eval exp="sf.ending0_wo_mita = 1"]

; 背景をカードへ変更
[bg storage="SPtitle2.jpg" time=100]
; CG開け
[cg storage="SPtitle2.jpg"]

;手順書消す
[clearfix]

; メッセージウィンドウを消す
[layopt layer="message0" visible=false]
; ===================================縁どり画像表示===================================
;レイヤを表示
[layopt layer=1 visible=true page=fore]
;縁取り画像を表示
[image layer=1 storage="waku.png" x=0 y=0 zindex=50]
; =====================================================================================

[wait time=2000]

;memo
; エンディングロールへ
[jump storage="endroll.ks" target="*endroll_start"]

; タイトルに戻る
[font color="#ff1493"]クリックでtitleに戻ります。[resetfont][p]

; ===============
; メッセージウィンドウを消す
[layopt layer="message0" visible=false]
;タイトル画面へ移動
@jump storage="title.ks"
[s]
; ======================================================
; ===============既存シナリオにジャンプ=================
; ======================================================
*letter0_eat0
;letter_0_read.ks というシナリオファイルの *start ラベルへ移動する
[jump storage="letter_0_read.ks" target="*letter0_eat"]
[s]
;★★★★★★★★★★★★★★ストーリーおわり★★★★★★★★★★★★★★


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
; letter0_clauseFlgに1を入れる
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

;====================================================


[return]
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



;====手紙を読む１===============================================================

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

; Flgに0を入れる
[eval exp="f.letter0_clauseFlg= 0"]

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
[button fix=true layer=2 x="39" y="239"   auto_next="false" target="*close_letter" name="scroll_close" zindex=2 graphic="button/button_letter_close.png" enterimg="button/button_letter_close2.png"]

; リセットボタン
[button fix=true layer=2 x="1014" y="405" 0 auto_next="false"  name="button_reset" target="*scroll_reset" zindex=2 graphic="button/button_scroll_reset.png" enterimg="button/button_scroll_reset2.png"]



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

