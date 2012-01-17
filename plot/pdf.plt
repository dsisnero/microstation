;----------------------------------------------------------------------
;
;  Portable Document file (PDF) Plotter Driver Configuration file
;
;  Current Revision:
;  $RCSfile: pdf.plt,v $
;  $Revision: 1.1.2.16.2.1 $  $Date: 2004/03/23 21:07:42 $
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
; Construction/active points are plotted by default. Comment out the next line
; if you do not want points plotted.

point_size          = 0.03
default_extension   = 'pdf'       ; default extension for plotfiles
document_set
model               = mdl
driver              = pdf
autocenter                      ; Automatically center plot on page

num_pens = 255 ; required record, must precede any "pen" records.
change_pen = both

; Remove this record if no border is desired.
; Refer to the documentation for available border qualifiers.
border /filename /time /text_height=0.35

; Substitute the name of a pentable file to be loaded when this driver is selected
;pentable=\dir\file.tbl

;=================================================================
;Turn the Book Marks on and off
CmdName /appname="pdf" /command="BookMarks" /qualifier="On"
;CmdName /appname="pdf" /command="BookMarks" /qualifier="Off"
;on by default
;=================================================================

;=================================================================
;Turn the Level/File optional content on and off
;CmdName /appname="pdf" /command="FileOptionalContent" /qualifier="On"
CmdName /appname="pdf" /command="FileOptionalContent" /qualifier="Off"
;off by default
;=================================================================

;=================================================================
;Turn Engineering links on and off
CmdName /appname="pdf" /command="EngineeringLinks" /qualifier="On"
;CmdName /appname="pdf" /command="EngineeringLinks" /qualifier="Off"
;on by default
;=================================================================

;=================================================================
;pick the version of pdf you want to support
CmdName /appname="pdf" /command="version" /qualifier="Acrobat 6 (PDF 1.5)/Viewable in Acrobat 5"
;CmdName /appname="pdf" /command="version" /qualifier="Acrobat 6 (PDF 1.5)"
;CmdName /appname="pdf" /command="version" /qualifier="Acrobat 5 (PDF 1.4)"
;=================================================================

;=================================================================
;uncomment the line and change the qualifier to your password
;if you wish to protect the output pdf file.
;NOTE the pdf file will not view with out the password
;But then is unprotected
;CmdName /appname="pdf" /command="userpassword" /qualifier="my_password"
;=================================================================

;=================================================================
;RGB Raster compression
;CmdName /appname="pdf" /command="RGBRasterCompression" /qualifier="jpeg"
CmdName /appname="pdf" /command="RGBRasterCompression" /qualifier="zipped"
;zipped by default
;=================================================================

;=================================================================
;Searchable Text
CmdName /appname="pdf" /command="SearchableText" /qualifier="on"
;CmdName /appname="pdf" /command="SearchableText" /qualifier="off"
;on by default
;=================================================================


; ENGLISH resolution and SIZE records
size=(44,34)/num=0/off=(0,0)/name="ANSI E"
size=(34,22)/num=0/off=(0,0)/name="ANSI D"
size=(22,17)/num=0/off=(0,0)/name="ANSI C"
size=(17,11)/num=0/off=(0,0)/name="ANSI B"
size=(11,8.5)/num=0/off=(0,0)/name="ANSI A"
resolution(IN)=(0.001666666666666666666667,0.001666666666666666666667) ;600DPI

; METRIC resolution and SIZE records
;size=(1189,841)/num=0/off=(0,0)/name="ISO A0"
;size=(841,594)/num=0/off=(0,0)/name="ISO A1"
;size=(594,420)/num=0/off=(0,0)/name="ISO A2"
;size=(420,297)/num=0/off=(0,0)/name="ISO A3"
;size=(297,210)/num=0/off=(0,0)/name="ISO A4"
;resolution(MM)=(0.04233333333333333333333,0.04233333333333333333333); 600DPI

;  The style records define how the design file line codes (styles)
;  are to be plotted.  Values are in plotter units (resolutions).
;  Values determine pen down/up movements, where (10,28) for a dot
;  pattern leaves the pen down for 10 units and up for 28 units.  The
;  /nohardware switch causes software stroking with these values.
; This example has the /nohardware option commented
; out, so the printer will draw the styles.

style(1)=(18, 18)                  ;/nohardware     ;style = dot
style(2)=(37, 37)                  ;/nohardware     ;style = med dash
style(3)=(75, 75)                  ;/nohardware     ;style = long dash
style(4)=(75, 37, 18, 37)          ;/nohardware     ;style = dot-dash
style(5)=(27, 27)                  ;/nohardware     ;style = short dash
style(6)=(75, 37, 18, 37, 18, 37)  ;/nohardware     ;style = dash-dot-dot
style(7)=(75, 27, 32, 27)          ;/nohardware     ;style = long dash - short dash

stroke_tolerance=9.0
largest_polygon=200000
linecap     = 0                 ; 0=butt, 1=round, 2=square
linejoin    = 0                 ; 0=mitered, 1=round, 2=bevel
miter_limit = 3.0               ; larger values mean longer spikes
                                ; 1=none, 1.415=90deg, 2=60deg, 10=11deg etc.

; Specify the mapping of MicroStation line weights to line thickness on paper.
; Units are MM, IN, or DOTS (the default)

weight_strokes(mm)=(0.250, 0.375, 0.500, 0.625, 0.750, 0.875, 1.000, 1.125, \
                    1.250, 1.375, 1.500, 1.625, 1.750, 1.875, 2.000, 2.125, \
                    2.250, 2.375, 2.500, 2.625, 2.750, 2.875, 3.000, 3.125, \
                    3.250, 3.375, 3.500, 3.625, 3.750, 3.875, 4.000, 4.125)



; The following options control raster plotting.
isv_raster=1            ; Plots the raster image,  1=On 0=Off   Default=1
pixel_resolution=300    ; Resolution of pixels on output (dpi)  Default=300
contrast=50             ; Contrast in percent, between 0-100    Default=50
brightness=50           ; Brightness in percent, between 0-100  Default=50
raster_fence=1          ; Clip the raster to fence, 1=On 0=Off  Default=1
grayscale=0             ; Plot in gray scale,  1=On 0=Off       Default=0
no_dgnraster=0          ; MS plot of 87/88, 1=Don't plot 0=Plot Default=0
background = 0          ; 0=white,1=black,2=color               Default=0
no_rasterref=0          ; MS plot of 90's,  1=Don't plot 0=Plot Default=0
