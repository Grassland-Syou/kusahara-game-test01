'use strict'
  ; ((TG) => {


    // 多重読み込みの禁止
    if (TG.stat.plugin_draggable !== undefined) {
      return;
    }

    // V515betaのメソッドを搭載していない場合はプラグイン使用不可
    if (!(typeof TG.on === 'function' && typeof TG.base.convertPageXYIntoGameXY === 'function')) {
      alert('ドラッガブルプラグインを使うにはティラノスクリプトV515以上が必要です。');
      return;
    }

    /**
     * フリーレイヤーをクローンしてドラッグレイヤーを作成する
     */
    let j_free_layer = TG.layer.getFreeLayer();
    let j_dg_layer = j_free_layer.clone();
    j_free_layer.after(j_dg_layer);
    j_dg_layer
      .empty()
      .css("z-index", "1000000")
      .css("display", "block")
      .css("pointer-events", "none")
      .removeAttr("data-parent-layer")
      .removeAttr("class")
      .attr("id", "layer_draggable")
      .addClass("drag-enabled");

    // このままではドラッグレイヤーはセーブロード時に無視されてしまう
    // ドラッグレイヤーもセーブロードの対象にしてほしいので
    // 「セーブの直前にフリーレイヤーの中に移してセーブが終わったらもとに戻す」処理を仕込む
    TG.on("snapsave-start", () => {
      j_free_layer.append(j_dg_layer);
    });
    TG.on("snapsave-complete", () => {
      j_free_layer.after(j_dg_layer);
    });

    // 併せてロード時には「フリーレイヤーの中のドラッグレイヤーを取り出す」処理を仕込む
    // セーブロードによってDOMが破壊されているためインスタンスを更新する必要がある点に注意
    TG.on("load-beforemaking", () => {
      j_dg_layer.remove();
      j_free_layer = TG.layer.getFreeLayer();
      j_dg_layer = $("#layer_draggable");
      j_free_layer.after(j_dg_layer);
    });

    // const DROPPABLE_Z_INDEX = 100
    // const DRAGGABLE_Z_INDEX = 10000
    const DEFAULT_SENSITIVITY = 0.85;
    const CLASS_DRAGGABLE = 'tyrano-dragitem'; // ドラッグ可能な要素
    const CLASS_DROPPABLE = 'tyrano-droparea'; // ドロップエリアとなる要素
    const CLASS_DRAGGING = 'tyrano-dragging'; // ドラッグ中の要素
    const CLASS_HOVERING = 'tyrano-hovering'; // ホバー中の要素
    const CLASS_DROPPING = 'tyrano-droppable'; // ドロップ待機中の要素
    const CLASS_DROPPED = 'tyrano-dropped'; // ドロップ済みの要素
    const SELECTOR_DRAGGABLE = '.' + CLASS_DRAGGABLE;
    const SELECTOR_DROPPABLE = '.' + CLASS_DROPPABLE;
    const SELECTOR_DRAGGING = '.' + CLASS_DRAGGING;
    const SELECTOR_HOVERING = '.' + CLASS_HOVERING;
    const SELECTOR_DROPPING = '.' + CLASS_DROPPING;
    const SELECTOR_DROPPED = '.' + CLASS_DROPPED;
    const F_NAME_DRAGITEM = 'dragitem'; // ゲーム変数の名前
    const F_NAME_DROPAREA = 'droparea'; // ゲーム変数の名前



    /**
     * デバッグ用のログを出力する。
     * @param  {...any} args
     */
    const log = (...args) => {
      if (location && location.hostname === "127.0.0.1") {
        console.log(...args);
      }
    };



    /**
     * プラグインの情報を格納する領域
     */
    TG.stat.plugin_draggable = {
      css_map: {},
    };

    /**
     * ゲーム変数に領域を作成
     */
    TG.stat.f[F_NAME_DRAGITEM] = {};
    TG.stat.f[F_NAME_DROPAREA] = {};



    /**
     * ある関数を次のアニメーションフレームのタイミングで実行するように予約する。
     * 予約は「上書き」制であり、次のアニメーションフレームが来るまでの間に
     * 同一のtimer_objが渡されたdelay()が複数回実行された場合、最後の予約だけが有効になる。
     * つまり、
     *
     *   const obj = {}
     *   delay(() => { console.warn("1") }, obj)
     *   delay(() => { console.warn("2") }, obj)
     *
     * この場合はコンソールに 2 だけが出力される。
     * @param {function} callback 遅延実行する関数
     * @param {Object} timer_obj タイマーID管理用のオブジェクト
     * @param {string} [timer_name] タイマーID管理用のオブジェクトのプロパティ名
     */
    // const delay = (callback, timer_obj, timer_name = '__draggable_timer_id') => {
    //   // 前回の予約を取り消す
    //   cancelAnimationFrame(timer_obj[timer_name]);
    //   // 新しく予約する
    //   timer_obj[timer_name] = requestAnimationFrame(callback);
    // };
    const delay = (callback) => {
      callback();
    };



    /**
     * CSSを管理するクラス
     */
    const css_manager = {
      /**
       * 追加した <style> 要素の jQuery オブジェクト
       * @type {jQuery}
       */
      j_style: null,

      /**
       * ティラノスクリプトのステータス上の css_map を取得して返す
       * @type {Object}
       */
      get css_map() {
        return TG.stat.plugin_draggable.css_map;
      },

      /**
       * 初期化用
       */
      init() {
        this.j_style = $('<style id="tyrano_plugin_draggable" />').appendTo('body');
        this.addRule("#layer_draggable.drag-enabled *", {
          "pointer-events": "auto",
        });
        this.__rewriteCSS();
        TG.on('load:complete', () => {
          this.__rewriteCSS();
        });
      },

      /**
       * css_map にルールを追加する
       * @param {string} selector
       * @param {Object} style
       * @example
       * css_manager.addRule('.hoge', { position: 'absolute', margin: 'auto' })
       */
      addRule(selector, style) {
        if (!this.css_map[selector]) {
          this.css_map[selector] = {};
        }
        for (const key in style) {
          this.css_map[selector][key] = style[key];
        }
        this.rewriteCSS();
      },

      /**
       * 現在の css_map に従って <style> の textContent を書き変える
       * ただしこの関数自体は __rewriteCSS() を次のアニメーションフレームに予約するだけ
       * 数ミリ秒のあいだに連続してCSSが書き変えられることがありうる場合
       * 律儀に毎回CSSを書き変えるよりも次のアニメーションフレームで一度だけCSSを書き変えるほうがベターな設計と思われる
       */
      rewriteCSS() {
        delay(() => {
          this.__rewriteCSS();
        }, this);
      },

      /**
       * 現在の css_map に従って <style> の textContent を書き変える
       */
      __rewriteCSS() {
        let css_text = '';
        let selectors = Object.keys(this.css_map);
        const weight_map = {};
        weight_map["." + CLASS_DROPPABLE] = 1;
        weight_map["." + CLASS_DRAGGABLE] = 1;
        weight_map["." + CLASS_DRAGGING] = 2;
        weight_map["." + CLASS_DROPPING] = 3;
        weight_map["." + CLASS_DROPPED] = 4;
        selectors.sort((a, b) => {
          const a_weight = weight_map[a] || 1;
          const b_weight = weight_map[b] || 1;
          return (a_weight > b_weight) ? 1 : -1;
        });
        selectors.forEach(selector => {
          css_text += selector + '{';
          const style_map = this.css_map[selector];
          for (const prop in style_map) {
            const value = style_map[prop];
            css_text += `${prop}:${value};`;
          }
          css_text += '}';
        });
        this.j_style.text(css_text);
      },
    };



    // 初期化
    css_manager.init();



    /**
     * ポインター関連のイベントリスナをセットする関数
     * ポインターの座標を"ティラノスクリプト上の座標"に変換した情報を event に付加してコールバックに流す
     * @param {Element} elm
     * @param {string} name
     * @param {function} callback
     */
    function setPointerEvent(elm, event_name, callback) {
      event_name.split(' ').forEach((name) => {
        elm.addEventListener(name, (event) => {
          // pageX, pageY をティラノスクリプト上の座標に変換する
          const { x, y } = TYRANO.kag.base.convertPageXYIntoGameXY(event.pageX, event.pageY);
          const css = $(elm).css(['left', 'top']);
          const elm_x = parseFloat(css.left);
          const elm_y = parseFloat(css.top);
          event.tyranoX = x;
          event.tyranoY = y;
          // さらに要素上の offsetX, offsetY も計算しておく
          event.tyranoOffsetX = x - elm_x;
          event.tyranoOffsetY = y - elm_y;
          // コールバックに流す
          callback(event);
        });
      });
    }



    /**
     * ドラッグに関連する情報を管理するオブジェクト
     */
    const pointer_data = {
      dragitem: null, // いまドラッグしている Element（なければ null）
      droparea: null, // いまドラッグしている Element のドロップ先となる Element（なければ null）
      hoveritem: null, // いまホバーしている Element（なければ null）
      offset_x: 0, // Element の左上を基準とする、ドラッグを開始した瞬間のマウスの x 座標
      offset_y: 0, // Element の左上を基準とする、ドラッグを開始した瞬間のマウスの y 座標



      /**
       * ドラッグ中の要素を更新する。
       * @param {Element|null} dragitem
       */
      setDragElm(dragitem) {
        pointer_data.dragitem = dragitem;
      },



      /**
       * ホバー中の要素を更新する。
       * 律儀にmousemoveの度に実行する必要はないので、
       * 次のアニメーションフレームのタイミングで実行するようにする。
       * @param {Element|null} dragitem
       */
      setHoverElm(dragitem) {
        delay(
          () => {
            // いまセットされている値と同じものを代入しようとしているなら無視
            if (pointer_data.hoveritem === dragitem) {
              return;
            }

            // 値の更新が発生することが確定
            // いまなんらかの Element をホバーしている最中ならその要素の leave を呼ぶ
            if (pointer_data.hoveritem) {
              pointer_data.hoveritem.__onMouseLeave();
            }

            // 値を更新する
            // 新しい値が Element なら enter を呼ぶ
            pointer_data.hoveritem = dragitem;
            if (dragitem) {
              dragitem.__onMouseEnter();
            }
          },
          this,
          '__hover_timer',
        );
      },



      /**
       * いまドラッグしている要素のドロップエリアを更新する。
       * @param {Element|null} droparea
       */
      setDropArea(droparea) {
        delay(
          () => {
            // いまセットされている値と同じものを代入しようとしているなら無視
            if (pointer_data.droparea === droparea) {
              return;
            }

            // 値の更新が発生することが確定
            // いまなんらかの Element がドロップ対象になっているならその要素の leave を呼ぶ
            if (pointer_data.droparea) {
              log("setDropArea(): ドロップ対象からの脱出を検出");
              pointer_data.droparea.__onItemLeave();
            }

            // 値を更新する
            // 新しい値が Element なら enter を呼ぶ
            pointer_data.droparea = droparea;
            if (droparea) {
              log("setDropArea(): ドロップ対象への侵入を検出");
              droparea.__onItemEnter();
            }

            // droppableクラスを付与または除去する
            if (pointer_data.dragitem) {
              const dragitem = pointer_data.dragitem;
              if (droparea) {
                log("setDropArea(): ドロップ可能になった");
                dragitem.classList.add(CLASS_DROPPING);
                if (dragitem.__pm.droppableimg) {
                  playSound(dragitem.__pm.droppablese);
                  dragitem.__before_droppableimg = dragitem.getAttribute("src");
                  dragitem.setAttribute("src", dragitem.__pm.droppableimg);
                }
              } else {
                log("setDropArea(): ドロップ不可能になった");
                dragitem.classList.remove(CLASS_DROPPING);
                if (dragitem.__before_droppableimg) {
                  dragitem.setAttribute("src", dragitem.__before_droppableimg);
                }
              }
            }
          },
          this,
          '__drop_timer',
        );
      },
    };



    /**
     * ある要素上の座標x, yが不透明部分ならtrueを返す。
     * @param {Element} dragitem
     * @param {number} x 要素の左上を基準とする x 座標（小数点数でありうる）
     * @param {number} y 要素の左上を基準とする y 座標（小数点数でありうる）
     * @returns {boolean}
     */
    const isHereOpaque = (dragitem, x, y) => {
      // 指定座標が要素よりも左または上方向に飛び出ているなら不透明部分どころの騒ぎではない
      if (x < 0 || y < 0) {
        return false;
      }
      const $dragitem = $(dragitem);
      const width = parseInt($dragitem.width());
      const height = parseInt($dragitem.height());

      // 指定座標が要素よりも右または下方向に飛び出ているならそれも不透明部分とは言えない
      if (x > width || y > height) {
        return false;
      }

      // この時点で指定座標が要素の矩形領域に含まれることは確定した
      // alpha属性（不透明部分のみドラッグ可能にするオプション）が
      // trueでない場合はこの時点で不透明部分として扱う
      if (dragitem.__pm.alpha !== "true") {
        return true;
      }

      // タグ名（小文字）
      const tag_name = dragitem.tagName.toLowerCase();

      // <img> または <canvas> でないならもう true を返しちゃおう
      if (tag_name !== 'img' && tag_name !== 'canvas') {
        return true;
      }

      // <img> ではあるが画像がまだ読み込み中なら判定不可能なのでこれも true を返しちゃおう
      if (tag_name === 'img' && dragitem.naturalWidth === 0) {
        return true;
      }

      // アルファボタンフラグが立っていなければそれも true
      if (dragitem.__pm.alpha !== 'true') {
        return true;
      }

      //
      // ここから判定
      //

      // <canvas> が未作成なら初期化
      if (!dragitem.__draggable_canvas) {
        dragitem.__draggable_canvas = document.createElement('canvas');
      }

      // Imagedata 格納用
      let imagedata;

      if (
        dragitem.imagedata &&
        width === dragitem.__draggable_canvas.width &&
        height === dragitem.__draggable_canvas.height
      ) {
        // 前回の Imagedata のキャッシュが存在し、
        // 画像の幅や高さに変更がない場合は前回のキャッシュがそのまま使えるはずだ
        imagedata = dragitem.imagedata;
      } else {
        // キャッシュが使えない場合
        // <canvas> に横幅と高さをセットしてクリアし画像を描画
        dragitem.__draggable_canvas.width = width;
        dragitem.__draggable_canvas.height = height;
        const ctx = dragitem.__draggable_canvas.getContext('2d');
        ctx.clearRect(0, 0, width, height);
        ctx.drawImage(dragitem, 0, 0, width, height);
        // 画像全面の Imagedata を取得
        // ※今回の判定だけなら (x|0, y|0, 1, 1) で十分だが、今後の使い回しを考慮して全面のデータを取得しておく
        dragitem.imagedata = imagedata = ctx.getImageData(0, 0, width, height);
      }

      // Imagedata.data は左上のピクセルから始まって右に向かって [R, G, B, A, R, G, B, A, ... ] という順で値が格納されている配列
      // R, G, B, A はそれぞれ 0～255 の整数値
      const target_pixel_alpha = imagedata.data[(y | 0) * (width * 4) + (x | 0) * 4 + 3];

      // A値が半分以上なら不透明とみなそう
      return target_pixel_alpha > 127;
    };



    /**
     * ティラノスクリプト上の座標x, yを受け取って
     * その座標に重なっている要素を含む配列を返す。
     * 全要素を探索するわけではなく
     * 特定のセレクタtarget_selectorに該当する要素がサーチ対象となる。
     * 手前にある要素ほど配列の先頭に来るようにソートされる。
     * @param {number} x ティラノスクリプト上のx座標
     * @param {number} y ティラノスクリプト上のy座標
     * @param {string} [selector] サーチする要素のセレクタ
     * @returns {Element[]}
     */
    const getElementsByPosition = (x, y, selector = SELECTOR_DRAGGABLE) => {
      const elms = [];
      $(selector).each((i, elm) => {
        // この要素の座標情報を計算
        const $elm = $(elm);
        const css = $elm.css(['left', 'top', 'width', 'height']);
        const elm_x = parseFloat(css.left);
        const elm_y = parseFloat(css.top);
        const elm_w = parseFloat(css.width);
        const elm_h = parseFloat(css.height);
        const ox = x - elm_x;
        const oy = y - elm_y;
        const elm_half_w = elm_w / 2;
        const elm_half_h = elm_h / 2;
        let px = ox - elm_half_w;
        let py = oy - elm_half_h;

        // この要素を単純な矩形とみなしたとき、指定された点が矩形領域の外側にあるならもういい
        if (ox < 0 || elm_w < ox || oy < 0 || elm_h < oy) {
          return;
        }

        // この要素を単純な矩形とみなしたとき、指定された点はこの要素の領域内部にあるようだ

        // さらに border-radius を考慮
        // それでも指定された点はこの要素の領域内部にあるだろうか？
        const is_in_border = (() => {
          const t_or_b = py < 0 ? 'top' : 'bottom';
          const l_or_r = px < 0 ? 'left' : 'right';
          const border_radius_str = $elm.css(`border-${t_or_b}-${l_or_r}-radius`);
          if (border_radius_str === '0px') {
            return true;
          }
          px = Math.abs(px);
          py = Math.abs(py);
          const border_radius = parseInt(border_radius_str);
          let border_radius_w;
          let border_radius_h;
          if (border_radius_str.includes('%')) {
            border_radius_w = Math.min(elm_half_w, border_radius * elm_w);
            border_radius_h = Math.min(elm_half_h, border_radius * elm_h);
          } else {
            border_radius_w = border_radius_h = Math.min(elm_half_w, elm_half_h, border_radius);
          }
          let brx = px - (elm_half_w - border_radius_w);
          let bry = py - (elm_half_h - border_radius_h);
          if (brx < 0 || bry < 0) {
            return true;
          }
          brx = brx / border_radius_w;
          bry = bry / border_radius_h;
          const brf = Math.sqrt(Math.pow(brx, 2) + Math.pow(bry, 2));
          return brf <= 1;
        })();

        // border-radius を考慮してなお領域内部にあるなら晴れて戻り値のリストに追加
        if (is_in_border) {
          elms.push(elm);
        }
      });

      // 手前にある要素ほど配列の先頭に来るように並べ替える
      // * z-index が違う場合、z-index がより大きな要素を配列の先頭に持ってくる
      // * z-index が同じ場合、DOM上でより後ろに追加されている要素を配列の先頭に持ってくる
      elms.sort((a, b) => {
        const j_a = $(a);
        const j_b = $(b);
        const a_z_index = parseInt(j_a.css('z-index')) || 0;
        const b_z_index = parseInt(j_b.css('z-index')) || 0;
        if (a_z_index === b_z_index) {
          const a_node_index = parseInt(j_a.index()) || 0;
          const b_node_index = parseInt(j_b.index()) || 0;
          return a_node_index > b_node_index ? -1 : 1;
        } else {
          return a_z_index > b_z_index ? -1 : 1;
        }
      });

      return elms;
    };



    /**
     * マウスイベントをエミュレートして
     * ある要素で発生したマウスイベントを後面の要素に貫通させる。
     * この関数は次のようなケースで利用する。
     *
     *   <div>
     *     <img A>
     *     <img B>
     *   </div>
     *
     * ここでBへのクリックを検知したものの、
     * なんらかの理由でBへのクリックを無効化し
     * Aにクリックを貫通させたいことがある。
     * このようなケースでこの関数を呼ぶ。
     * @param {Event} event
     * @param {string} selector
     * @returns {boolean} イベントの貫通が発生したかどうか
     */
    const emulatePointerEvent = (event, selector = SELECTOR_DRAGGABLE) => {
      // 元のマウスイベントが発生した要素を<無視するリスト>に追加
      if (!event.__ignore_elms) event.__ignore_elms = [];
      event.__ignore_elms.push(event.target);

      // 元のマウスイベントが発生したティラノスクリプト上の座標に重なっている要素を抽出
      // ただし<無視するリスト>に記載があるものは除外する
      const elms = getElementsByPosition(event.tyranoX, event.tyranoY, selector).filter((item) => {
        return !event.__ignore_elms.includes(item);
      });

      // マウスイベントを貫通させるべき要素が存在しなかったら false を返す
      if (elms.length === 0) {
        return false;
      }

      // マウスイベントの貫通先が存在した！
      const elm = elms[0];

      // 偽のイベントを作成して適用する
      const fake_event = event.type.includes('mouse')
        ? new MouseEvent(event.type, event)
        : new PointerEvent(event.type, event);
      fake_event.__ignore_elms = event.__ignore_elms;
      fake_event.__is_fake = true;
      elm.dispatchEvent(fake_event);

      // 貫通させたということで true を返す
      return true;
    };



    /**
     * nextOrderを呼ばずに効果音を再生する
     * @param {string} storage ./data/sound/ 下の音声ファイル名 (例) "sound.mp3"
     */
    const playSound = (storage) => {
      if (storage) {
        TG.ftag.startTag('playse', {
          storage: storage,
          stop: 'true',
        });
      }
    };



    /**
     * ドラッガブルなElementのSetを受け取り
     * ElementのIDの配列を返す
     * @param {Set} set
     * @returns {string[]}
     */
    const toArray = (set) => {
      const arr = [];
      for (const item of set) {
        if (item.__pm.id) {
          arr.push(item.__pm.id);
        }
      }
      return arr;
    };



    /**
     * 要素をドラッグ可能にする
     * @param {Element} dragitem
     * @param {object} pm
     */
    const draggable = (dragitem, pm) => {
      //
      // 初期化
      //

      // クラス付与
      dragitem.classList.add(CLASS_DRAGGABLE);
      // dragitem.style.setProperty('cursor', 'grab');

      // 要素の内部プロパティのドロップエリア情報 __droparea を初期化
      dragitem.__droparea = null;

      // ゲーム変数を初期化
      TG.stat.f[F_NAME_DRAGITEM][pm.id] = '';

      // セーブデータの復元作業
      // data-effect属性にドロップエリアのIDが格納してある
      // もしセーブ時点でどこかのドロップエリアに属しているなら
      // そのドロップエリア要素を取得して __droparea に格納する
      const saved_droparea_id = JSON.parse(dragitem.getAttribute('data-effect'));
      if (saved_droparea_id) {
        dragitem.__droparea = document.getElementById(saved_droparea_id);
      }

      //
      // ポインターダウンのイベントハンドラを登録
      // 不透明部分をポインターダウンしているかどうかをチェックし
      // そうである場合はドラッグ開始処理を呼ぶような処理
      //

      setPointerEvent(dragitem, 'pointerdown', (event) => {
        log("setPointerEvent(): ポインターダウンを検出");

        // ドラッガブルクラスが外れている場合は無視
        // [undraggable]で無効化できるようにする
        if (!dragitem.classList.contains(CLASS_DRAGGABLE)) {
          return;
        }

        // テキスト追加中は無視
        if (TG.stat.is_adding_text) {
          return;
        }

        // ここが透明な部分だったら
        if (!isHereOpaque(dragitem, event.tyranoOffsetX, event.tyranoOffsetY)) {
          // 下にポインターダウンを貫通させる
          log("setPointerEvent(): 透明部分であるため下層の要素に貫通");
          emulatePointerEvent(event);
          return;
        }

        // ドラッグ開始時の処理を実行（以下で定義）
        log("setPointerEvent(): 不透明部分であるためドラッグ開始");
        dragitem.__onDragStart(event);

        // <body>にpointermoveを貫通させる
        document.body.dispatchEvent(new PointerEvent('pointermove', event));
      });

      //
      // ドラッグ開始処理
      //

      dragitem.__onDragStart = (event) => {
        log("__onDragStart(): ★ドラッグ開始");

        $(".last_dragitem").removeClass("last_dragitem");
        $(dragitem).addClass("last_dragitem");

        //
        // ドラッグを開始した時点で、すでにこの要素があるドロップエリアに属している場合
        // いったんドロップエリアへの帰属を解除してやる
        //
        if (dragitem.__droparea && dragitem.__droparea.__dragitemset) {
          log("__onDragStart(): ドロップエリアへの帰属を解除");
          // ドロップエリア
          const droparea = dragitem.__droparea;
          pointer_data.start_droparea = droparea;

          log(pointer_data.start_droparea);

          //
          // ドロップエリア側の情報を更新
          //

          // 内部プロパティ/data-effect属性/ゲーム変数/クラスをすべて更新
          droparea.__dragitemset.delete(dragitem);
          droparea.setAttribute(
            'data-effect',
            JSON.stringify(toArray(droparea.__dragitemset)),
          );
          TG.stat.f[F_NAME_DROPAREA][droparea.__pm.id] = toArray(droparea.__dragitemset);
          if (droparea.__dragitemset.size > 0) {
            droparea.classList.add(CLASS_DROPPED);
          } else {
            droparea.classList.remove(CLASS_DROPPED);
          }

          //
          // ドラッグ要素側の情報を更新
          //
          dragitem.__droparea = null;
          dragitem.setAttribute('data-effect', JSON.stringify(''));
          TG.stat.f[F_NAME_DRAGITEM][pm.id] = '';
          dragitem.classList.remove(CLASS_DROPPED);
        } else {
          pointer_data.start_droparea = null;
        }

        // ドラッグ状態管理用オブジェクト pointer_data に情報を記録する
        pointer_data.setDragElm(dragitem);
        pointer_data.start_left = dragitem.style.left;
        pointer_data.start_top = dragitem.style.top;
        pointer_data.start_offset_x = event.tyranoOffsetX;
        pointer_data.start_offset_y = event.tyranoOffsetY;
        pointer_data.start_z_index = $(dragitem).css('z-index');

        // "ドラッグ中"クラス付与
        dragitem.classList.add(CLASS_DRAGGING);

        // 効果音の再生
        playSound(pm.dragse);

        // 画像の変更
        if (pm.dragimg) {
          dragitem.setAttribute("src", pm.dragimg);
        }

        // マウスカーソルの変更
        if (pm.dragcursor) {
          dragitem.style.setProperty("cursor", `url("${pm.dragcursor}"), auto`);
        }

        // z-indexの調整
        dragitem.style.setProperty("z-index", 99999999);

        if (pm.dragexp) {
          TG.embScript(pm.dragexp);
        }
      };

      //
      // ドラッグ終了
      //

      dragitem.__onDragEnd = () => {
        log("__onDragEnd(): ★ドラッグ終了");

        // スワイプ操作をしたのではない
        setTimeout(() => {
          TG.key_mouse.is_swipe = false;
        }, 1);

        // "ドラッグ中"クラス除去
        dragitem.classList.remove(CLASS_DRAGGING);

        // マウスカーソルの変更
        if (pm.dragcursor) {
          dragitem.style.setProperty("cursor", "");
        }

        // z-indexの調整
        dragitem.style.setProperty("z-index", pointer_data.start_z_index);

        // いまドラッグを終えたこの要素を
        // ドラッグ可能な要素群のうち一番手前に表示する
        // const j_last = $(SELECTOR_DRAGGABLE).last();
        // j_last.after(dragitem);

        //
        // ドラッグ終了時の位置の調整
        //

        // ドロップエリア内でドラッグを完了した場合
        // fit 属性が true であればドロップエリアに位置を合わせる
        const area = pointer_data.droparea;
        if (area) {
          // if (pm.fit === "true") {
          //   dragitem.style.left = area.style.left;
          //   dragitem.style.top = area.style.top;
          // }
        }

        // ドロップエリアではない場所でドラッグを終了した場合
        else {
          log("__onDragEnd(): ドロップエリアではない場所でドラッグを終了した");
          dragitem.setAttribute("src", pm.graphic);
          dragitem.__before_enterimg = pm.graphic;
          // return属性がtrueなら位置をもとに戻す処理を行う
          if (pm.return === "true") {
            // ドラッグを開始した時点でどこかのドロップエリアに所属していたならそこに戻す
            if (pointer_data.start_droparea && pm.dropout === "false") {
              log("__onDragEnd(): もとのドロップエリアに戻す");
              dropItemIntoArea(dragitem, pointer_data.start_droparea);
            }
            // home_left, home_topが保存されているならそこに戻す
            else if (pm.home_left !== undefined && pm.home_top !== undefined) {
              log("__onDragEnd(): ホームポジションに戻す");
              dragitem.style.left = pm.home_left + "px";
              dragitem.style.top = pm.home_top + "px";
              if (pm.home_area !== undefined) {
                log("__onDragEnd(): ホームドロップエリアに戻す");
                dropItemIntoArea(dragitem, $(`.${pm.home_area}`).get(0));
              }
            }
            // ドラッグを開始した座標に戻す
            else {
              log("__onDragEnd(): ドラッグ開始前の位置に戻す");
              dragitem.style.left = pointer_data.start_left;
              dragitem.style.top = pointer_data.start_top;
            }
          }
        }

        if (pm.dragendexp) {
          TG.embScript(pm.dragendexp);
        }
      };

      //
      // ホバー開始
      //

      dragitem.__onMouseEnter = () => {
        log("__onMouseEnter(): ホバー開始");

        // "ホバー中"クラス付与
        dragitem.classList.add(CLASS_HOVERING);

        // 効果音を再生
        playSound(pm.enterse);

        // 要素の画像を変更
        dragitem.__before_enterimg = dragitem.getAttribute("src");
        if (pm.enterimg) {
          dragitem.setAttribute("src", pm.enterimg);
        }

        // マウスカーソルを変更
        if (pm.entercursor) {
          console.error(`url("${pm.entercursor}"), auto`);
          dragitem.style.setProperty("cursor", `url("${pm.entercursor}"), auto`);
        }
      };

      //
      // ホバー終了
      //

      dragitem.__onMouseLeave = () => {
        log("__onMouseLeave(): ホバー終了");

        // "ホバー中"クラス除去
        dragitem.classList.remove(CLASS_HOVERING);

        // 効果音を再生
        playSound(pm.leavese);

        // 要素の画像をもとに戻す
        if (pm.enterimg) {
          if (dragitem.__before_enterimg) {
            dragitem.setAttribute('src', dragitem.__before_enterimg);
          }
        }

        // マウスカーソルを変更
        if (pm.entercursor) {
          dragitem.style.setProperty('cursor', "");
        }
      };

      //
      // この要素上でマウスを動かしたときのイベント
      // マウスの侵入・脱出を検出する
      //

      setPointerEvent(dragitem, 'mouseover mousemove mouseout', (event) => {
        // ドラッガブルクラスが外れている場合は無視
        // [undraggable]で無効化できるようにする
        if (!dragitem.classList.contains(CLASS_DRAGGABLE)) {
          return;
        }

        // ドラッグ中の要素があるなら無視
        if (pointer_data.dragitem) {
          return;
        }

        // この要素の不透明な部分にマウスカーソルが乗っているならば
        if (
          event.type !== 'mouseout' &&
          isHereOpaque(dragitem, event.tyranoOffsetX, event.tyranoOffsetY)
        ) {
          // この要素をホバーしていることになる
          // 状態管理オブジェクトpointer_dataに記録する
          pointer_data.setHoverElm(dragitem);
        }

        // マウスカーソルがこの要素の透明な部分に乗っているのならば
        else {
          // いまこの要素をホバーしてはいない
          // ここで、もし先ほどまでこの要素をホバーしていたのなら、
          // いまは「この要素のホバーが外れた瞬間」ということになる
          if (pointer_data.hoveritem === dragitem) {
            pointer_data.setHoverElm(null);
          }

          // mousemoveイベントをエミュレートしてこの要素の下まで貫通させる
          if (event.type === 'mousemove' && !emulatePointerEvent(event)) {
            // この下になにもドラッガブル要素がなかったのならいまはなにもホバーしていない
            pointer_data.setHoverElm(null);
          }
        }

        // いまホバーしている要素が存在するならマウスカーソルを変更する
        if (pointer_data.hoveritem) {
          // elm.style.setProperty('cursor', 'grab');
        }

        // いまホバーしている要素がないならマウスカーソルは「継承」にしておく
        else {
          // elm.style.setProperty('cursor', 'inherit');
        }
      });
    };


    function dropItemIntoArea(dragitem, droparea) {
      //
      // ドラッグを開始した時点で、すでにこの要素があるドロップエリアに属している場合
      // いったんドロップエリアへの帰属を解除してやる
      //
      if (dragitem.__droparea && dragitem.__droparea.__dragitemset) {
        // ドロップエリア
        const droparea = dragitem.__droparea;

        //
        // ドロップエリア側の情報を更新
        //

        // 内部プロパティ/data-effect属性/ゲーム変数/クラスをすべて更新
        droparea.__dragitemset.delete(dragitem);
        droparea.setAttribute(
          'data-effect',
          JSON.stringify(toArray(droparea.__dragitemset)),
        );
        TG.stat.f[F_NAME_DROPAREA][droparea.__pm.id] = toArray(droparea.__dragitemset);
        if (droparea.__dragitemset.size > 0) {
          droparea.classList.add(CLASS_DROPPED);
        } else {
          droparea.classList.remove(CLASS_DROPPED);
        }

        //
        // ドラッグ要素側の情報を更新
        //
        dragitem.__droparea = null;
        dragitem.setAttribute('data-effect', JSON.stringify(''));
        TG.stat.f[F_NAME_DRAGITEM][dragitem.__pm.id] = '';
        dragitem.classList.remove(CLASS_DROPPED);
      }

      if (!droparea) {
        return;
      }

      //
      // ドロップエリアの情報を更新する
      // 内部プロパティの値やクラスを書き換える
      //
      droparea.__dragitemset.add(dragitem);
      droparea.setAttribute('data-effect', JSON.stringify(toArray(droparea.__dragitemset)));
      TG.stat.f[F_NAME_DROPAREA][droparea.__pm.id] = toArray(droparea.__dragitemset);
      if (droparea.__dragitemset.size > 0) droparea.classList.add(CLASS_DROPPED);
      else droparea.classList.remove(CLASS_DROPPED);

      //
      // ドラッグ要素の情報を更新する
      //

      dragitem.classList.add(CLASS_DROPPED);
      dragitem.__droparea = droparea;
      dragitem.setAttribute('data-effect', JSON.stringify(droparea.__pm.id));
      TG.stat.f[F_NAME_DRAGITEM][dragitem.__pm.id] = droparea.__pm.id;

      // ドラッグ要素の位置調整
      const fit = dragitem.__pm.fit;
      if (fit !== "false") {
        let x = parseInt(droparea.style.left);
        let y = parseInt(droparea.style.top);
        let dx = 0;
        let dy = 0;
        let hash = fit.split(",");
        if (hash.length >= 2) {
          dx = parseInt(hash[0]) || 0;
          dy = parseInt(hash[1]) || 0;
        }
        dragitem.style.left = (x + dx) + "px";
        dragitem.style.top = (y + dy) + "px";
      }
    }


    /**
     * ある要素の位置と大きさを取得する
     * left, top, right, bottom, width, height
     * @param {Element} elm
     * @returns {Object}
     */
    const getElementPosition = (elm) => {
      const $elm = $(elm);
      const css = $elm.css(['left', 'top', 'width', 'height']);
      const left = parseFloat(css.left);
      const top = parseFloat(css.top);
      const width = parseFloat(css.width);
      const height = parseFloat(css.height);
      const right = left + width;
      const bottom = top + height;
      return { left, top, right, bottom, width, height };
    };

    /**
     * 指定セレクタselectorに該当する要素群のうち
     * 指定要素Elementと矩形領域が重なっている要素の配列を返す。
     * 手前にある要素ほど配列の先頭に来るようにソートされる。
     * @param {Element} dragitem
     * @param {string} target_selector
     * @returns {Element[]}
     */
    const getPointerElements = (dragitem, selector = SELECTOR_DROPPABLE) => {
      const elms = [];
      $(selector).each((i, elm) => {
        // ドロップエリア要素の内部プロパティにパラメータが記録されていない場合は無効
        if (!elm.__pm) {
          return;
        }

        // ドロップエリアに drag_name 属性が指定されている場合
        // ドロップできるのは drag_name 属性の値に含まれるような name を持つドラッグ要素だけとなる
        // [droparea drag_name="apple,banana"]
        // [dragitem name="apple"] →ドロップできる
        // [dragitem name="lemon"] →ドロップできない！
        if (elm.__pm.drag_name) {
          let name_arr;
          if (Array.isArray(elm.__pm.drag_name)) {
            name_arr = elm.__pm.drag_name;
          } else {
            name_arr = elm.__pm.drag_name.split(",");
          }
          if (!name_arr.includes(dragitem.__pm.name)) {
            return;
          }
        }

        const pos = getElementPosition(elm);
        const x = pointer_data.offset_x;
        const y = pointer_data.offset_y;
        if (pos.left <= x && x <= pos.right && pos.top <= y && y <= pos.bottom) {
          elms.push(elm);
        }
      });

      // 手前にある要素ほど配列の先頭に来るように並べ替える
      elms.sort((a, b) => {
        const j_a = $(a);
        const j_b = $(b);
        const a_z_index = parseInt(j_a.css('z-index')) || 0;
        const b_z_index = parseInt(j_b.css('z-index')) || 0;
        if (a_z_index === b_z_index) {
          const a_node_index = parseInt(j_a.index()) || 0;
          const b_node_index = parseInt(j_b.index()) || 0;
          return a_node_index > b_node_index ? -1 : 1;
        } else {
          return a_z_index > b_z_index ? -1 : 1;
        }
      });

      return elms;
    };



    /**
     * 指定セレクタselectorに該当する要素群のうち
     * 指定要素Elementと矩形領域が重なっている要素の配列を返す。
     * 手前にある要素ほど配列の先頭に来るようにソートされる。
     * @param {Element} dragitem
     * @param {string} target_selector
     * @returns {Element[]}
     */
    const getOverlappingElements = (dragitem, selector = SELECTOR_DROPPABLE) => {
      const elms = [];
      $(selector).each((i, elm) => {
        // ドロップエリア要素の内部プロパティにパラメータが記録されていない場合は無効
        if (!elm.__pm) {
          return;
        }

        // ドロップエリアに drag_name 属性が指定されている場合
        // ドロップできるのは drag_name 属性の値に含まれるような name を持つドラッグ要素だけとなる
        // [droparea drag_name="apple,banana"]
        // [draggable name="apple"] →ドロップできる
        // [draggable name="lemon"] →ドロップできない！
        if (elm.__pm.drag_name) {
          let name_arr;
          if (Array.isArray(elm.__pm.drag_name)) {
            name_arr = elm.__pm.drag_name;
          } else {
            name_arr = elm.__pm.drag_name.split(",");
          }
          if (!name_arr.includes(dragitem.__pm.name)) {
            return;
          }
        }

        // A: いまドラッグしているドラッガブル要素の領域
        // B: いまドロップできそうなドロッパブル要素の領域
        // C: AとBの交差領域
        // D: Cが取りうる最大の領域
        const A = getElementPosition(dragitem);
        const B = getElementPosition(elm);
        const C = {
          left: Math.max(A.left, B.left),
          top: Math.max(A.top, B.top),
          right: Math.min(A.right, B.right),
          bottom: Math.min(A.bottom, B.bottom),
        };
        C.width = C.right - C.left;
        C.height = C.bottom - C.top;
        if (C.width <= 0 || C.height <= 0) {
          return null;
        }
        const D = {
          width: Math.min(A.width, B.width),
          height: Math.min(A.height, B.height),
        };
        C.area = (C.width | 0) * (C.height | 0);
        D.area = (D.width | 0) * (D.height | 0);
        let overlapping_ratio = C.area / D.area;
        overlapping_ratio = parseFloat(overlapping_ratio.toFixed(2));
        elm.__overlapping_ratio = overlapping_ratio;
        elms.push(elm);
      });

      // 手前にある要素ほど配列の先頭に来るように並べ替える
      elms.sort((a, b) => {
        const j_a = $(a);
        const j_b = $(b);
        const a_z_index = parseInt(j_a.css('z-index')) || 0;
        const b_z_index = parseInt(j_b.css('z-index')) || 0;
        if (a_z_index === b_z_index) {
          const a_node_index = parseInt(j_a.index()) || 0;
          const b_node_index = parseInt(j_b.index()) || 0;
          return a_node_index > b_node_index ? -1 : 1;
        } else {
          return a_z_index > b_z_index ? -1 : 1;
        }
      });

      return elms;
    };



    //
    // ティラノの画面上でマウスを動かしたときのイベントリスナを登録
    // 要素の位置を実際に移動させる処理が記述されているのはココ
    //

    setPointerEvent(document.body, 'pointermove', (event) => {
      // ドラッグ中の要素がなにもないなら無視
      const { dragitem } = pointer_data;
      if (!dragitem) {
        return;
      }

      pointer_data.offset_x = event.tyranoX;
      pointer_data.offset_y = event.tyranoY;
      const pm = dragitem.__pm;

      if (!pm) {
        return;
      }

      log("ドラッグ中");

      //
      // ドラッグ中の要素のleft, topを書き変えて
      // 要素の位置をマウスカーソルに追従させる
      //

      // 要素のどこを掴むか？
      // grabposパラメータで分岐
      // "default" : ポインターダウンした場所をそのままつかむ
      // "center"  : 要素の中央を掴む
      // "10,10"   : 左上から10px 10pxの場所を掴む
      let left = event.tyranoX;
      let top = event.tyranoY;
      switch (pm.grabpos) {
        case "default":
          left = event.tyranoX - pointer_data.start_offset_x;
          top = event.tyranoY - pointer_data.start_offset_y;
          break;
        case "center":
          left = event.tyranoX - parseInt(dragitem.clientWidth / 2);
          top = event.tyranoY - parseInt(dragitem.clientHeight / 2);
          break;
        default:
          try {
            const hash = pm.grabpos.split(",");
            const x = parseInt(hash[0]) || 0;
            const y = parseInt(hash[1]) || 0;
            left = event.tyranoX - x;
            top = event.tyranoY - y;
          } catch (e) {
            console.error(e);
          }
          break;
      }
      $(dragitem).css({ left, top });

      //
      // ドロップエリアを検出
      //

      const droparea = (() => {
        //
        // sensitivity 属性が pointer の場合
        // マウスカーソルに重なっているドロップエリアのうち一番前面にあるものを検出する
        //

        if (pm.sensitivity === "default") {
          const dropareas = getPointerElements(dragitem, SELECTOR_DROPPABLE);
          if (dropareas && dropareas.length > 0) {
            return dropareas[0];
          } else {
            return null;
          }
        }

        //
        // sensitivity 属性が pointer ではなくなんらかの数値の場合
        // いまドラッグしている要素がドロップエリアとどれくらい重なっているかを計算する
        //

        const dropareas = getOverlappingElements(dragitem, SELECTOR_DROPPABLE);

        // 重なっているドロップエリアが存在しなければ終わる
        if (dropareas.length === 0) {
          return null;
        }

        // 一番前面にあるドロップエリアを参照
        const droparea = dropareas[0];


        // sensitivity: ドロップ感度（0～1）
        // ドラッガブル要素とドロップエリアの交差領域（重なっている領域）が取りうる最大の面積を 1 としたときに
        // 現在の交差領域の面積がどれだけあれば「ドロップ可能」とみなすか？
        const sensitivity = parseFloat(
          dragitem.__pm.sensitivity || droparea.__pm.sensitivity || DEFAULT_SENSITIVITY,
        );

        // 交差領域の大きさ（0～1）
        const ratio = droparea.__overlapping_ratio;

        if (ratio === 1 || ratio > sensitivity) {
          return droparea;
        } else {
          return null;
        }
      })();

      // 検出したドロップ先をセット
      pointer_data.setDropArea(droparea);

      if (pm.draggingexp) {
        TG.embScript(pm.draggingexp);
      }
    });



    //
    // ティラノスクリプトの画面上で
    // マウスボタンを離したときのイベントリスナを登録
    //

    setPointerEvent(document.body, 'pointerup pointerleave pointercancel', () => {
      // ドラッグ中の要素がなにもないなら無視
      const { dragitem } = pointer_data;
      if (!dragitem) {
        return;
      }

      // ドラッグ終わり
      log("setPointerEvent(): ドラッグ完了");
      dragitem.__onDragEnd();

      // ドロップ可能な領域があるならそこにドロップしよう
      if (pointer_data.droparea) {
        log("setPointerEvent(): ドロップ完了");
        pointer_data.droparea.__onItemDropped(dragitem);
      }

      // ドラッグおわり
      pointer_data.setDragElm(null);
      pointer_data.setDropArea(null);
    });



    /**
     * ある要素をドロップエリアにする
     * @param {Element} droparea
     */
    const droppable = (droparea) => {
      log("droppable()", droparea);

      droparea.classList.add(CLASS_DROPPABLE);
      droparea.__dragitemset = new Set();
      const saved_data = JSON.parse(droparea.getAttribute('data-effect'));
      if (saved_data) {
        for (const item of saved_data) {
          droparea.__dragitemset.add(document.getElementById(item));
        }
      }
      TG.stat.f[F_NAME_DROPAREA][droparea.__pm.id] = [];

      //
      // ドラッグ中の要素の侵入
      //

      droparea.__onItemEnter = () => {
        playSound(droparea.__pm.enterse);
        if (droparea.__pm.droppableimg) {
          droparea.setAttribute("src", droparea.__pm.droppableimg);
        }
      };

      //
      // ドラッグ中の要素の脱出
      //

      droparea.__onItemLeave = () => {
        playSound(droparea.__pm.leavese);
        if (droparea.__pm.droppableimg) {
          droparea.setAttribute("src", droparea.__pm.originimg);
        }
      };

      //
      // ドロップ完了
      //

      droparea.__onItemDropped = (dragitem) => {
        log("ドロップ", dragitem);

        const pm = dragitem.__pm;
        const pm2 = droparea.__pm;

        //
        // まずこのドロップを受け入れるべきかどうかを判定する
        // ドロップエリアに allow 指定がなければ受け入れる
        // allow 指定があるならばドラッグ要素がそれに対応しているかどうかを判断する
        //

        let is_match_a = false;
        if (!pm2.allow) {
          is_match_a = true;
        } else {
          // allow 属性の値はカンマ区切りの文字列であることも配列であることもありえる
          // 配列に統一しておく
          let name_arr;
          if (Array.isArray(pm2.allow)) {
            name_arr = pm2.allow;
          } else {
            name_arr = pm2.allow.split(",");
          }

          // allow 属性の値に含まれている名前の少なくともひとつを
          // "このドラッグ要素"がクラスの一部として含んでいるならばジャンプする
          for (let name of name_arr) {
            if (dragitem.classList.contains(name)) {
              is_match_a = true;
              break;
            }
          }
        }

        let is_match_b = false;
        if (!pm.allow) {
          is_match_b = true;
        } else {
          // allow 属性の値はカンマ区切りの文字列であることも配列であることもありえる
          // 配列に統一しておく
          let name_arr;
          if (Array.isArray(pm.allow)) {
            name_arr = pm.allow;
          } else {
            name_arr = pm.allow.split(",");
          }

          // allow 属性の値に含まれている名前の少なくともひとつを
          // "このドラッグ要素"がクラスの一部として含んでいるならばジャンプする
          for (let name of name_arr) {
            if (droparea.classList.contains(name)) {
              is_match_b = true;
              break;
            }
          }
        }

        let is_match = is_match_a && is_match_b;

        // ドロップエリアにアイテムをドロップしたはいいが適合しなかった
        if (!is_match) {
          // return属性がtrueの場合は元の場所に戻す処理をする必要がある
          if (pm.return === "true") {
            if (pointer_data.start_droparea) {
              dropItemIntoArea(dragitem, pointer_data.start_droparea);
            } else if (pm.home_left !== undefined && pm.home_top !== undefined) {
              dragitem.style.left = pm.home_left + "px";
              dragitem.style.top = pm.home_top + "px";
            } else {
              dragitem.style.left = pointer_data.start_left;
              dragitem.style.top = pointer_data.start_top;
            }
          }
          return;
        }

        // ドロップエリアに先客（すでにセットされているドラッガブル要素）がいる場合
        if (droparea.__dragitemset.size > 0) {
          // ドロップエリアのoneonly属性がtrueの場合
          if (droparea.__pm.oneonly === "true") {
            // 1つしか格納できないドロップエリアにすでに先客がいる場合であっても、
            // 置換が有効の場合は先客を押しのける
            if (droparea.__pm.replace === undefined) {
              const set = droparea.__dragitemset;
              const iterator = set.values();
              // old_dragitem: 先客
              const old_dragitem = iterator.next().value;
              if (old_dragitem) {
                // 先客と位置を交換する
                if (pointer_data.start_droparea) {
                  log("先客と位置を交換する");
                  dropItemIntoArea(old_dragitem, pointer_data.start_droparea);
                }
                // 先客をホームポジションに戻す
                else if (old_dragitem.__pm && old_dragitem.__pm.home_left !== undefined && old_dragitem.__pm.home_top !== undefined) {
                  log("先客をホームポジションに戻す");
                  old_dragitem.style.left = old_dragitem.__pm.home_left + "px";
                  old_dragitem.style.top = old_dragitem.__pm.home_top + "px";
                  dropItemIntoArea(old_dragitem, null);
                }
              }
            } else {
              is_match = false;
            }
          }
        }

        // 効果音再生
        playSound(pm.dropse || pm2.dropse);

        // 画像変更
        if (pm.dropimg) {
          dragitem.setAttribute("src", pm.dropimg);
          dragitem.__before_enterimg = pm.dropimg;
        } else {
          dragitem.setAttribute("src", pm.graphic);
          dragitem.__before_enterimg = pm.graphic;
        }

        //
        // ドロップエリアの情報を更新する
        // 内部プロパティの値やクラスを書き換える
        //
        droparea.__dragitemset.add(dragitem);
        droparea.setAttribute('data-effect', JSON.stringify(toArray(droparea.__dragitemset)));
        TG.stat.f[F_NAME_DROPAREA][droparea.__pm.id] = toArray(droparea.__dragitemset);
        if (droparea.__dragitemset.size > 0) droparea.classList.add(CLASS_DROPPED);
        else droparea.classList.remove(CLASS_DROPPED);

        //
        // ドラッグ要素の情報を更新する
        //

        dragitem.classList.add(CLASS_DROPPED);
        dragitem.__droparea = droparea;
        dragitem.setAttribute('data-effect', JSON.stringify(droparea.__pm.id));
        TG.stat.f[F_NAME_DRAGITEM][dragitem.__pm.id] = droparea.__pm.id;

        // ドラッグ要素の位置調整
        const fit = pm.fit;
        if (fit !== "false") {
          let x = parseInt(droparea.style.left);
          let y = parseInt(droparea.style.top);
          let dx = 0;
          let dy = 0;
          let hash = fit.split(",");
          if (hash.length >= 2) {
            dx = parseInt(hash[0]) || 0;
            dy = parseInt(hash[1]) || 0;
          }
          dragitem.style.left = (x + dx) + "px";
          dragitem.style.top = (y + dy) + "px";
        }

        //
        // シナリオジャンプ処理
        //

        let jump_tag = "jump";
        if (pm.call === "true" || pm2.call === "true") {
          jump_tag = "call";
        }
        const jump_func = {
          jump(storage, target) {
            TG.ftag.startTag('jump', {
              storage: storage,
              target: target,
            });
          },
          call(storage, target) {
            // if (!TG.getStack('call')) {
            TG.ftag.startTag('call', {
              storage: storage,
              target: target,
              auto_next: "xxx"
            });
            // }
          }
        };

        let storage = "";
        let target = "";
        if (pm[`storage_${pm2.name}`] || pm[`target_${pm2.name}`]) {
          storage = pm[`storage_${pm2.name}`];
          target = pm[`target_${pm2.name}`];
        } else if (pm2[`storage_${pm.name}`] || pm2[`target_${pm.name}`]) {
          storage = pm2[`storage_${pm.name}`];
          target = pm2[`target_${pm.name}`];
        } else if (pm.storage || pm.target) {
          storage = pm.storage;
          target = pm.target;
        } else if (pm2.storage || pm2.target) {
          storage = pm2.storage;
          target = pm2.target;
        }
        if (storage || target) {
          jump_func[jump_tag](storage, target);
        }
      };
    };



    /**
     * storageを補完して相対パスを完成させる
     * あるいはHTTP指定されているなら何もせずにそのまま返す
     * @param {string} storage (例) "chara/akane/normal.png"
     * @param {string} folder (例) "fgimage"
     * @returns {string} (例) "./data/fgimage/chara/akane/normal.png"
     */
    const parseStorage = (storage, folder) => {
      if (!storage) {
        return '';
      } else if ($.isHTTP(storage)) {
        return storage;
      } else {
        return `./data/${folder}/${storage}`;
      }
    };



    /**
     * パスを受け取ってファイル名を返す（拡張子を含まない）
     * @param {string} path (例) "./data/fgimage/chara/akane.normal.v3.png"
     * @returns {string} "akane.normal.v3"
     */
    // const getFileName = (path) => {
    //   const file_name = path.split('/').pop();
    //   let hash = file_name.split('.');
    //   if (hash.length === 1) {
    //     return hash[0]; // ドットが含まれない場合はそのまま返す
    //   } else {
    //     return hash.slice(0, -1).join('.');
    //   }
    // };



    // ================================
    // [dragitem] タグ定義
    // ================================
    //
    // name        | ドラッガブルにする対象。[image]などに指定したものと同じものをここで指定します。
    //             | カンマ区切りで複数指定可。JS配列も渡せます。
    //             | 仮にname="apple"を指定した場合、f.dragitem_appleというゲーム変数に、
    //             | ドラッガブルイメージが所属しているドロップエリアのnameが記録されます。
    // grabpos     | ドラッグ中にドラッガブル画像のどこをつかむか。
    //             | キーワードもしくは半角区切りの2個1組の数値で指定します。
    //             | "default": ドラッグを開始した場所をそのままつかむ。
    //             | "center": 画像の中央を掴む。
    //             | "10,20": 左から10px、上から20pxの位置を掴む。
    // return      | "true"を指定すると、ドロップエリアの外でドラッグを終了した場合にもとの場所に戻ります。
    // alpha       | "true"を指定すると、画像の透明部分のクリックを無効化し、不透明部分だけをクリックできるようになります。
    // fit         | "true"を指定すると、ドロップエリアの中にドロップしたとき、画像の位置をドロップエリアに合わせます。
    // sensitibity | 0～1の数値で指定する。たとえば0.8を指定すると、ドラッガブル画像の8割以上の面積が
    //             | ドロップエリアに重なっていないとドロップ可能になりません。
    //             | なにも指定しなかった場合は、重なっている面積に関係なく、マウスカーソルがドロップエリア内にあればドロップできます。
    // enterimg    | マウスカーソルがドラッガブルイメージに乗ったときの画像ファイルを指定できます。
    // dragimg     | ドラッグしているときの画像を指定できます。
    // droppableimg     | ドロップ可能になったときの画像を指定できます。
    // dropimg  | ドロップしたあとの画像を指定できます。
    // entercursor | マウスカーソルがドラッガブル画像に乗ったときのマウスカーソル画像を指定できます。
    // dragcursor  | ドラッグ中のマウスカーソル画像を指定できます。
    // enterse     | マウスカーソルがドラッガブル画像に乗ったときの効果音を指定できます。
    // leavese     | マウスカーソルがドラッガブル画像から離れたときの効果音を指定できます。
    // dropse      | ドロップ完了したときの効果音を指定できます。

    const TAG_DRAGITEM = {
      name: 'dragitem',
      kag: TG,
      pm: {
        name: "",
        graphic: "",
        folder: "image",
        layer: "free",
        storage: "",
        target: "",
        allow: "",
        grabpos: "default",
        sensitivity: "default",
        return: "false",
        alpha: "false",
        fit: "false",

        enterimg: "",
        dragimg: "",
        droppableimg: "",
        dropimg: "",

        entercursor: "",
        dragcursor: "",

        enterse: "",
        dragse: "",
        droppablese: "",
        dropse: "",
        leavese: "",

        zindex: "100",
        color: "",
        time: "0",
        wait: "true",
        dropout: "true",
      },
      start(pm) {
        log("[dragitem]", pm);

        // フリーレイヤを取得（z-indexの処理は本家ティラノの button の実装から引用）
        let j_target_layer = null;
        const j_fix_layer = $("#tyrano_base");
        if (pm.layer === "fix") {
          j_target_layer = j_fix_layer;
        } else {
          j_target_layer = j_dg_layer;
        }

        // 画像が指定されているか？（指定されていないこともありえる。単純な色指定の場合）
        const is_image = !!pm.graphic;

        // 画像パスを補完して完成させる
        pm.graphic = parseStorage(pm.graphic, pm.folder);
        pm.enterimg = parseStorage(pm.enterimg, pm.folder);
        pm.dragimg = parseStorage(pm.dragimg, pm.folder);
        pm.droppableimg = parseStorage(pm.droppableimg, pm.folder);
        pm.dropimg = parseStorage(pm.dropimg, pm.folder);
        pm.originimg = pm.graphic;

        pm.entercursor = parseStorage(pm.entercursor, pm.folder);
        pm.dragcursor = parseStorage(pm.dragcursor, pm.folder);

        //
        // 要素の ID 属性を決定する
        // id パラメータ > ファイル名 > タグ名(dragitem) の優先順位
        // 重複する ID を持つ要素がすでに存在する場合は添え字を 2, 3, 4, ... と増やしていき
        // ユニークになった段階でそれを使う
        // つまり akane, akane2, akane3, akane4, ... のような順で ID を消費する
        //

        // let base_id = pm.id || getFileName(pm.graphic) || this.name;
        // let num = 1;
        // let id = base_id;
        // while (document.getElementById(id)) {
        //   num++;
        //   id = base_id + num;
        // }
        // pm.id = id;

        let $elm;
        let initial_item = null;
        const time = parseInt(pm.time) || 0;
        const is_wait = pm.wait === "true";

        // ============================================
        // [droparea]であり、copyarea属性が指定されている場合の動作
        // そのcopyarea属性の値をnameとして持つ要素の領域をコピーする
        // ============================================

        if (this.name === "droparea" && pm.copyarea) {
          let j_imgs = $(`.${pm.copyarea}`);
          if (j_imgs.length > 0) {
            const j_img = j_imgs.eq(0);

            //
            // 位置
            //

            // ティラノスクリプトの画面縮尺の影響を受けるためjQuery.offset()は使えない
            const left = j_img.css("left");
            const top = j_img.css("top");
            pm.x = parseFloat(left);
            pm.y = parseFloat(top);

            //
            // サイズ
            //

            const img = j_img[0];
            // 画像のロードが完了していればそのままサイズをコピーする
            if (img.complete && img.naturalHeight !== 0) {
              pm.width = j_img.width();
              pm.height = j_img.height();
            }
            // 画像のロードが完了していない場合
            else {
              // 画像にCSSでwidth/heightがともに指定されている場合はそれをコピー
              const width = parseFloat(j_img.css("width"));
              const height = parseFloat(j_img.css("height"));
              if (typeof width === "number" && typeof height === "number" && width > 0 && height > 0) {
                pm.width = width;
                pm.height = height;
              }
              // ロードも終わっていないしCSSも指定されていない場合は現状どうしようもないので
              // ロード完了時にwidth/heightをコピーする処理を予約する
              else {
                j_img.on("load", () => {
                  try {
                    $elm.css("width", j_img.width() + "px");
                    $elm.css("height", j_img.height() + "px");
                  } catch (e) {
                    console.error(e);
                  }
                });
              }
            }

            // 画像を変更したあともとに戻せるように最初の画像ファイルを保存しておく
            if (img.src) {
              pm.originimg = img.src;
              pm.graphic = img.src;
              pm.enterimg = pm.enterimg || pm.originimg;
              pm.dragimg = pm.dragimg || pm.originimg;
              pm.droppableimg = pm.droppableimg || pm.originimg;
              pm.dropimg = pm.dropimg || pm.originimg;
            }

            if ($(img).hasClass(CLASS_DRAGGABLE)) {
              initial_item = img;
            }
          }
        }

        // nameパラメータはカンマ区切りの文字列で渡すこともできるし
        // 配列型で渡すこともできる
        // name="apple,lemon,banana"
        // name="&['apple','lemon','banana']"
        // どちらでもOK
        let target_exists = false;
        let name_arr = null;
        if (pm.name) {
          if (Array.isArray(pm.name)) {
            name_arr = pm.name;
          } else {
            name_arr = pm.name.split(",");
          }
          name_arr.forEach(name => {
            $(`.${name}`).each(() => {
              target_exists = true;
            });
          });
        }

        // ============================================
        // [dragitem]で既存の画像を対象に取る場合
        // すでに[image][ptext]タグなどで場に出ている要素を効果対象に取る
        // ============================================

        if (this.name === "dragitem" && target_exists) {

          // バラした各nameについて
          name_arr.forEach(name => {
            // そのnameで要素を取得 1つ1つドラッグ可能にしていく
            $(`.${name}`).each((i, dragitem) => {
              const $dragitem = $(dragitem);

              // もう[dragitem]を適用したことがある要素は無視する
              // if ($dragitem.attr("data-event-tag") === "dragitem") {
              //   console.error("ひとつの要素に対して[dragitem]が二重に使用されています");
              //   return;
              // }

              // パラメータをクローン
              const _pm = $.extend({}, pm, {
                id: name,
              });

              // 画像を変更したあともとに戻せるように最初の画像ファイルを保存しておく
              if ($dragitem.attr("src")) {
                _pm.originimg = $dragitem.attr("src");
                _pm.graphic = _pm.originimg;
              }

              // 位置を変更したあともとに戻せるように最初の位置を保存しておく
              const left = $dragitem.css("left");
              const top = $dragitem.css("top");
              _pm.home_left = parseFloat(left);
              _pm.home_top = parseFloat(top);

              // その他の設定
              if (pm.width) $dragitem.css('width', pm.width);
              if (pm.height) $dragitem.css('height', pm.height);
              if (pm.opacity) $dragitem.css('opacity', parseFloat(pm.opacity / 255));
              if (pm.color) $dragitem.css('background-color', $.convertColor(pm.color));
              if (pm.zindex) $dragitem.css('z-index', pm.zindex);
              if (pm.hint) {
                $dragitem.attr({
                  title: pm.hint,
                  alt: pm.hint,
                });
              }

              // イベントのセット
              this.kag.event.addEventElement({
                tag: this.name,
                j_target: $dragitem,
                pm: _pm,
              });
              this.setEvent($dragitem, _pm);

              // 要素の追加
              j_target_layer.append($dragitem);

            });
          });
        }

        // ============================================
        // [droparea]で既存の画像を対象に取る場合
        // すでに[image][ptext]タグなどで場に出ている要素を効果対象に取る
        // ============================================

        if (this.name === "droparea" && target_exists) {

          // バラした各nameについて
          name_arr.forEach(name => {
            // そのnameで要素を取得 1つ1つドラッグ可能にしていく
            $(`.${name}`).each((i, droparea) => {
              const $droparea = $(droparea);

              // パラメータをクローン
              const _pm = $.extend({}, pm, {
                id: name,
              });

              // 画像を変更したあともとに戻せるように最初の画像ファイルを保存しておく
              if ($droparea.attr("src")) {
                _pm.originimg = $droparea.attr("src");
                _pm.graphic = _pm.originimg;
              }

              // 位置を変更したあともとに戻せるように最初の位置を保存しておく
              const left = $droparea.css("left");
              const top = $droparea.css("top");
              _pm.home_left = parseFloat(left);
              _pm.home_top = parseFloat(top);

              // その他の設定
              if (pm.width) $droparea.css('width', pm.width);
              if (pm.height) $droparea.css('height', pm.height);
              if (pm.opacity) $droparea.css('opacity', parseFloat(pm.opacity / 255));
              if (pm.color) $droparea.css('background-color', $.convertColor(pm.color));
              if (pm.zindex) $droparea.css('z-index', pm.zindex);
              if (pm.hint) {
                $droparea.attr({
                  title: pm.hint,
                  alt: pm.hint,
                });
              }

              // イベントのセット
              this.kag.event.addEventElement({
                tag: this.name,
                j_target: $droparea,
                pm: _pm,
              });
              this.setEvent($droparea, _pm);

              // 最初から子要素を含む場合
              if (initial_item) {
                dropItemIntoArea(initial_item, droparea);
                initial_item.__pm.home_area = pm.name;
              }

              // 要素の追加
              j_target_layer.append($droparea);

            });
          });
        }

        // ============================================
        // - [droparea]
        // - name指定がない場合
        // - graphic指定がある場合
        // ============================================

        else {

          // <img>または<div>で要素作成
          const tag_name = is_image ? 'img' : 'div';
          $elm = $(`<${tag_name} />`);
          if (is_image) $elm.attr('src', pm.graphic);
          $elm.css('position', 'absolute');

          // 座標を設定
          const x = pm.x || pm.left;
          const y = pm.y || pm.top;
          if (x) {
            $elm.css('left', x + 'px');
            pm.home_left = x;
          }
          if (y) {
            $elm.css('top', y + 'px');
            pm.home_top = y;
          }

          // いろいろ設定
          if (pm.width) $elm.css('width', pm.width);
          if (pm.height) $elm.css('height', pm.height);
          if (pm.opacity) $elm.css('opacity', parseFloat(pm.opacity / 255));
          if (pm.color) $elm.css('background-color', $.convertColor(pm.color));
          if (pm.zindex) $elm.css('z-index', pm.zindex);
          if (pm.hint) {
            $elm.attr({
              title: pm.hint,
              alt: pm.hint,
            });
          }

          pm.id = pm.name;
          // $elm.attr('id', pm.id);

          // クラスのセット
          $.setName($elm, pm.name);

          // イベントのセット
          this.kag.event.addEventElement({
            tag: this.name,
            j_target: $elm,
            pm: pm,
          });
          this.setEvent($elm, pm);

          // fixレイヤーに配置するならz-indexを調整する
          if (pm.layer === "fix") {
            $elm.css("z-index", "99999999").addClass("fixlayer");
          }

          if (initial_item) {
            dropItemIntoArea(initial_item, $elm.get(0));
            initial_item.__pm.home_area = pm.name;
          }

          // アニメーション
          if (time > 0) {
            $elm.css("opacity", "0").stop(true, true).animate({ opacity: 1 }, time, () => {
              if (is_wait) {
                TG.ftag.nextOrder();
              }
            });
          }

          // 要素の追加
          j_target_layer.append($elm);
        }

        // 次のタグへ
        if (!(time > 0 && is_wait)) {
          TG.ftag.nextOrder();
        }
      },

      setEvent($dragitem, pm) {
        // 元の Element の __pm プロパティに pm をぶち込んで参照できるようにする
        const dragitem = $dragitem.get(0);
        dragitem.__pm = pm;
        draggable(dragitem, pm);
      },
    };
    TG.tag["dragitem"] = TG.ftag.master_tag["dragitem"] = TAG_DRAGITEM;

    // ================================
    // [droparea] タグ定義
    // ================================

    const TAG_DROPAREA = {
      name: 'droparea',
      kag: TG,
      pm: {
        folder: 'image',
        layer: "free",
        zindex: "10",
        color: "",
      },
      start(pm) {
        log("[droparea]", pm);
        TG.ftag.master_tag["dragitem"].start.call(this, pm);
      },
      setEvent($droparea, pm) {
        const droparea = $droparea.get(0);
        droparea.__pm = pm;
        droppable(droparea, pm);
      },
    };
    TG.tag["droparea"] = TG.ftag.master_tag["droparea"] = TAG_DROPAREA;

    // ================================
    // [move_dragitem] タグ定義
    // ================================

    const TAG_MOVE_DRAGITEM = {
      name: 'move_dragitem',
      kag: TG,
      pm: {
        name: "",
        left: "",
        top: "",
        x: "",
        y: "",
        time: "0",
        area: "",
        wait: "true",
        easing: "jswing",
      },
      start(pm) {
        log("[move_dragitem]", pm);

        const time = parseInt(pm.time) || 0;
        let image_count = 0;

        //
        // 目標座標を計算
        //

        let css = {};
        let left = null;
        let top = null;
        if (pm.x !== "") {
          pm.left = pm.x;
        }
        if (pm.y !== "") {
          pm.top = pm.y;
        }
        if (pm.left !== "") {
          if (pm.left === "home") {
            left = "home";
          } else {
            left = parseInt(pm.left) || 0;
            left += "px";
          }
        }
        if (pm.top !== "") {
          if (pm.top === "home") {
            top = "home";
          } else {
            top = parseInt(pm.top) || 0;
            top += "px";
          }
        }
        if (left !== null) css.left = left;
        if (top !== null) css.top = top;

        //
        // nameを補正
        //

        if (!pm.name) {
          pm.name = CLASS_DRAGGABLE;
        }
        let name_arr;
        if (Array.isArray(pm.name)) {
          name_arr = pm.name;
        } else {
          name_arr = pm.name.split(",");
        }

        let move_count = 0;

        // バラした各nameについて
        name_arr.forEach(name => {
          // そのnameで要素を取得
          $(`.${name}`).each((i, dragitem) => {
            const $dragitem = $(dragitem);
            const _pm = dragitem.__pm;
            const _css = $.extend({}, css);

            if (_css.left === "home") {
              if (_pm.home_left) {
                _css.left = _pm.home_left + "px";
              } else {
                delete _css.left;
              }
            }

            if (_css.top === "home") {
              if (_pm.home_top) {
                _css.top = _pm.home_top + "px";
              } else {
                delete _css.top;
              }
            }

            if (!("left" in _css && "top" in _css)) {
              return;
            }

            const drop = () => {
              if (pm.area === "") {
                return;
              }
              if (pm.area === "none") {
                dropItemIntoArea(dragitem, null);
              } else {
                const $area = $(`.${pm.area}`);
                if ($area.length > 0) {
                  const area = $area.get(0);
                  if (area.__dragitemset) {
                    dropItemIntoArea(dragitem, area);
                  }
                }
              }
              log("Move To", dragitem.__droparea);
            };

            // 時間がほぼゼロの場合
            if (time < 10) {
              $dragitem.css(_css);
              drop();
            }
            // 時間が10ミリ秒以上の場合はアニメーションさせる
            else {
              image_count++;
              $dragitem.stop(true, true).animate(_css, time, pm.easing, () => {
                drop();
                move_count++;
                if (image_count === move_count) {
                  if (pm.wait === "true") {
                    TG.ftag.nextOrder();
                  }
                }
              });
            }
          });
        });

        // フェードアウト後にnextOrderが走る予定の場合はなにもしない
        if (pm.wait === "true" && time >= 10 && image_count > 0) {
          return;
        }
        // 通常はこのままnextOrderする
        else {
          TG.ftag.nextOrder();
        }
      },
    };
    TG.tag["move_dragitem"] = TG.ftag.master_tag["move_dragitem"] = TAG_MOVE_DRAGITEM;

    // ================================
    // [fix_dragitem] タグ定義
    // ================================

    const TAG_FIX_DRAGITEM = {
      name: 'fix_dragitem',
      kag: TG,
      pm: {
        name: "",
        layer: "",
        remove: "false",
        time: "0",
        wait: "true",
      },
      start(pm) {
        log("[fix_dragitem]", pm);

        const time = parseInt(pm.time) || 0;
        let image_count = 0;

        if (!pm.name) {
          pm.name = CLASS_DRAGGABLE;
        }

        if (pm.name) {
          let name_arr;
          if (Array.isArray(pm.name)) {
            name_arr = pm.name;
          } else {
            name_arr = pm.name.split(",");
          }

          let j_target_layer = null;
          if (pm.layer === "fix") {
            j_target_layer = $("#tyrano_base");
          } else if (pm.layer === "free") {
            j_target_layer = TG.layer.getFreeLayer();
          } else if (pm.layer || pm.layer === 0) {
            j_target_layer = TG.layer.getLayer(pm.layer);
          }

          let remove_count = 0;

          // バラした各nameについて
          name_arr.forEach(name => {
            // そのnameで要素を取得
            // 1つ1つドラッグ不可能にしていく
            $(`.${name}`).each((i, dragitem) => {
              const $dragitem = $(dragitem);

              // クラスや属性の調整、イベントハンドラの削除
              $dragitem
                .removeAttr('data-event-pm')
                .removeAttr('data-event-tag')
                .removeClass('event-setting-element')
                .removeClass(CLASS_DRAGGABLE);
              dragitem.__droparea = null;
              dragitem.__onDragStart = () => { };
              dragitem.__onDragEnd = () => { };
              dragitem.__onMouseEnter = () => { };
              dragitem.__onMouseLeave = () => { };

              // 通常のレイヤーに移動させる場合
              if (j_target_layer) {
                j_target_layer.append(dragitem);
              }

              // ついでに削除する場合
              if (pm.remove === "true") {
                // 時間がほぼゼロの場合
                if (time < 10) {
                  $dragitem.remove();
                }
                // 時間が10ミリ秒以上の場合はアニメーションさせる
                else {
                  image_count++;
                  $dragitem.stop(true, true).animate({ opacity: 0 }, time, () => {
                    $dragitem.remove();
                    remove_count++;
                    if (image_count === remove_count) {
                      if (pm.wait === "true") {
                        TG.ftag.nextOrder();
                      }
                    }
                  });
                }
              }
            });
          });
        }

        // フェードアウト後にnextOrderが走る予定の場合はなにもしない
        if (pm.wait === "true" && pm.remove === "true" && time >= 10 && image_count > 0) {
          return;
        }
        // 通常はこのままnextOrderする
        else {
          TG.ftag.nextOrder();
        }
      },
    };
    TG.tag["fix_dragitem"] = TG.ftag.master_tag["fix_dragitem"] = TAG_FIX_DRAGITEM;

    // ================================
    // [free_droparea]タグ定義
    // ================================

    const TAG_FIX_DROPAREA = {
      kag: TG,
      pm: {
        name: "",
        layer: "",
        remove: "",
        time: "0",
        wait: "true",
      },
      start(pm) {
        log("[free_droparea]", pm);

        const time = parseInt(pm.time) || 0;
        let image_count = 0;

        if (!pm.name) {
          pm.name = CLASS_DROPPABLE;
        }

        if (pm.name) {
          let name_arr;
          if (Array.isArray(pm.name)) {
            name_arr = pm.name;
          } else {
            name_arr = pm.name.split(",");
          }

          let j_target_layer = null;
          if (pm.layer === "fix") {
            j_target_layer = $("#tyrano_base");
          } else if (pm.layer === "free") {
            j_target_layer = TG.layer.getFreeLayer();
          } else if (pm.layer || pm.layer === 0) {
            j_target_layer = TG.layer.getLayer(pm.layer);
          }

          let remove_count = 0;

          // バラした各nameについて
          name_arr.forEach(name => {
            // そのnameで要素を取得
            // 1つ1つドラッグ不可能にしていく
            $(`.${name}`).each((i, droparea) => {
              const $droparea = $(droparea);

              // クラスや属性の調整、イベントハンドラの削除
              $droparea
                .removeAttr('data-event-pm')
                .removeAttr('data-event-tag')
                .removeClass('event-setting-element')
                .removeClass(CLASS_DROPPABLE);
              droparea.__dragitemset = null;
              droparea.__onItemDropped = () => { };
              droparea.__onItemEnter = () => { };
              droparea.__onItemLeave = () => { };

              // 通常のレイヤーに移動させる場合
              if (j_target_layer) {
                j_target_layer.append(droparea);
              }

              // ついでに削除する場合
              if (pm.remove === "true") {
                // 時間がほぼゼロの場合
                if (time < 10) {
                  $droparea.remove();
                }
                // 時間が10ミリ秒以上の場合はアニメーションさせる
                else {
                  image_count++;
                  $droparea.stop(true, true).animate({ opacity: 0 }, time, () => {
                    $droparea.remove();
                    remove_count++;
                    if (image_count === remove_count) {
                      if (pm.wait === "true") {
                        TG.ftag.nextOrder();
                      }
                    }
                  });
                }
              }
            });
          });
        }

        // フェードアウト後にnextOrderが走る予定の場合はなにもしない
        if (pm.wait === "true" && pm.remove === "true" && time >= 10 && image_count > 0) {
          return;
        }
        // 通常はこのままnextOrderする
        else {
          TG.ftag.nextOrder();
        }

      },
    };
    TG.tag["fix_droparea"] = TG.ftag.master_tag["fix_droparea"] = TAG_FIX_DROPAREA;

    // ================================
    // [free_draglayer]タグ定義
    // ================================

    const TAG_FREE_DRAGLAYER = {
      kag: TG,
      pm: {
        time: "0",
        wait: "true",
      },
      start(pm) {
        log("[free_draglayer]", pm);

        const time = parseInt(pm.time);

        // 時間が10ミリ秒未満なら即座にレイヤーを空にして次のタグに進んでよい
        if (time < 10) {
          j_dg_layer.empty();
          TG.ftag.nextOrder();
          return;
        }

        // 時間が10ミリ秒以上ならフェードアウトさせる
        // フェードアウト中はドラッグ操作を無効化する
        const is_drag_enabled = j_dg_layer.hasClass("drag-enabled");
        j_dg_layer.removeClass("drag-enabled");
        // フェードアウト開始
        j_dg_layer.stop(true, true).animate({ opacity: 0 }, time, () => {
          // フェードアウトが完了したら中身を空にして不透明度をもとに戻す
          j_dg_layer.empty();
          j_dg_layer.css("opacity", "");
          // ドラッグ操作の無効有効を復元する
          if (is_drag_enabled) {
            j_dg_layer.addClass("drag-enabled");
          }
          if (pm.wait === "true") {
            TG.ftag.nextOrder();
          }
        });
        if (pm.wait !== "true") {
          TG.ftag.nextOrder();
        }

      },
    };
    TG.tag["free_draglayer"] = TG.ftag.master_tag["free_draglayer"] = TAG_FREE_DRAGLAYER;

    // ================================
    // [free_dragitem]タグ定義
    // ================================

    const TAG_FREE_DRAGITEM = {
      kag: TG,
      pm: {
        time: "0",
        wait: "true",
        remove: "true",
      },
      start(pm) {
        log("[free_dragitem]", pm);

        TG.ftag.master_tag["fix_dragitem"].start.call(this, pm);
      },
    };
    TG.tag["free_dragitem"] = TG.ftag.master_tag["free_dragitem"] = TAG_FREE_DRAGITEM;

    // ================================
    // [free_droparea]タグ定義
    // ================================

    const TAG_FREE_DROPAREA = {
      kag: TG,
      pm: {
        layer: "",
        time: "0",
        wait: "true",
        remove: "true",
      },
      start(pm) {
        log("[free_droparea]", pm);

        TG.ftag.master_tag["fix_droparea"].start.call(this, pm);
      },
    };
    TG.tag["free_droparea"] = TG.ftag.master_tag["free_droparea"] = TAG_FREE_DROPAREA;

    // ================================
    // [stop_draglayer] タグ定義
    // ================================
    //
    // ドラッグ操作をいったん無効化しテキストを進められるようにするタグ

    const TAG_STOP_DRAG = {
      kag: TG,
      pm: {},
      start(pm) {
        log("[stop_draglayer]", pm);

        // drag-enabledクラスを外す
        j_dg_layer.removeClass("drag-enabled");

        TG.ftag.nextOrder();
      },
    };
    TG.tag["stop_draglayer"] = TG.ftag.master_tag["stop_draglayer"] = TAG_STOP_DRAG;

    // ================================
    // [start_draglayer] タグ定義
    // ================================

    const TAG_START_DRAG = {
      kag: TG,
      pm: {},
      start(pm) {
        log("[start_draglayer]", pm);

        // drag-enabledクラスを付与
        j_dg_layer.addClass("drag-enabled");

        TG.ftag.nextOrder();
      },
    };
    TG.tag["start_draglayer"] = TG.ftag.master_tag["start_draglayer"] = TAG_START_DRAG;

    // ================================
    // [dragitem_config]タグ定義
    // ================================

    const TAG_DRAGITEM_CONFIG = {
      kag: TG,
      pm: {

      },
      start(pm) {
        log("[dragitem_config]", pm);

        if (pm.dragitem_bg) {
          css_manager.addRule(SELECTOR_DRAGGABLE, { background: pm.dragitem_bg });
        }

        if (pm.droparea_bg) {
          css_manager.addRule(SELECTOR_DROPPABLE, { background: pm.droparea_bg });
        }

        if (pm.enter_cursor) {
          css_manager.addRule(SELECTOR_DRAGGABLE, { cursor: pm.enter_cursor });
        }
        if (pm.drag_cursor) {
          css_manager.addRule(SELECTOR_DRAGGING, { cursor: pm.drag_cursor });
        }


        //
        // brightness
        //

        if (pm.enter_brightness) {
          css_manager.addRule(SELECTOR_HOVERING, { filter: `brightness(${pm.enter_brightness})` });
        }

        if (pm.drag_brightness) {
          css_manager.addRule(SELECTOR_DRAGGING, { filter: `brightness(${pm.drag_brightness})` });
        }

        if (pm.droppable_brightness) {
          css_manager.addRule(SELECTOR_DROPPING, { filter: `brightness(${pm.droppable_brightness})` });
        }

        if (pm.drop_brightness) {
          css_manager.addRule(SELECTOR_DROPPED, { filter: `brightness(${pm.drop_brightness})` });
        }

        //
        // transform
        //

        if (pm.enter_scale) {
          css_manager.addRule(SELECTOR_HOVERING, { transform: `scale(${pm.enter_scale})` });
        }

        if (pm.drag_scale) {
          css_manager.addRule(SELECTOR_DRAGGING, { transform: `scale(${pm.drag_scale})` });
        }

        if (pm.droppable_scale) {
          css_manager.addRule(SELECTOR_DROPPING, { transform: `scale(${pm.droppable_scale})` });
        }

        if (pm.drop_scale) {
          css_manager.addRule(SELECTOR_DROPPED, { transform: `scale(${pm.drop_scale})` });
        }

        TG.ftag.nextOrder();
      },
    };
    TG.tag["dragitem_config"] = TG.ftag.master_tag["dragitem_config"] = TAG_DRAGITEM_CONFIG;

  })(TYRANO.kag);
