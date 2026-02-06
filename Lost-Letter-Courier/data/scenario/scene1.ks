;===================================
;シナリオ開始ラベル
*start
;===================================

; BGMのフェードアウト
[fadeoutbgm time=2000]
;メッセージウィンドウのクリア
[cm]
;レイヤの表示をクリア
[clearfix]
; layer=1 に表示した画像を消す
[freeimage layer=1]

;キー操作の初期設定をロード
[start_keyconfig]

;背景画像を切り替え
[bg storage="black.jpg"]

;メニューボタンの表示
@showmenubutton

;メッセージのカラー設定
[deffont color="black"]
[font color="black"]

;名前部分のメッセージレイヤ削除
[free name="chara_name_area" layer="message0"]

; ウィンドウ自体を画面いっぱいに広げる
[position layer="message0" width="1280" height="7200" top="0" left="0"]

; 文字の位置を以前と同じ余白で表示
[position layer="message0" frame="Frame/letterframe0.png" margint="570" marginl="100" marginr="100" marginb="230" opacity="230" page=fore]

;名前枠の設定
[ptext font="MyFont" name="chara_name_area" layer="message0" color="black" size="30" bold="true" x="100" y="540"]
[chara_config font="MyFont" ptext="chara_name_area"]

;メッセージウィンドウの表示
@layopt layer="message0" visible=true

;上記で定義した領域がキャラクターの名前表示であることを宣言（これがないと#の部分でエラーになります）
[chara_config ptext="chara_name_area"]

;このゲームで登場するキャラクターを宣言
;Vrochia
[chara_new  name="Vrochia" storage="chara/Vrochia/normal.png" jname="先輩"  ]
;キャラクターの表情登録
[chara_face name="Vrochia" face="angry" storage="chara/Vrochia/angry.png"]
[chara_face name="Vrochia" face="angry2" storage="chara/Vrochia/angry2.png"]
[chara_face name="Vrochia" face="angry3" storage="chara/Vrochia/angry3.png"]

[chara_face name="Vrochia" face="trouble" storage="chara/Vrochia/trouble.png"]
[chara_face name="Vrochia" face="trouble2" storage="chara/Vrochia/trouble2.png"]
[chara_face name="Vrochia" face="trouble3" storage="chara/Vrochia/trouble3.png"]

[chara_face name="Vrochia" face="happy" storage="chara/Vrochia/happy.png"]
[chara_face name="Vrochia" face="happy2" storage="chara/Vrochia/happy2.png"]

[chara_face name="Vrochia" face="wow" storage="chara/Vrochia/wow.png"]
[chara_face name="Vrochia" face="wow2" storage="chara/Vrochia/wow2.png"]
[chara_face name="Vrochia" face="wow3" storage="chara/Vrochia/wow3.png"]
[chara_face name="Vrochia" face="wow4" storage="chara/Vrochia/wow4.png"]

[chara_face name="Vrochia" face="sad" storage="chara/Vrochia/sad.png"]
[chara_face name="Vrochia" face="sad2" storage="chara/Vrochia/sad2.png"]
[chara_face name="Vrochia" face="sad3" storage="chara/Vrochia/sad3.png"]
[chara_face name="Vrochia" face="sad4" storage="chara/Vrochia/sad4.png"]

[chara_face name="Vrochia" face="sad6" storage="chara/Vrochia/sad6.png"]


[chara_face name="Vrochia" face="normal" storage="chara/Vrochia/normal.png"]
[chara_face name="Vrochia" face="normal2" storage="chara/Vrochia/normal2.png"]
[chara_face name="Vrochia" face="normal3" storage="chara/Vrochia/normal3.png"]
[chara_face name="Vrochia" face="normal4" storage="chara/Vrochia/normal4.png"]
[chara_face name="Vrochia" face="normal5" storage="chara/Vrochia/normal5.png"]


[chara_face name="Vrochia" face="mu" storage="chara/Vrochia/mu.png"]
[chara_face name="Vrochia" face="mu2" storage="chara/Vrochia/mu2.png"]
[chara_face name="Vrochia" face="mu3" storage="chara/Vrochia/mu3.png"]

[chara_face name="Vrochia" face="tere" storage="chara/Vrochia/tere.png"]
[chara_face name="Vrochia" face="tere2" storage="chara/Vrochia/tere2.png"]
[chara_face name="Vrochia" face="tere3" storage="chara/Vrochia/tere3.png"]

;===================================================================
;BGM再生の作成
*playmusic

;time でフェードイン再生
[fadeinbgm storage=mainBGM.mp3 loop=true time=2000 volume=40]

;===================================================================








;====================test================================
[cm]

本データはテストプレイ用です。[l][r]
無断転載・再配布はご遠慮ください。[p]

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















;===================================================================
;★ここから本編ゲームストーリー
;===================================================================
;===================================================================
; クリック待機
[l]
; ドアのノック音
[playse storage="doorknock_SE.mp3" volume=40 stop=false]
; 2秒待機（2000ミリ秒）
[wait time=2000]
; ドアの開閉音
[playse storage="door_SE.mp3" volume=40 stop=false]
; 2秒待機（2000ミリ秒）
[wait time=2000]
;===================================================================

;メッセージのカラー設定
[deffont color="black"]
[font color="black"]

……起きていますか？[p]
あれ、まだ…？[p]
でも、今度こそ本当に姿が安定してる……。[p]
また、駄目だった…？[p]

;====================
;背景画像を Main.jpg に切り替え、フェード時間は 100ms
[bg storage="Main_out.jpg" time="1000"]
; CG開け
[cg storage="Main_out.jpg"]

; ごそごそとした音
[playse storage="gasagoso_SE.mp3" volume=40 stop=false]
; 2秒待機（2000ミリ秒）
[wait time=2000]
;====================

; キャラクター（ヴロヒア）登場
; 画面左端からの絶対座標で表示（x=700pxの位置に表示）
[chara_show name="Vrochia" face="wow4" left="700"]

;====================
#
……。[p]

何かに呼ばれた気がして、意識が浮上する。[p]
ずっと前から知っていたような、ようやく初めて目が覚めたような不思議な感覚。[p]
導かれるままそっと目を開けた瞬間、眩しい光と目を奪われるほど綺麗な相貌が目の前に映し出された。[p]

……ぁ、っ誰？[p]

思わず驚いて口を開けると、掠れた声が自分の喉から吐き出される。[p]
[chara_mod  name="Vrochia" face="sad" ]
その言葉を聞いて、すぐに目の前の彼は何かを隠すように目を閉じた。[p]

[chara_mod  name="Vrochia" face="mu2" ]
…ああ。[l]そう、そうですか。[p]
……全て、忘れてしまったんですね。[p]
[chara_mod  name="Vrochia" face="sad2" ]
でも。[p]

[chara_mod  name="Vrochia" face="happy2" ]
そのまま物憂げな表情は鳴りを潜め、[l][r]
彼はなぜか、酷く嬉しそうな表情で口元を緩めた。[p]


#ヴロヒア
ヴロヒア、と言います。[l][r]
……よろしくお願いしますね。[p]

#
ヴロヒア……？[p]

告げられた名前を繰り返す。[l][r]
舌に馴染みは無いが、なぜか妙に聞き覚えがあった。[p]

#ヴロヒア
そう、きみの先輩兼保証人です。[p]

#
先輩兼、保証人…？[p]


子供のように何もわからないまま、同じ言葉を呟いて部屋を見渡す。[p]
ここは自宅では無いようで、デスクやファイルの管理された棚、[l][r]
それから威風を放つ大きな青いポストがあった。[p]

……ここ、郵便局？[p]

目に入ったポストに思わず首をかしげながら身を乗り出す。[p]
部屋の中にポストがあるなんて、おかしいはずなのに[l][r]
風景にどこかマッチしているのが不思議だった。[p]

[chara_mod  name="Vrochia" face="wow" ]
#ヴロヒア
おや、よく分かりましたね？[p]

[chara_mod  name="Vrochia" face="normal3" ]
#
ヴロヒアは面白そうに肩を竦めて笑う。[p]
彼の言葉は自分の呟きを肯定していて、思わず視線を戻してまじまじと見つめた。[p]
ヴロヒアは柔らかな顔で少し得意げに、機嫌よさげに頷く。[p]


[chara_mod  name="Vrochia" face="normal" ]
#ヴロヒア
確かにここは郵便局の、きみの自室です。[p]
少しだけ私も使っていたので、書類や本は私のものなんですけど……。[p]
ここは確かに、きみの部屋ですよ。[p]

#
僕の、部屋。[p]

わからない。[l][r]
何も覚えていなかった。[p]

#ヴロヒア
そして私はこの郵便局の配達屋さんで、きみも今日からその同僚です。[p]
よろしくお願いしますね、後輩さん。[p]

#
背筋がスッと伸びる気持ちになる。[l][r]
それと同時に真面目そうで大人っぽいヴロヒアだからこそ、彼のセリフの一つが妙に気になった。[p]

#
……ふ、[l]あははっ。[p]

こらえきれず笑い声をあげてしまい、ヴロヒアがきょとんと目を丸くする。[l][r]
でも、だって。[p]

[chara_mod  name="Vrochia" face="wow" ]
#ヴロヒア
……え、ど、どうしました？[p]

#
ふ、んん……、だ、だって、[l]配達屋さんって、ちょっと可愛い言い方だね。[p]

[chara_mod  name="Vrochia" face="wow2" ]
はっとした顔でヴロヒアが頬を赤くする。[p]
その一瞬で急にヴロヒアに親近感が湧いて、ぐんと好きになれた気がした。[p]

[chara_mod  name="Vrochia" face="angry3" ]
#ヴロヒア
…何も笑わなくても。[l][r]
間違ってないでしょう？[p]

#
そうだね。[p]

#ヴロヒア
……それなら配達人でいいですか？[p]

#
むくれた顔でヴロヒアがそういじけるので、笑って首を振った。[p]
だって、バカにしたわけではなくて、[l][r]
ただ意外と可愛い人なんだなって嬉しく思っただけだったのだ。[p]

#
配達屋さんでいいよ。[l]かわいくて、好きだけどな。[p]

微笑んでそう言ったのに、ヴロヒアは変わらずむっとした顔で肩を竦める。[p]

#ヴロヒア
配達人ですね。[l]…もう、聞いてましたか？[p]

#
ヴロヒアは強く語気を荒らげながらそう言うが、少しも怖くなかった。[p]
残念に思いながらも笑いを噛み殺しながら頷いて、改めてヴロヒアの格好を見る。[p]
確かに、配達人らしい格好だ。[p]

勿論、聞いてたよ。[p]

ヴロヒアはため息をついて、仕方なさげに笑った。[p]

[chara_mod  name="Vrochia" face="normal" ]
#ヴロヒア
とりあえずこの書類だけ、サインとハンコを貰えますか？[l][r]
ああ、ハンコはそれを。[p]
配達人になった証明のようなもので、必ず必要なんです。[p]
これでようやくきみも、一人前ですね。[p]

#
突然言われたことに覚えは無く、目を瞬く。[p]
郵便局のことも、配達人のことも、ヴロヒアのことも、[l][r]
何も、ちゃんと飲み込めていないのに。[p]
差し出された紙を呆然と見つめる。[p]


え、まって、待って…。[l][r]
その、何も覚えてないんだけど……、今日からなの？[p]

[chara_mod  name="Vrochia" face="tere3" ]
ヴロヒアは一瞬固まったが、ゆっくりとその質問には頷いた。[p]
逃げ場がなくなって言葉が詰まる。[p]

#
そう、なんだ…。[l][r]
でも、何も覚えてないのに…。[p]

[chara_mod  name="Vrochia" face="normal" ]
#ヴロヒア
ちゃんとまたイチから教えます。[l][r]
まずは、ね？[p]
こちらをお願いします。[p]

#
う、うん…。[p]

目の前のヴロヒアから少しの焦りと不安を感じて、思わず頷いてしまう。[p]
記憶はないはずなのに悪い感じはしなくて、[l][r]
彼が騙しているだとか、悪意があるとは思えず結局差し出された紙を受け取る。[p]


*name_input
;===================================================================
; 紙のめくる音
[playse storage="letter_SE.mp3" volume=40 stop=false]
;===================================================================

; 書類画像を表示
; 300ms
[image layer=1 storage="../image/Syounin_syorui.png" pcenter=true x=272 y=-5 time="300"]

; 1秒待機（1000ミリ秒）
[wait time=1000]

;=========================プレイヤーの名前入力==================
; プレイヤーの名前入力
; 名前入力フォーム表示
; 書類画像をレイヤー1に表示
; -----------------------------------------------------------------
; [edit] 入力欄を出します。
; [edit]：画面上にテキスト入力欄（フォーム）を表示します。
; name="f.player_name" によって、
; この入力欄の値は f.player_name（ゲーム変数）として扱われます。
; 表示中はシナリオの自動進行が止まり、
; フォームが消える（commit される）までは次のシナリオは進みません。
; -----------------------------------------------------------------


;もし名前が初期表示
[if exp="sf.yourName === undefined"]
[edit name="sf.player_name" left="700" top="150" width="160" height="30" size="30" maxchars="8" initial="" time="1000"]

[else]
[edit name="sf.player_name" left="700" top="150" width="160" height="30" size="30" maxchars="8" initial=&sf.yourName time="1000"]

[endif]


;------------------------------------------------------------
; 印鑑ドラッグ＆ドロップ
;------------------------------------------------------------
[dragitem graphic="../image/inkan.png" name="inkan" target="*NameComit" x=1050 y=580 allow="in_area" layer=2]
; -----------------------------------------------------------
;------------------------------------------------------------
; ドロップエリアを表示
;------------------------------------------------------------
[droparea name="in_area" left="867" top="158" width="89" height="99" alpha=150 target="*NameComit"]
; ドロップ待ち
[s]
;============================================================
;============================================================
; ボタンがクリックされるとここにジャンプします
*NameComit
; stampの音
[playse storage="stamp_SE.mp3" volume=40 stop=false]

; 1秒待機（1000ミリ秒）
[wait time=1000]


; ドロップしたドロップエリアを削除
[free_droparea name="in_area"]
; ドラッグアイテム（印鑑）も削除
[free_dragitem name="inkan"]

; ここで初めて入力欄の中身が name に指定した変数（sf.player_name）に確定。されます
[commit]
;ページの改ページ／メッセージレイヤのクリア。やフリー要素（フリー層）の解放を行うタグです
[cm]

;レイヤに表示していた画像を解放
[freeimage layer=1]
[freeimage layer=2]
;============================================================================

; 名前を絶対に忘れないマン
[eval exp="sf.yourName = sf.player_name"]

;======================
;もし名前が空欄だったら
[if exp="sf.yourName == ''"]
[chara_mod  name="Vrochia" face="normal" ]
[p]
#ヴロヒア
…あれ、書けてないですよ。[p]
もう一回お願いします。[p]
[jump target="*name_input"]
[endif]
;======================

;===================================================================
;★ここからゲームストーリー再開
;===================================================================


[if exp="sf.yourName !== 'アナト'"]
#ヴロヒア
はい、ありがとうございます。[p]
[chara_mod  name="Vrochia" face="wow" ]
提出しておきますね……って、あれ？[p]

#
ヴロヒアが、渡した書類を呆然と見つめる。[p]

#
どうしたの？[p]

[chara_mod  name="Vrochia" face="sad" ]
#ヴロヒア
…ああ、いえ。[p]
そうですか。[p]
[chara_mod  name="Vrochia" face="normal" ]
名前、[emb exp="sf.yourName"]って言うんですね。[p]


#
そう言えば確かに、なんの記憶もないのに自分の名前だけはするすると書けた。[l][r]
書いた時は不安なんてなかったのに、あらためて言われると間違っていたかもしれないと落ち着かない気分になる。[p]

#
…間違ってた？[p]

#ヴロヒア
いいえ。[l]素敵な名前だと思います。[p]
[chara_mod  name="Vrochia" face="normal3" ]
[emb exp="sf.yourName"]、よろしくお願いしますね。[p]

#
優しい言葉に頷く。[l][r]
ヴロヒアに名前を呼ばれると、どこかくすぐったい気持ちが胸をなぞった。[p]

[else]
[chara_mod  name="Vrochia" face="normal3" ]
#ヴロヒア
はい、ありがとうございます。[p]
[chara_mod  name="Vrochia" face="normal3" ]
……[emb exp="sf.yourName"]、よろしくお願いしますね。[p]
#
優しい言葉に頷く。[l][r]
ヴロヒアに名前を呼ばれると、どこかくすぐったい気持ちが胸をなぞった。[p]

[endif]


[chara_mod  name="Vrochia" face="normal" ]
#ヴロヒア
ええと、どこまで話したかな。[l][r]
……ああ、ここでは一人一部屋用意されていて部屋には必ずポストがあるんです。[p]
このポストはあなた専用のものですよ。[p]

#
部屋でひと際目を引くポストを見る。[p]
それは上に投函口の無い不思議な青いポストだった。[p]

#
手紙はどこから入れるの？[p]

#ヴロヒア
勝手に落ちてくるんです。[p]

#
勝手に、落ちてくる？？[p]

#
そんなバカな、と一瞬思ったが自分が覚えていないだけでそれが普通だったりするのかもしれない。[p]
ポストをよくよく見てみるが、投函口が無い以外は特徴がないように見えた。[p]

#ヴロヒア
ふふ、はい。[l][r]
ここは特別な郵便局なんですよ。[p]
このポストはどこからともなく、[l][r]
落とされたり忘れられたりした手紙を勝手に拾って来るんです。[p]

#
……落とし物みたいに？[p]

#ヴロヒア
ああ、うまいことを言う。[l][r]
そうですね、そんな感じです。[p]

[chara_mod  name="Vrochia" face="happy2" ]
……開けてみますか？[l][r]
あなたの今日の、初仕事ですね。[p]

#
; 選択
[link target="*post_open"][mark color="0xff7f50" size=70]ポストを開ける[endmark][endlink]
[s]

;===================================================================
*post_open

[cm]
#
……。[p]
;================
[playse storage="asi_SE.mp3" volume=40 stop=false]
; 1.5秒待機
[wait time=1500]
; SE を停止
[stopse name="asi_SE.mp3"]
;================
; ごそごそとした音
[playse storage="gasagoso_SE.mp3" volume=40 stop=false]
; 2秒待機（2000ミリ秒）
[wait time=2000]
[wt]
;============
;===================================================================
; 手紙を広げる音
[playse storage="letters_SE.mp3" volume=40 stop=false]
;===================================================================
;===================================================================
; 机の上に5通の手紙の画像
;背景画像を Main_tegami5.jpg に切り替え、フェード時間は 100ms
[bg storage="Main_tegami5.jpg" time="100"]

;===================================================================



[chara_mod  name="Vrochia" face="normal" ]
#ヴロヒア
今日きみのポストが拾った手紙は……。[p]

ああ、多くもなく少なくもなく……。[p]
でもこれなら手紙は二通ほど届けて終わった方がよさそうですかね。[p]

#
ヴロヒアはそう言うが、テーブルには二通以上手紙があった。[p]

#
…二通だけ？[l][r]
全部届けに行かないの？[p]

#
そもそも思ったよりも数が少なくて驚いたのに、その中からも更に減らすらしい。[p]
どう考えても全部配達した方がよさそうだったが、[l][r]
ヴロヒアは思ってもみないことを聞かれたように目を瞬いた。[p]

[chara_mod  name="Vrochia" face="wow" ]
#ヴロヒア
え？[l]ああ……そうですね。[p]
[chara_mod  name="Vrochia" face="normal" ]
ええと、バランスが大事なんです。[p]
手紙を配達するのには特殊な力が必要で……。[l][r]
初めての今のきみなら、おそらくそれくらいが限度かと。[p]

#ヴロヒア
……手紙の中身でどれを配達するか決めていいので、[l][r]
後悔しないように吟味したらいいと思いますよ。[p]

#
不思議なポストに続いての不思議な力の存在に、どこか現実味が湧かない。[l][r]
自分にそんな力が、と納得しかけたところで再度「え？」と疑問が首をもたげた。[p]

#
えっ、読む？[l][r]
人の手紙なのに、読んでいいの？[p]

[chara_mod  name="Vrochia" face="happy" ]
#ヴロヒア
あははっ、そう、いいんですよ。[l][r]
ある意味私たちの特権ですね。[p]

#
ヴロヒアがおかしそうに、明け透けに笑う。[p]

[chara_mod  name="Vrochia" face="normal" ]
#ヴロヒア
っと言うか、見るのも仕事のうちと言いますか。[l][r]
私たち、配達人でもあり検閲官でもあるので、むしろちゃんと読んでください。[p]

それでようやく、宛先に届けることが出来るんです。[p]
そもそも拾われる手紙って宛先人や差出人が不明なことが多いんですよね。[p]

#
そんな手紙、どうやって…？[p]

[chara_mod  name="Vrochia" face="happy" ]
#ヴロヒア
そのための検閲なんです。[p]
[chara_mod  name="Vrochia" face="normal2" ]
私たちが手紙を読むと、どういう理屈かはともかく、[l][r]
あの扉が勝手に宛先の場所を探してくれるんです。[p]

#
言われて部屋の正面にある扉に目を向ける。[p]
なんの変哲もないようなあの扉が、途端に不思議なものに見えた。[p]

[chara_mod  name="Vrochia" face="normal" ]
#ヴロヒア
それともう一つ、限られた数しか届けられない手紙を、選別する意味合いもあります。[p]
例えば…、届けない方がいい手紙だってあるんです。[l][r]
それで、そういう手紙を私たちが消費して、また別の手紙を届けます。[p]

#
消費…？[l]人の、手紙を？[p]

#ヴロヒア
ええ、仕方ありません。[l][r]
私たちのその力は手紙から補給できるので。[p]
[chara_mod  name="Vrochia" face="angry2" ]
逆に配達なんてせずに、全部消費することもできるんですけど…。[p]

#
全てを聞く前に首を振る。[p]


[chara_mod  name="Vrochia" face="mu2" ]
#
それは、でも。[l][r]
手紙を書いた人にも待ってる人にも申し訳ない気がするから。[p]

#
文字にして、封に収めて。[l][r]
きっとそこには届けたい確かな思いがあったはずで。[p]

[chara_mod  name="Vrochia" face="happy2" ]
#ヴロヒア
……うん、そう言ってくれて、本当によかった。[p]

#
はにかんだヴロヒアにほっとして息を吐く。[l][r]
同じ気持ちらしいのが嬉しかった。[p]

#ヴロヒア
[chara_mod  name="Vrochia" face="normal" ]
…さて、大体説明し終わりましたが、大丈夫そうですか？[p]

#
これまでの怒涛の説明を思い出しながらヴロヒアの言葉に頷きかけて、止まった。[p]
そういえば、自分の記憶がすっかりなくなっていることを思い出したのだ。[p]

#
…少し不安だから、何かにメモをしてもいい？[p]

[chara_mod  name="Vrochia" face="normal5" ]
#ヴロヒア
メモ？[p]
いいですけど、[l]
[chara_mod  name="Vrochia" face="normal" ]
……ああ、それならこれを使って。[p]

#
差し出されたのは一冊のメモ帳だった。[l][r]
黒のカバーにさっき押したハンコのイラストが描かれている。[p]

#
…これ、いいの？[p]

[chara_mod  name="Vrochia" face="happy" ]
#ヴロヒア
使おうと思って用意したんですが、機会が無くて…。[p]
せっかくなので遠慮なくどうぞ。[p]

#
ん…うん。ありがとう。[p]

#
メモ帳を差し出したヴロヒアの顔が思ったよりも嬉しそうで、言葉が詰まりかけながらも礼を言う。[l][r]
差し出されたペンに急かされながら机に向かって、さっそくメモを取る。[p]

;何かのEDを見た場合
[if exp="sf.ending1_wo_mita == 1 || sf.ending2_wo_mita == 1 || sf.ending3_wo_mita == 1 || sf.ending4_wo_mita == 1 || sf.ending5_wo_mita == 1 || sf.ending6_wo_mita == 1 || sf.ending7_wo_mita == 1"]
#
……？[p]
[endif]



[cm]

;===============手順書を書く====================

; ペンの音
[playse storage="pen_SE.mp3" volume=40 stop=false]

; 2秒待機
[wait time=2000]

;===============手順書ボタン操作====================
; 手帳ボタンを配置（常に表示）
[button fix="true" target="*show_manual" x="40" y="35" graphic="button/button_manual1.png" enterimg="button/button_manual2.png" auto_next=false  time="1000" name="manual_btn"]
;====================================================

[chara_mod  name="Vrochia" face="normal3" ]
#ヴロヒア
…ん、よし。[l][r]
それじゃあ、私は一通だけきみのお守りをして自分の仕事に戻りましょうか。[p]

#
えっ。[p]

#
お守りという言葉も気になったが、それよりもヴロヒアがどこかに行ってしまうことに驚いて声を上げる。[l][r]
なぜか彼はずっとそばにいるものだと思っていたのだ。[p]
ヴロヒアは苦笑して嬉し気に頬をかいた。[p]

[chara_mod  name="Vrochia" face="trouble" ]
#ヴロヒア
……んん、そんな顔しても、私にも自分の仕事があるので…。[l][r]
一通だけは一緒に読んであげますから。[p]
…ほら、どれを読むんですか。[p]


;====================================================
; 画面を1秒で黒フェードアウトしたい
;暗転開始
[mask effect="fadeInDownBig" time=1000]
;キャラクター非表示
#
[chara_hide name="Vrochia"]

[jump storage="letter_0.ks" time=100]

;====================================================



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

;メッセージの解放
[start_keyconfig]

[return]
;============================================================================
[s]
