;----------------------------------------------------------------------
;
;  Tagged Image File Format (TIFF) Output File Plotter Configuration file
;
;  Current Revision:
;  $RCSfile: tiff.plt,v $
;  $Revision: 7.12.4.6 $  $Date: 2004/02/06 20:55:47 $
;
;----------------------------------------------------------------------

;======================================================================
;
;   >>>>> WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  <<<<<
;  
;  Plotter driver configuration files are now stored in two directories:
;
;    $(_USTN_WORKSPACEROOT)/System/plotdrv/
;    $(_USTN_WORKSPACEROOT)/Standards/plotdrv/
;
;  System/plotdrv/ should be reserved for .plt files delivered by
;  MicroStation and other Bentley products. Standards/plotdrv/ is
;  provided as a place for you to store customized .plt files. To
;  simplify plotter selection from the Plot dialog, you may also
;  elect to store frequently-used .plt files in Standards/plotdrv/
;  even if you do not customize them.
;
;  To minimize the risk of losing your changes during a product
;  reinstallation, do not edit the files in the System/plotdrv/
;  directory. Instead, copy the necessary files to Standards/plotdrv/
;  and edit them there. If the .plt file depends on other files, such
;  as PostScript prolog (*.pro) files, copy them to the same directory.
;
;======================================================================

num_pens   = 255                ; required record, must precede any "pen" records.
change_pen = both               ; options are color, weight, level or both
model      = MDL		; plotter model number
driver     = lorip	    	; MDL driver to use
autocenter			; Automatically center plot on page

; Refer to the documentation for available border qualifiers.
; Note that only the border outline is supported in this driver.
;border 

default_extension = 'tif'   	; default extension for plotfiles
;
; To configure a default output file name comment out the default_extension
; line above and uncomment this line.  "c:\tmp\color256.tif" may be substituted
; with any desired filename - e.g. "$(MS_PLTFILES)plotfile.000"
;
;default_outFile/auto_overwrite = "c:\tmp\color256.tif"

size=(100,100)/off=(0,0)/name=max     ; Mandatory form name for Publisher
size=(80,64)/off=(0,0)/name=1280x1024 ; leave room for border and border text
size=(64,48)/off=(0,0)/name=1024x768  ; leave room for border and border text
size=(50,37.5)/off=(0,0)/name=800x600    ; leave room for border and border text
size=(40,30)/off=(0,0)/name=640x480    ; leave room for border and border text
resolution(IN)=(0.0625, 0.0625)		; 50 inches / 800 dots == 16 dpi

; Substitute the name of a pentable file to be loaded when this driver is selected
;pentable=\dir\file.tbl

; Stroke_tolerance determines tolerance for arcs and circles.  Value is
; between 0 and 10 with 10 being the tightest tolerance.  Larger values
; also create larger plot files.
stroke_tolerance=10

;
;  Pen 0 is the 'background' pen.  Other pens get their color by default from
;  the corresponding color in the current design file color table.  The background
;  pen instead defaults to white.  To have the background pen get it's value from
;  the master file color table, we assign it an RGB of(-1, -1, -1).
;
pen(0)=/rgb=(-1, -1, -1)    ; get background pen color from master file background color

; Format = 3 tells the lorip driver to generate a TIFF file.
; Quality identifies the type of compression
quality=1     ; Default compression
raster_compression/format=3/methods=(0)

;  The style records define how the design file line codes (styles)
;  are to be plotted.  Values are in plotter units (units of device resolution).
;  Values determine pen down/up movements, where (10,28) for a dot
;  pattern leaves the pen down for 10 units and up for 28 units.  The
;  /nohardware switch causes software stroking with these values.

style(1)=(1, 6)		    	/nohardware     ;style = dot
style(2)=(6, 4)		    	/nohardware     ;style = med dash
style(3)=(10, 4)	    	/nohardware     ;style = long dash
style(4)=(8, 4, 1, 4)    	/nohardware     ;style = dot-dash
style(5)=(3, 4)		    	/nohardware     ;style = short dash
style(6)=(1, 4, 7, 4, 1, 4)	/nohardware     ;style = dash-dot-dot
style(7)=(9, 4, 3, 4)     	/nohardware     ;style = long dash - short dash

;  The weight line determines the number of strokes to use with each weight.
;  The first position defines weight 0, second weight 1, third weight 2 and
;  so on up to weight 31. To increase or decrease the number of plotter units per
;  weight, change the number in that position.

weight_strokes=(1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15,16,16)

; Construction/active points are plotted by default. Comment out the next line
; if you do not want points plotted.
point_size = .35

largest_polygon=20000

; The pen_width record determines how far the pen moves when drawing
; thick lines (weights) or when used to fill elements.  Since this is
; a rasterizing plotter driver, we want to move the pen 1 plotter coordinate
; (1 pixel).
pen_width(1)=1
pen_width(2)=1
pen_width(3)=1
pen_width(4)=1
pen_width(5)=1
pen_width(6)=1
pen_width(7)=1
pen_width(8)=1
pen_width(9)=1
pen_width(10)=1
pen_width(11)=1
pen_width(12)=1
pen_width(13)=1
pen_width(14)=1
pen_width(15)=1
pen_width(16)=1
pen_width(17)=1
pen_width(18)=1
pen_width(19)=1
pen_width(20)=1
pen_width(21)=1
pen_width(22)=1
pen_width(23)=1
pen_width(24)=1
pen_width(25)=1
pen_width(26)=1
pen_width(27)=1
pen_width(28)=1
pen_width(29)=1
pen_width(30)=1
pen_width(31)=1
pen_width(32)=1
pen_width(33)=1
pen_width(34)=1
pen_width(35)=1
pen_width(36)=1
pen_width(37)=1
pen_width(38)=1
pen_width(39)=1
pen_width(40)=1
pen_width(41)=1
pen_width(42)=1
pen_width(43)=1
pen_width(44)=1
pen_width(45)=1
pen_width(46)=1
pen_width(47)=1
pen_width(48)=1
pen_width(49)=1
pen_width(50)=1
pen_width(51)=1
pen_width(52)=1
pen_width(53)=1
pen_width(54)=1
pen_width(55)=1
pen_width(56)=1
pen_width(57)=1
pen_width(58)=1
pen_width(59)=1
pen_width(60)=1
pen_width(61)=1
pen_width(62)=1
pen_width(63)=1
pen_width(64)=1
pen_width(65)=1
pen_width(66)=1
pen_width(67)=1
pen_width(68)=1
pen_width(69)=1
pen_width(70)=1
pen_width(71)=1
pen_width(72)=1
pen_width(73)=1
pen_width(74)=1
pen_width(75)=1
pen_width(76)=1
pen_width(77)=1
pen_width(78)=1
pen_width(79)=1
pen_width(80)=1
pen_width(81)=1
pen_width(82)=1
pen_width(83)=1
pen_width(84)=1
pen_width(85)=1
pen_width(86)=1
pen_width(87)=1
pen_width(88)=1
pen_width(89)=1
pen_width(90)=1
pen_width(91)=1
pen_width(92)=1
pen_width(93)=1
pen_width(94)=1
pen_width(95)=1
pen_width(96)=1
pen_width(97)=1
pen_width(98)=1
pen_width(99)=1
pen_width(100)=1
pen_width(101)=1
pen_width(102)=1
pen_width(103)=1
pen_width(104)=1
pen_width(105)=1
pen_width(106)=1
pen_width(107)=1
pen_width(108)=1
pen_width(109)=1
pen_width(110)=1
pen_width(111)=1
pen_width(112)=1
pen_width(113)=1
pen_width(114)=1
pen_width(115)=1
pen_width(116)=1
pen_width(117)=1
pen_width(118)=1
pen_width(119)=1
pen_width(120)=1
pen_width(121)=1
pen_width(122)=1
pen_width(123)=1
pen_width(124)=1
pen_width(125)=1
pen_width(126)=1
pen_width(127)=1
pen_width(128)=1
pen_width(129)=1
pen_width(130)=1
pen_width(131)=1
pen_width(132)=1
pen_width(133)=1
pen_width(134)=1
pen_width(135)=1
pen_width(136)=1
pen_width(137)=1
pen_width(138)=1
pen_width(139)=1
pen_width(140)=1
pen_width(141)=1
pen_width(142)=1
pen_width(143)=1
pen_width(144)=1
pen_width(145)=1
pen_width(146)=1
pen_width(147)=1
pen_width(148)=1
pen_width(149)=1
pen_width(150)=1
pen_width(151)=1
pen_width(152)=1
pen_width(153)=1
pen_width(154)=1
pen_width(155)=1
pen_width(156)=1
pen_width(157)=1
pen_width(158)=1
pen_width(159)=1
pen_width(160)=1
pen_width(161)=1
pen_width(162)=1
pen_width(163)=1
pen_width(164)=1
pen_width(165)=1
pen_width(166)=1
pen_width(167)=1
pen_width(168)=1
pen_width(169)=1
pen_width(170)=1
pen_width(171)=1
pen_width(172)=1
pen_width(173)=1
pen_width(174)=1
pen_width(175)=1
pen_width(176)=1
pen_width(177)=1
pen_width(178)=1
pen_width(179)=1
pen_width(180)=1
pen_width(181)=1
pen_width(182)=1
pen_width(183)=1
pen_width(184)=1
pen_width(185)=1
pen_width(186)=1
pen_width(187)=1
pen_width(188)=1
pen_width(189)=1
pen_width(190)=1
pen_width(191)=1
pen_width(192)=1
pen_width(193)=1
pen_width(194)=1
pen_width(195)=1
pen_width(196)=1
pen_width(197)=1
pen_width(198)=1
pen_width(199)=1
pen_width(200)=1
pen_width(201)=1
pen_width(202)=1
pen_width(203)=1
pen_width(204)=1
pen_width(205)=1
pen_width(206)=1
pen_width(207)=1
pen_width(208)=1
pen_width(209)=1
pen_width(210)=1
pen_width(211)=1
pen_width(212)=1
pen_width(213)=1
pen_width(214)=1
pen_width(215)=1
pen_width(216)=1
pen_width(217)=1
pen_width(218)=1
pen_width(219)=1
pen_width(220)=1
pen_width(221)=1
pen_width(222)=1
pen_width(223)=1
pen_width(224)=1
pen_width(225)=1
pen_width(226)=1
pen_width(227)=1
pen_width(228)=1
pen_width(229)=1
pen_width(230)=1
pen_width(231)=1
pen_width(232)=1
pen_width(233)=1
pen_width(234)=1
pen_width(235)=1
pen_width(236)=1
pen_width(237)=1
pen_width(238)=1
pen_width(239)=1
pen_width(240)=1
pen_width(241)=1
pen_width(242)=1
pen_width(243)=1
pen_width(244)=1
pen_width(245)=1
pen_width(246)=1
pen_width(247)=1
pen_width(248)=1
pen_width(249)=1
pen_width(250)=1
pen_width(251)=1
pen_width(252)=1
pen_width(253)=1
pen_width(254)=1
pen_width(255)=1


; The following options control printing of Raster Manager images.
; Refer to the "Printing Using Raster Manager" section of the documentation
; for descriptions of these records.

software_raster/resolution=16/background=black

PIXEL_RESOLUTION    = 16
GRAYSCALE           = 0
BACKGROUND          = 2
CONTRAST            = 50
BRIGHTNESS          = 50
NO_RASTERREF        = 0

; The following record specifies whether type 87/88 raster elements are printed.
; This record is ignored by Raster Manager. 
NO_DGNRASTER = 0 ; 0=plot, 1=don't plot (the default is to plot).
