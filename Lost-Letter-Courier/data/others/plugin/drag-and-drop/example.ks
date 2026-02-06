; ドラッグ&ドロップ プラグインを読み込む。
[plugin name="drag-and-drop"]

; ドラッグアイテムを操作したときの画像サイズや明るさ、マウスカーソルなどのスタイルを調整できる！
; ホバーしたとき/ドラッグしているとき/ドロップ可能になったとき/ドロップしたあとの明るさを調整してみる。
[dragitem_config enter_brightness="1.1" drag_brightness="1.2" droppable_brightness="1.4" drop_brightness="1"]

; ドラッグしているときの画像サイズをちょっと大きくしてみる。
[dragitem_config drag_scale="1.03"]

; ドラッグアイテムやドロップエリアに薄い背景色を付けてみる。
[dragitem_config dragitem_bg="#ffffff20"]

; ホバーしたとき/ドラッグしているときのマウスカーソルを設定してみる。
[dragitem_config enter_cursor="grab" drag_cursor="grabbing"]

; 画面の初期設定（プラグインとは関係ない）
[layopt layer="0" visible="true"]
[layopt layer="1" visible="true"]
[layopt layer="message0" visible="true"]
[position left="20" top="800" width="680" height="300" opacity="100"]
[position margint="30" marginl="30" marginr="30" marginb="30"]
[deffont size="30" bold="true" edge="1px #000000"]
[resetfont]
[glyph figure="circle" anim="soft_bounce" marginl="10"]
[configdelay speed="10"]
[resetdelay]
[stop_keyconfig]


*MENU

[position left="20" top="800" width="680" height="300" opacity="100"]
[layopt layer="message0" visible="true"]
[bg storage="shiwake_bg.png" time="300"]

; [jump target="*SAMPLE_GOMI"]
; [jump target="*SAMPLE_BOOK"]
; [jump target="*SAMPLE_1"]
; [jump target="*SAMPLE_2"]

ドラッグ＆ドロッププラグインの動作サンプルです。

[glink text="ゴミの仕分け" color="btn_20_red" target="*SAMPLE_GOMI"]
[glink text="本の並べ替え" color="btn_20_red" target="*SAMPLE_BOOK"]
[glink text="簡易サンプル1" color="btn_20_red" target="*SAMPLE_1"]
[glink text="簡易サンプル2" color="btn_20_red" target="*SAMPLE_2"]
[s]


;=============================================
; ゴミを所定のゴミ箱に仕分けするサンプルゲーム
;=============================================

*SAMPLE_GOMI

[position left="20" top="500" width="680" height="200" opacity="100"]
[bg storage="shiwake_bg.png" time="0"]

; ドロップエリア（ドラッグアイテムをドロップすることができる領域）を作成する。
; 初期画像（graphic）は閉じたゴミ箱の画像にする。
; ドロップ可能になったときの画像（droppableimg）は開いたゴミ箱の画像にする。
; 各ドロップエリアに異なる名前（name）を付けておく。
[droparea name="gomibako_moeru" left="20" top="800" graphic="shiwake_moeru_1.png" droppableimg="shiwake_moeru_2.png"]
[droparea name="gomibako_moenai" left="250" top="700" graphic="shiwake_moenai_1.png" droppableimg="shiwake_moenai_2.png"]
[droparea name="gomibako_recycle" left="480" top="800" graphic="shiwake_recycle_1.png" droppableimg="shiwake_recycle_2.png"]

; 1回テキストを読んでほしいのでドラッグ操作の受付を停止する。
[stop_draglayer]

; テキスト
ゴミ箱が3つある。左から〈燃えるゴミ〉〈燃えないゴミ〉〈リサイクルゴミ〉を入れるゴミ箱のようだ。[p]

; ドラッグアイテム（ドラッグ操作で移動させることが可能な画像）を作成する。
; ここでは魚の骨の画像を出している。
[dragitem name="gomi_sakana" left="300" top="300" graphic="gomi_namagomi.png" return="true" allow="gomibako_moeru" target="*SAMPLE_GOMI_2"]
; return=true … ドロップエリアの外でドラッグを終了した場合、もとの場所に戻る。
; target=*gomi_2 … ドロップエリアにドロップされたとき、ラベル*gomi_2にジャンプする。※ただしallowの制約を受ける。
; allow=gomibako_moeru … 「燃えるゴミ箱」へのドロップのみを許容する。それ以外へのドロップでは反応しなくなる。

; テキスト→メッセージウィンドウ消し。
これは……〈魚の骨〉だ。どの箱に入れればいいだろう？[p]
[layopt layer="message0" visible="false"]

; ドラッグ操作を有効にする。
[start_draglayer]

; 説明用の[ptext]を出してみる。
[ptext layer="0" name="memo" x="0" y="0" width="720" align="center" text="【魚の骨をタップして動かしてみよう】" bold="true" size="30" edge="2px 0x000000"]

; この説明用の[ptext]をname属性で指定してドラッガブルにすることもできる。
[dragitem name="memo"]

; ゲーム停止
[s]


; ----------------------
; 燃えるゴミ箱に魚の骨を入れた！
*SAMPLE_GOMI_2

; ドラッグ操作をいったん止める。
[stop_draglayer]

; 正解の効果音を鳴らす。
[playse storage="クイズ正解1.mp3"]

; 魚の画像とメモを消す
[free_dragitem time="500"]

; テキスト
[layopt layer="message0" visible="true"]
なるほど……魚の骨は燃えるゴミでいいのか。[p]

; ◆第2問
; ドラッグアイテムを5個出す！
; 今度はドロップしただけではシナリオジャンプしない
[dragitem name="gomi_pet" left="300" top="300" graphic="gomi_pet.png"]
[dragitem name="gomi_wood" left="510" top="340" graphic="gomi_wood.png"]
[dragitem name="gomi_cap" left="480" top="200" graphic="gomi_cap.png"]
[dragitem name="gomi_pan" left="160" top="210" graphic="gomi_pan.png"]
[dragitem name="gomi_kutsu" left="30" top="300" graphic="gomi_kutsu.png"]

むっ、こんどは5個もあるのか。大変だが、やってみよう。[p]

[ptext layer="0" name="memo" x="0" y="0" width="720" align="center" text="【ゴミを分別して「チェック！」を押そう】" bold="true" size="30" edge="2px 0x000000"]
[layopt layer="message0" visible="false"]

; チェックボタンを出す
[glink text="チェック！" x="200" y="1170" width="320"  color="btn_20_red" target="*SAMPLE_GOMI_2_CHECK"]

; ドラッグ操作を有効化
[start_draglayer]

; ゲーム停止
[s]


; ----------------------
; クリアチェック
*SAMPLE_GOMI_2_CHECK

; ゲーム変数を使ってクリア判定を行う
[iscript]
  // デフォルトでクリアにしておく
  f.clear = true
  // キャップがリサイクルゴミに分別されていなければダメ！
  // ペットボトルがリサイクルゴミに分別されていなければダメ！
  // …以下略…
  if (f.dragitem.gomi_cap   != "gomibako_recycle") f.clear = false
  if (f.dragitem.gomi_pet   != "gomibako_recycle") f.clear = false
  if (f.dragitem.gomi_pan   != "gomibako_moenai") f.clear = false
  if (f.dragitem.gomi_kutsu != "gomibako_moenai") f.clear = false
  if (f.dragitem.gomi_wood  != "gomibako_moeru") f.clear = false
[endscript]

; cond属性を使うことで分岐させる
; f.clearがtrueの場合のみクリア用のシナリオにジャンプする
[jump target="*SAMPLE_GOMI_2_CLEAR" cond="f.clear"]
[jump target="*SAMPLE_GOMI_2_MISS"]
[s]

; ----------------------
; クリアしていなかった
*SAMPLE_GOMI_2_MISS

[layopt layer="message0" visible="true"]
……違うらしい。[p]
[layopt layer="message0" visible="false"]
[glink text="チェック！" x="200" y="1170" width="320" color="btn_20_red" target="*SAMPLE_GOMI_2_CHECK" ]
[s]

; ----------------------
; クリアしていた！
*SAMPLE_GOMI_2_CLEAR

[layopt layer="message0" visible="true"]
……[p]
[playse storage="クイズ正解1.mp3"]
合ってるみたい！[p]
[layopt layer="message0" visible="false"]

; ドラッグレイヤーを空に
[free_draglayer time="500"]

[jump target="*MENU"]


;=============================================
; 本を特定の順番で並べ替えるサンプルゲーム
;=============================================

*SAMPLE_BOOK

[deffont face="serif"]
[resetfont]
[mask time="200"]
[bg storage="book_bg.png" time="0"]
[stop_draglayer]
[image layer="0" name="book_6" left="670" top="180" width="400" height="94" storage="../image/book_6.png"]
[image layer="0" name="kami" left="337" top="1096" storage="../image/book_kami.png"]
[image layer="1" left="0" top="0" width="720" height="1280" storage="dark.png" ]
[mask_off time="200"]
[start_keyconfig]
……いまからあなたに、5冊の本を並べてもらおう。[l]
それぞれのタイトルと著者は、次の通りだ。[p]

; ドラッグアイテムをひとつひとつ出していく
; dropout="false"を指定することでドロップエリア外に出すことができなくなる
; [stop_draglayer]が効いているのでまだ操作できない
[dragitem name="book_4" left="080" top="333" width="94" height="400" graphic="book_4.png" fit="true" return="true" dropout="false" time="500" wait="false"]
「頂点を目指して」（熊野ごろう著）[p]

[dragitem name="book_1" left="200" top="333" width="94" height="400" graphic="book_1.png" fit="true" return="true" dropout="false" time="500" wait="false"]
「木と草と花の詩」（日野いつき著）[p]

[dragitem name="book_5" left="320" top="333" width="94" height="400" graphic="book_5.png" fit="true" return="true" dropout="false" time="500" wait="false"]
「因数分解の全て」（森野きのこ著）[p]

[dragitem name="book_2" left="440" top="333" width="94" height="400" graphic="book_2.png" fit="true" return="true" dropout="false" time="500" wait="false"]
「精霊ニトを追う」（永見はねる著）[p]

[dragitem name="book_3" left="560" top="333" width="94" height="400" graphic="book_3.png" fit="true" return="true" dropout="false" time="500" wait="false"]
「うどんのレシピ」（赤井きつね著）[p]

以上の5冊だ。[l]これらの本を〈ある順番〉で並べることができたら、ゲームクリアーだ。[p]
うまく並べることができたと思ったら「チェック」するんだ。[p]
[stop_keyconfig]
[layopt layer="message0" visible="false"]
[freeimage layer="1" time="500"]

; 既存の画像をドラッグアイテムにする
; allow="xxx"のように存在しないドロップエリアを指定しておくことで何にも反応しなくなる
; ドラッグ移動することで画像の見えなかった部分が見えるようになりそれがヒントになるという仕掛けや、
; ドラッグ移動によって先ほどまで隠されていた部分が見えるようになりそれがヒントになるという仕掛けを作る
[dragitem name="book_6" return="true" allow="xxx"]
[dragitem name="kami" return="true" allow="xxx"]

; 既存のドラッグアイテムに合わせてドロップエリアを作成する
; copyareaに既存のドラッグアイテムを指定した場合、
; ドラッグアイテムが最初からこのドロップエリアに属している状態になる
[droparea name="area_1" copyarea="book_4" color="rgba(0,0,0,0.1)" oneonly="true"]
[droparea name="area_2" copyarea="book_1" color="rgba(0,0,0,0.1)" oneonly="true"]
[droparea name="area_3" copyarea="book_5" color="rgba(0,0,0,0.1)" oneonly="true"]
[droparea name="area_4" copyarea="book_2" color="rgba(0,0,0,0.1)" oneonly="true"]
[droparea name="area_5" copyarea="book_3" color="rgba(0,0,0,0.1)" oneonly="true"]

; 準備ができたのでドラッグ操作を有効にする
[start_draglayer]
[glink text="チェック！" x="200" y="840" width="320"  color="btn_20_red" target="*SAMPLE_BOOK_CHECK" ]
[s]

; ----------------------
; クリアしたかどうかをチェックする
*SAMPLE_BOOK_CHECK

[stop_draglayer]
[cm]
[layopt layer="message0" visible="true"]
[iscript]
  // ゲーム変数 f.clear - クリアしたかどうか？ true もしくは false　が入る
  f.clear = false

  // ドラッグアイテム book_1 が area_1 に属しており、かつ、
  // ドラッグアイテム book_2 が area_2 に属しており、かつ、
  // …
  // ドラッグアイテム book_5 が area_5 に属しているならば、
  if (f.dragitem.book_1 === "area_1" &&
    f.dragitem.book_2 === "area_2" &&
    f.dragitem.book_3 === "area_3" &&
    f.dragitem.book_4 === "area_4" &&
    f.dragitem.book_5 === "area_5") {
    // クリアしている！
    f.clear = true
  }
[endscript]
[jump target="*SAMPLE_BOOK_CLEAR" cond="f.clear"]
[jump target="*SAMPLE_BOOK_NO_CLEAR"]

; ----------------------
; クリアしていなかった
*SAMPLE_BOOK_NO_CLEAR

[cm]
……違う。[p]
[layopt layer="message0" visible="false"]
[start_draglayer]
[glink text="チェック！" x="200" y="840" width="320" color="btn_20_red" target="*SAMPLE_BOOK_CHECK" ]
[s]

; ----------------------
; クリアしていた！
*SAMPLE_BOOK_CLEAR

[fix_dragitem]
[fix_droparea]
[start_draglayer]
……。[p]
…………。[p]
[playse storage="クイズ正解1.mp3"]
そうだ！　それで正解だ！[p]
この並びは〈森の食物連鎖〉を表している。[p]
まず木や草などの〈生産者〉が太陽エネルギーをもとに栄養を作り、〈草食動物〉がそれを食べる。[p]
さらにそれを食べる〈小型の肉食動物〉、それを食べる〈大型の肉食動物〉と連鎖していき、最後にはキノコやバクテリアなどの〈分解者〉が死体を分解するんだ。[p]
5冊の本はそれぞれ、〈分解者〉や〈生産者〉などを表現していたわけだ。[p]
[layopt layer="message0" visible="false"]
[deffont face="sans-serif"]
[resetfont]
[free_draglayer time="500"]
[jump target="*MENU"]


;=============================================
; 簡易サンプル1
;=============================================

*SAMPLE_1

[mask time="300"]
[image name="wall" layer="0" storage="wall.png"]
[image name="door" left="-460" top="140" width="1100" height="1000" layer="0" storage="door_close.png"]
[layopt layer="message0" visible="true"]
[droparea name="kagiana" oneonly="true" left="400" top="590" width="150" graphic="kagiana.png"]
[mask_off time="300"]

; call="true"を指定することで、シナリオジャンプ時に[jump]ではなく[call]の挙動になる
; つまり、[return]で戻ってくるようになる
[dragitem name="kagi_a" time="100" call="true" target="*SAMPLE_1_MISS"  left="100" top="300" width="150" return="true" fit="true" graphic="kagi_a.png"]
[dragitem name="kagi_b" time="100" call="true" target="*SAMPLE_1_MISS"  left="300" top="300" width="150" return="true" fit="true" graphic="kagi_b.png"]
[dragitem name="kagi_c" time="100"             target="*SAMPLE_1_CLEAR" left="500" top="300" width="150" return="true" fit="true" graphic="kagi_c.png"]

カギを鍵穴にドラッグしてください。[l][cm]
カギをマウス（指）で動かしてみよう。[l][cm]
もう動かせるぞ。[l][cm]
動かしてみるぞ。[l][cm]
動かし中。[l][cm]
もう動かしてみた？[l][cm]
……動かしてみよう。[l][cm]

; ----------------------
; 失敗用
*SAMPLE_1_MISS

[playse storage="開かないドア1.mp3" ]
[cm]
……これじゃない。
[return]

; ----------------------
; 成功用
*SAMPLE_1_CLEAR

; ドラッグアイテム、ドロップエリアを共に固定化して0番レイヤーに移動させる
[fix_dragitem layer="0"]
[fix_droparea layer="0"]

; 演出
[playse storage="車の鍵を開ける.mp3" ]
[cm]
[layopt layer="message0" visible="true"]
ガチャリ……

; まず鍵A,Bを消す
[free layer="0" name="kagi_a" time="500" wait="false"]
[free layer="0" name="kagi_b" time="500"]
[wait time="500"]

; 鍵Cを消し、そのあとで鍵穴を消す
[free layer="0" name="kagi_c" time="500"]
[free layer="0" name="kagiana" time="500"]

カギが開いた。[p]
[layopt layer="message0" visible="false"]


; ----------------------
; 以下、演出。プラグインには直接関係ない
[playse storage="門を開ける.mp3" ]

; 0番レイヤーにパースを付ける
[iscript]
$(".0_fore").css({
  "perspective": "1000px",
  "transform-style": "preserve-3d",
})
[endscript]

; ドアが開かれるようなアニメーション
[keyframe name="open"]
  [frame p=0%   z="0" rotateY="0deg"]
  [frame p=100% z="0" rotateY="-90deg"]
[endkeyframe]
[kanim name="door" keyframe="open" time="2000"]
[hidemenubutton]
[wait time="500"]

; カメラズームで扉に入っていくような演出
[camera zoom="1.4" time="1000"]
[freeimage layer="0" time="0"]
[reset_camera time="1000"]
[showmenubutton]
[jump target="*MENU"]


;=============================================
; 簡易サンプル2
;=============================================

*SAMPLE_2

; ○、△、□のドラッグアイテム及びドロップエリアを出していく
; alpha="true"を指定することで不透明部分だけをドラッグ操作対象にできる

; ○は、画像変更や効果音再生を盛り込んでみた
[dragitem alpha="true" allow="ana_maru"    name="zukei_maru"    layer="0" left="90"  top="300" width="150" fit="true" graphic="zukei_maru.png" enterse="カーソル移動1.mp3" enterse="カーソル移動1.mp3" dragse="カーソル移動2.mp3" droppablese="カーソル移動3.mp3" dropse="カーソル移動4.mp3" leavese="カーソル移動5.mp3" enterimg="zukei_maru_enter.png" dragimg="zukei_maru_drag.png" droppableimg="zukei_maru_droppable.png" dropimg="zukei_maru_drop.png" droppedse="受話器を置く.mp3"]

; △は、JS式を実行してコンソールにログを出すようにしてみた
[dragitem alpha="true" allow="ana_shikaku" name="zukei_shikaku" layer="0" left="290" top="300" width="150" fit="true" graphic="zukei_shikaku.png" droppaleimg="zukei_shikaku_pa.png" dropimg="zukei_shikaku_shadow.png" dragexp="console.log(111)" draggingexp="console.log(222)" dragendexp="console.log(333)" dropse="受話器を置く.mp3"]

; □は、マウスカーソル画像を変えるようにしてみた
[dragitem alpha="true" entercursor="grab.png" dragcursor="grabbing.png" allow="ana_sankaku" name="zukei_sankaku" layer="0" left="490" top="300" width="150" fit="true" graphic="zukei_sankaku.png" droppaleimg="zukei_sankaku_pa.png" dropimg="zukei_sankaku_shadow.png" dropse="受話器を置く.mp3"]

[droparea oneonly="true" name="ana_sankaku" layer="0" left="90"  top="100" width="150" graphic="zukei_sankaku_gray.png"]
[droparea oneonly="true" name="ana_maru"    layer="0" left="290" top="100" width="150" graphic="zukei_maru_gray.png"]
[droparea oneonly="true" name="ana_shikaku" layer="0" left="490" top="100" width="150" graphic="zukei_shikaku_gray.png"]

[layopt layer="message0" visible="true"]
図形を正しい穴にはめ込んでください。
[glink x="290" y="530" color="btn_03_green" target="*SAMPLE_2_CHECK" text="チェック" ]
[s]

; ----------------------
*SAMPLE_2_CHECK

[iscript]
if (f.dragitem.zukei_maru    === "ana_maru" &&
    f.dragitem.zukei_shikaku === "ana_shikaku" &&
    f.dragitem.zukei_sankaku === "ana_sankaku") {
  f.clear = true
} else {
  f.clear = false
}
[endscript]
[jump target="*SAMPLE_2_CLEAR" cond="f.clear"]
[jump target="*SAMPLE_2_FAILURE"]

; ----------------------
; 失敗
*SAMPLE_2_FAILURE

[stop_draglayer]
[cm]
チェック中……[l]
[playse storage="クイズ不正解1.mp3"]
あってないよ！[p]
……もう一回挑戦してね。
[start_draglayer]
[glink x="290" y="530" color="btn_03_green" target="*SAMPLE_2_CHECK" text="チェック" ]
[s]

; ----------------------
; 成功
*SAMPLE_2_CLEAR

[stop_draglayer]
[cm]
チェック中……[l]
[playse storage="クイズ正解1.mp3"]
正解！[p]
[free_draglayer time="500"]
[freeimage layer="0" time="500"]
[start_draglayer]
[jump target="*MENU"]
