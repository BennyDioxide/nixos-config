{ ... }:

{
  users.groups.uinput.members = ["benny"];
	services.kanata = {
		enable = true;

		keyboards.colemak-dh-extend-ansi = {
		  port = 6674;
			devices = [
				"/dev/input/by-id/usb-Micro-Star_INT_L_CO.__LTD._MSI_GK50_ELITE_Gaming_Keyboard-event-kbd"
				"/dev/input/by-id/usb-_RPI_Wired_Keyboard_4-event-kbd"
			];
			extraDefCfg = "delegate-to-first-layer yes";
			config = ''
(defsrc
;;esc     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12
  grv     1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab     q    w    e    r    t    y    u    i    o    p    [    ]    \
  caps    a    s    d    f    g    h    j    k    l    ;    '    ret
  lsft      z    x    c    v    b    n    m    ,    .    /    rsft
  lctl    lmet lalt           spc            ralt rmet cmp  rctl
)

(defalias
  ext  (layer-toggle extend) ;; Bind 'ext' to the Extend Layer
  sym  (layer-toggle symbols) ;; Bind 'sym' to Symbols Layer
)

(defalias
  cpy C-c
  pst C-v
  cut C-x
  udo C-z
  all C-a
  fnd C-f
  £ S-3  ;;UK pound sign
)

(deflayer qwerty
  grv     1    2    3    4    5    6    7    8    9    0    -    =    bspc
  lalt    q    w    e    r    t    y    u    i    o    p    [    ]    \
  lctl    a    s    d    f    g    h    j    k    l    ;    '    ret
  lsft      z    x    c    v    b    n    m    ,    .    /    rsft
  _       lmet @ext           spc            @sym rmet cmp  rctl
)

(deflayer colemak-dh
;;esc     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12
  grv      1    2    3    4    5    6    7    8    9    0    -    =    bspc
  lalt   q    w    f    p    b    j    l    u    y    ;    [    ]    \
  lctl     a    r    s    t    g    m    n    e    i    o    '    ret
  lsft      x    c    d    v    z    k    h    ,    .    /    rsft
  _        lmet @ext           spc            @sym rmet _    _
)

(deflayer extend
;;_        pp rewind previoussong nextsong ejectcd refresh brdn brup www mail prog1 prog2
  _        f1   f2   f3   f4   f5   f6   f7   f8   f9  f10   f11  f12  ret
  _        esc  mbck @fnd mfwd ins  pgup home up   end  menu prnt slck _
  _        @all tab  lsft lctl lalt pgdn lft  down rght del  caps _
  _          @cut @cpy @pst @pst @udo pgdn bks  f13  f14  comp _
  _        _    _              ret            _    _    _    _
)

(defalias
	xcl S-1
	at  S-2
	shp S-3
	dlr S-4
	pct S-5
	crt S-6
	and S-7
	ast S-8
	lbc S-9
	rbc S-0
	usc S-min
)

(deflayer symbols
;;_        _    _    _    _    _    _    _    _    _    _    _    _
  _        _    _    _    _    _    _    _    _    _    _    _    _    _
  _        @xcl @at  @shp @dlr @pct eql  7    8    9    +    _ _ #|«    »|#    _
  _        @usc [    S-[  @lbc @crt @ast 4    5    6    -    _    _
  _          ]    S-]  @rbc @and grv   0    1    2    3    \    _
  _        _    _              _              _    _    _    _
)

(deflayer naginata
;;_        _    _    _    _    _    _    _    _    _    _    _    _
  _        _    _    _    _    _    _    _    _    _    _    _    _    _
  _        _    _    _    _    _    _    _    _    _    _    _    _    _
  _        _    _    _    _    _    _    _    _    _    _    _    _
  _          _    _    _    _    _    _    _    _    _    _    _
  _        _    _              _              _    _    _    _
)

(deflayer empty
;;_        _    _    _    _    _    _    _    _    _    _    _    _
  _        _    _    _    _    _    _    _    _    _    _    _    _    _
  _        _    _    _    _    _    _    _    _    _    _    _    _    _
  _        _    _    _    _    _    _    _    _    _    _    _    _
  _          _    _    _    _    _    _    _    _    _    _    _
  _        _    _              _              _    _    _    _
)
			'';
		};
	};
}
