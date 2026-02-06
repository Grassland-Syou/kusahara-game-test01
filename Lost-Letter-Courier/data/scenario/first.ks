
;-----------------------------------
;一番最初に呼び出されるファイル
;-----------------------------------
[title name="落とし手紙配達人"]
;-----------------------------------------------------------------
[hidemenubutton]


;ゲーム開始時にデフォルトのキー操作設定を停止
;不要なキー操作やショートカットを無効にする
[stop_keyconfig]

;ティラノスクリプトが標準で用意している便利なライブラリ群
;コンフィグ、CG、回想モードを使う場合は必須
@call storage="tyrano.ks"

; CSSファイル(フォント)を読み込む
[deffont size=28 face=MyFont bold=true][resetfont]

; ドラッグ＆ドロッププラグインの読み込み
[plugin name="drag-and-drop"]


;ゲームで必ず必要な初期化処理はこのファイルに記述するのがオススメ

;メッセージのカラー設定
[deffont color="black"]
[font color="black"]

;メッセージボックスは非表示
@layopt layer="message" visible=false

; letter_totalに0を入れる
; 初期値
[eval exp="f.letter_total = 0"]

;-----------------------------------------------------------------
; endingを見た
; 初期値
[if exp="isundefined(sf.ending0_wo_mita)" ]
[eval exp="sf.ending0_wo_mita = 0"]
[endif]

[if exp="isundefined(sf.ending1_wo_mita)" ]
[eval exp="sf.ending1_wo_mita = 0"]
[endif]

[if exp="isundefined(sf.ending2_wo_mita)" ]
[eval exp="sf.ending2_wo_mita = 0"]
[endif]

[if exp="isundefined(sf.ending3_wo_mita)" ]
[eval exp="sf.ending3_wo_mita = 0"]
[endif]

[if exp="isundefined(sf.ending4_wo_mita)" ]
[eval exp="sf.ending4_wo_mita = 0"]
[endif]

[if exp="isundefined(sf.ending5_wo_mita)" ]
[eval exp="sf.ending5_wo_mita = 0"]
[endif]

[if exp="isundefined(sf.ending6_wo_mita)" ]
[eval exp="sf.ending6_wo_mita = 0"]
[endif]

[if exp="isundefined(sf.ending7_wo_mita)" ]
[eval exp="sf.ending7_wo_mita = 0"]
[endif]
;-----------------------------------------------------------------



;タイトル画面へ移動
@jump storage="title.ks"

[s]


