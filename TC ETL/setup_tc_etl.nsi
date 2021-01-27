; Todo
; Ask if user wants to leave etkey.
; Delete unrequired files in installation folder.
; Uninstaler supose to close all installed apps before uninstall.
; Review maps.

Unicode True

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "True Combat ETL"
!define PRODUCT_SHORT "TC"
!define PRODUCT_TCE "TCE"
!define PRODUCT_CQB "CQB"
!define PRODUCT_ENGINE "ETL"
!define SERVER_INGA "Inga"
!define PRODUCT_VERSION "1.0.3"
!define PRODUCT_PUBLISHER "Aivaras Kasperaitis"
!define PRODUCT_WEB_SITE "http://www.truecombatelite.com"
!define WEB_SITE_NAME "True Combat Elite and CQB Lithuania"
!define INSTALLER_WEB_SITE "http://tc.garagegame.eu"
!define IP_ADDRESS "78.57.195.107"

!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\etl.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; Branding text
BrandingText "True Combat ETL"

; MUI
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING


; MUI Settings / Icons
;!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install-full.ico"
!define MUI_ICON "icons\tc.ico"
!define MUI_UNICON "icons\tc.ico"

; MUI Settings / Wizard
!define MUI_WELCOMEFINISHPAGE_BITMAP "images\installer.bmp"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "images\installer.bmp"

; MUI Settings / Header
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP "images\installer-r.bmp"
!define MUI_HEADERIMAGE_UNBITMAP "images\installer-r.bmp"


; Welcome page
!insertmacro MUI_PAGE_WELCOME

; License pages
!define MUI_LICENSEPAGE_TEXT_TOP "Please review the license terms before installing Enemy Territory: Legacy"
!define MUI_LICENSEPAGE_TEXT_BOTTOM "If you accept the terms of the agreement, click I Agree to continue. You must accept the agreement to install Enemy Territory: Legacy"
!insertmacro MUI_PAGE_LICENSE "licence\etl.txt"

!define MUI_LICENSEPAGE_TEXT_TOP "Please review the license terms before installing Wolfenstein: Enemy Territory Assets"
!define MUI_LICENSEPAGE_TEXT_BOTTOM "If you accept the terms of the agreement, click I Agree to continue. You must accept the agreement to install Wolfenstein: Enemy Territory Assets"
!insertmacro MUI_PAGE_LICENSE "licence\wet.txt"

!define MUI_LICENSEPAGE_TEXT_TOP "Please review the license terms before installing True Combat: Elite"
!define MUI_LICENSEPAGE_TEXT_BOTTOM "If you accept the terms of the agreement, click I Agree to continue. You must accept the agreement to install True Combat: Elite"
!insertmacro MUI_PAGE_LICENSE "licence\tce.txt"

!define MUI_LICENSEPAGE_TEXT_TOP "Please review the license terms before installing True Combat: Close Quarters Battle"
!define MUI_LICENSEPAGE_TEXT_BOTTOM "If you accept the terms of the agreement, click I Agree to continue. You must accept the agreement to install True Combat: Close Quarters Battle"
!insertmacro MUI_PAGE_LICENSE "licence\cqb.txt"

; Components page
!insertmacro MUI_PAGE_COMPONENTS
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
;!insertmacro MUI_PAGE_STARTMENU "Application" $StartMenuFolder
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES

; Finish page
; !define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
; !define MUI_FINISHPAGE_SHOWREADME "licence\readme.txt"
; !define MUI_FINISHPAGE_RUN "$INSTDIR\et.exe"
; !define MUI_FINISHPAGE_RUN_PARAMETERS "+set fs_game tcetest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set r_primitives 2 +connect ${IP_ADDRESS}:27971"

!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_FUNCTION RunTCE

Function RunTCE
SetOutPath $INSTDIR
Exec '"$INSTDIR\etl.exe" +set fs_game tcetest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\TCETL$\"'
FunctionEnd

!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_WELCOME
;!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH


; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------


Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
Caption "True Combat ETL"
OutFile "setup_tc_etl_${PRODUCT_VERSION}.exe"
InstallDir "$PROGRAMFILES\True Combat ETL"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""


;Request application privileges for Windows 7
RequestExecutionLevel admin


XPStyle on
WindowIcon on


Function .onInit
	# the plugins dir is automatically deleted when the installer exits

	InitPluginsDir
	File /oname=$PLUGINSDIR\splash.bmp "splash\splash.bmp"

	#optional
	File /oname=$PLUGINSDIR\splash.wav "splash\splash.wav"

	advsplash::show 4000 600 400 -1 $PLUGINSDIR\splash

	Pop $0	;	$0 has '1' if the user closed the splash screen early,
        	;	'0' if everything closed normally, and '-1' if some error occurred.

	Delete $PLUGINSDIR\splash.bmp
	Delete $PLUGINSDIR\splash.waw

	; Unistall old version
	Exec $INSTDIR\uninstall.exe

FunctionEnd


Section "ETL. TCE. CQB."  TC

SectionIn 1 RO
SetOutPath "$INSTDIR"
SetOverwrite try
; Put file there
File /r "files\*"

inetc::get /NOCANCEL "http://tc.garagegame.eu/files/wet/pak0.pk3" "$INSTDIR\etmain\pak0.pk3" /end
inetc::get /NOCANCEL "http://tc.garagegame.eu/files/wet/pak1.pk3" "$INSTDIR\etmain\pak1.pk3" /end
inetc::get /NOCANCEL "http://tc.garagegame.eu/files/wet/pak2.pk3" "$INSTDIR\etmain\pak2.pk3" /end

SectionEnd


Section "Desktop Shortcuts"  DESKTOP
SectionIn 2
SetOutPath "$INSTDIR"
SetOverwrite try

; Desktop Shortcuts
CreateShortCut "$DESKTOP\${PRODUCT_TCE} ${PRODUCT_ENGINE}.lnk" "$INSTDIR\etl.exe" "+set fs_game tcetest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\TCETL$\"" "$INSTDIR\tce.ico" 0 "" ""
CreateShortCut "$DESKTOP\${PRODUCT_CQB} ${PRODUCT_ENGINE}.lnk" "$INSTDIR\etl.exe" "+set fs_game cqbtest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set s_khz 44 +set r_maxpolyverts 16384 +set r_maxpolys 4096 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\TCETL$\"" "$INSTDIR\cqb.ico" 0 "" ""

SectionEnd


Section "Inga Servers Package"  INGAMAPS
SectionIn 3
;SetOutPath "$INSTDIR\tcetest"
;SetOverwrite try
;File "maps\*.*"

SetOutPath "$DOCUMENTS\TCETL\tcetest"
SetOverwrite try
inetc::get /NOCANCEL "http://tc.garagegame.eu/files/maps/ingamaps.7z" "$DOCUMENTS\TCETL\tcetest\ingamaps.7z" /end
Nsis7z::ExtractWithDetails "maps.7z" "Extracting maps %s..."
Delete "$OUTDIR\ingamaps.7z"

SetOutPath "$INSTDIR"

CreateShortCut "$DESKTOP\${SERVER_INGA} ${PRODUCT_ENGINE} ${PRODUCT_TCE} BC.lnk" "$INSTDIR\etl.exe" "+set fs_game tcetest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\TCETL$\" +connect ${IP_ADDRESS}:27971" "$INSTDIR\tce.ico" 0 "" ""
CreateShortCut "$DESKTOP\${SERVER_INGA} ${PRODUCT_ENGINE} ${PRODUCT_TCE} OBJ.lnk" "$INSTDIR\etl.exe" "+set fs_game tcetest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\TCETL$\" +connect ${IP_ADDRESS}:27972" "$INSTDIR\tce.ico" 0 "" ""
CreateShortCut "$DESKTOP\${SERVER_INGA} ${PRODUCT_ENGINE} ${PRODUCT_CQB} BC.lnk" "$INSTDIR\etl.exe" "+set fs_game cqbtest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set s_khz 44 +set r_maxpolyverts 16384 +set r_maxpolys 4096 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\TCETL$\" +connect ${IP_ADDRESS}:27979" "$INSTDIR\cqb.ico" 0 "" ""

CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${SERVER_INGA} ${PRODUCT_ENGINE} ${PRODUCT_TCE} BC.lnk" "$INSTDIR\etl.exe" "+set fs_game tcetest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\TCETL$\" +connect ${IP_ADDRESS}:27971" "$INSTDIR\tce.ico" 0 "" ""
CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${SERVER_INGA} ${PRODUCT_ENGINE} ${PRODUCT_TCE} OBJ.lnk" "$INSTDIR\etl.exe" "+set fs_game tcetest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\TCETL$\" +connect ${IP_ADDRESS}:27972" "$INSTDIR\tce.ico" 0 "" ""
CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${SERVER_INGA} ${PRODUCT_ENGINE} ${PRODUCT_CQB} BC.lnk" "$INSTDIR\etl.exe" "+set fs_game cqbtest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set s_khz 44 +set r_maxpolyverts 16384 +set r_maxpolys 4096 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\TCETL$\" +connect ${IP_ADDRESS}:27979" "$INSTDIR\cqb.ico" 0 "" ""
SectionEnd


Section -AdditionalIcons

SetOutPath "$INSTDIR"

; Startmenu Shortcuts
CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_TCE} ${PRODUCT_ENGINE}.lnk" "$INSTDIR\etl.exe" "+set fs_game tcetest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\TCETL$\"" "$INSTDIR\tce.ico" 0 "" ""
CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_CQB} ${PRODUCT_ENGINE}.lnk" "$INSTDIR\etl.exe" "+set fs_game cqbtest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set s_khz 44 +set r_maxpolyverts 16384 +set r_maxpolys 4096 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\TCETL$\"" "$INSTDIR\cqb.ico" 0 "" ""

CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\un.ico" 0 "" ""

; Url Shortcuts
CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\TC Website.lnk" "$INSTDIR\TCWebsite.url"
CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\TC AIO Installer Website.lnk" "$INSTDIR\InstallerWebsite.url"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninstall.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\etl.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\un.ico"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

; Section descriptions
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${TC} "This component is Required to run ${PRODUCT_NAME}. It contains Enemy Territory: Legacy 2.76, True Combat: Elite, True Combat: Close Quarters Battle. Downloads Wolfenstein: Enemy Territory Assets."
  !insertmacro MUI_DESCRIPTION_TEXT ${INGAMAPS} "This component is Optional. It downloads additional maps for Inga ETL Servers and adds shortcuts."
  !insertmacro MUI_DESCRIPTION_TEXT ${DESKTOP} "This component is Optional. It contains Desktop shortcuts for True Combat: Elite and True Combat: Close Quarters Battle."
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

Section Uninstall

; Remove shortcuts and folder
Delete "$DESKTOP\${PRODUCT_TCE} ${PRODUCT_ENGINE}.lnk"
Delete "$DESKTOP\${PRODUCT_CQB} ${PRODUCT_ENGINE}.lnk"
Delete "$DESKTOP\${SERVER_INGA} ${PRODUCT_ENGINE} ${PRODUCT_TCE} BC.lnk"
Delete "$DESKTOP\${SERVER_INGA} ${PRODUCT_ENGINE} ${PRODUCT_TCE} OBJ.lnk"
Delete "$DESKTOP\${SERVER_INGA} ${PRODUCT_ENGINE} ${PRODUCT_CQB} BC.lnk"

; Remove shortcuts and folder
RMDir /r "$SMPROGRAMS\${PRODUCT_NAME}"

; Close files
ExecWait "taskkill /im etl.exe"

; Remove files and uninstaller

RMDir /r $INSTDIR # Remembering, of course, that you should do this with care
RMDir /r "$DOCUMENTS\TCETL"

DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
SectionEnd
