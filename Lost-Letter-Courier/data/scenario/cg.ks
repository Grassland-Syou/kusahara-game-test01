;=========================================
; CG モード　画面作成
;=========================================

;@layopt layer=message0 visible=false

[freeimage layer=1]


@clearfix
[hidemenubutton]
[cm]

[bg storage="../../tyrano/images/system/bg_base_cg.png" time=100]
[layopt layer=1 visible=true]

[image layer=1 left=0 top=0 storage="config/label_cg.png" folder="image" ]

[iscript]
    
    tf.page = 0;
    tf.selected_cg_image = ""; //選択されたCGを一時的に保管
    
[endscript]



*cgpage
[layopt layer=1 visible=true]

[cm]
[button graphic="config/menu_button_close.png" enterimg="config/menu_button_close2.png"  target="*backtitle" x=1150 y=30 ]

[iscript]
    tf.tmp_index = 0;
    tf.cg_index = 12 * tf.page;
    tf.top = 100;
    tf.left = 60;
    
[endscript]

[iscript]
	tf.target_page = "page_"+tf.page;
[endscript]

*cgview
@jump target=&tf.target_page

*page_0
; y200  １段目-------------------
[cg_image_button graphic="title.jpg" no_graphic="../../tyrano/images/system/noimage.png" x=115 y=200 width=160 folder="bgimage" ]
[cg_image_button graphic="SPtitle.jpg" no_graphic="../../tyrano/images/system/noimage.png" x=370 y=200 width=160 folder="bgimage" ]

[cg_image_button graphic="title2.jpg" no_graphic="../../tyrano/images/system/noimage.png" x=615 y=200 width=160 folder="bgimage" ]
[cg_image_button graphic="SPtitle2.jpg" no_graphic="../../tyrano/images/system/noimage.png" x=850 y=200 width=160 folder="bgimage" ]
; -------------------------------

; y200  ２段目-------------------
[cg_image_button graphic="Main_out.jpg" no_graphic="../../tyrano/images/system/noimage.png" x=150 y=360 width=160 folder="bgimage" ]
[cg_image_button graphic="table.jpg" no_graphic="../../tyrano/images/system/noimage.png" x=405 y=360 width=160 folder="bgimage" ]

; それぞれのEDで解放
[cg_image_button graphic="ED3.jpg" no_graphic="../../tyrano/images/system/noimage.png" x=650 y=360 width=160 folder="bgimage" ]
[cg_image_button graphic="ED4.jpg" no_graphic="../../tyrano/images/system/noimage.png" x=885 y=360 width=160 folder="bgimage" ]
; -------------------------------

; y510  3段目-------------------
[cg_image_button graphic="ED5.jpg" no_graphic="../../tyrano/images/system/noimage.png" x=110 y=510 width=160 folder="bgimage" ]
[cg_image_button graphic="ED6.jpg" no_graphic="../../tyrano/images/system/noimage.png" x=365 y=510 width=160 folder="bgimage" ]
[cg_image_button graphic="ED7_NOMALEND.jpg" no_graphic="../../tyrano/images/system/noimage.png" x=610 y=510 width=160 folder="bgimage" ]

; 真ED後のTankYOUで解放
[cg_image_button graphic="Vrochia.jpg" no_graphic="../../tyrano/images/system/noimage.png" x=845 y=510 width=160 folder="bgimage" ]





@jump target="*common"

*common


*endpage



[s]

*backtitle
[cm]
[freeimage layer=1]
@jump storage=title.ks

*nextpage
[emb exp="tf.page++;"]
@jump target="*cgpage"


*backpage
[emb exp="tf.page--;"]
@jump target="*cgpage"

*clickcg
[cm]

[layopt layer=1 visible=false]

[eval exp="tf.cg_index=0"]

*cg_next_image

[image storage=&tf.selected_cg_image[tf.cg_index] folder="bgimage"  ]
[l]
[bg storage="../../tyrano/images/system/bg_base_cg.png" time=10]

[eval exp="tf.cg_index++"]

@jump target="cg_next_image" cond="tf.selected_cg_image.length > tf.cg_index"


@jump  target=*cgpage
[s]

*no_image

@jump  target=*cgpage



