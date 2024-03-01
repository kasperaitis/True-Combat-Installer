/*
True Combat Installer
Copyright (C) 2012-2024  Aivaras Kasperaitis
https://gitlab.com/kasperaitis/true-combat-installer

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

Unicode True

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "True Combat WET"
!define PRODUCT_SHORT "TC"
!define PRODUCT_TCE "TCE"
!define PRODUCT_CQB "CQB"
!define PRODUCT_ENGINE "WET"
!define SERVER_INGA "Inga"
!define PRODUCT_VERSION "1.8.8"
!define PRODUCT_PUBLISHER "Aivaras Kasperaitis"
!define PRODUCT_WEB_SITE "http://www.truecombatelite.com"
!define WEB_SITE_NAME "True Combat Elite and CQB Lithuania"
!define INSTALLER_WEB_SITE "http://tc.oneladgames.com"
!define IP_ADDRESS "78.63.43.229"

!define /date TIME_STAMP "%Y%m%d%H%M%S"

!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\et.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
;!define PRODUCT_UNINST_ROOT_KEY "HKCU"

; Branding text
BrandingText "${PRODUCT_NAME}"

; MUI
!include "MUI2.nsh"

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
!define MUI_LICENSEPAGE_TEXT_TOP "Please review the license terms before installing Wolfenstein: Enemy Territory"
!define MUI_LICENSEPAGE_TEXT_BOTTOM "If you accept the terms of the agreement, click I Agree to continue. You must accept the agreement to install Wolfenstein: Enemy Territory"
!insertmacro MUI_PAGE_LICENSE "licence\wet.txt"

!define MUI_LICENSEPAGE_TEXT_TOP "Please review the license terms before installing True Combat: Elite"
!define MUI_LICENSEPAGE_TEXT_BOTTOM "If you accept the terms of the agreement, click I Agree to continue. You must accept the agreement to install True Combat: Elite"
!insertmacro MUI_PAGE_LICENSE "licence\tce.txt"

!define MUI_LICENSEPAGE_TEXT_TOP "Please review the license terms before installing True Combat: Close Quarters Battle"
!define MUI_LICENSEPAGE_TEXT_BOTTOM "If you accept the terms of the agreement, click I Agree to continue. You must accept the agreement to install True Combat: Close Quarters Battle"
!insertmacro MUI_PAGE_LICENSE "licence\cqb.txt"

!define MUI_LICENSEPAGE_TEXT_TOP "Please review the license terms before installing ETMinPro"
!define MUI_LICENSEPAGE_TEXT_BOTTOM "If you accept the terms of the agreement, click I Agree to continue. You must accept the agreement to install ETMinPro"
!insertmacro MUI_PAGE_LICENSE "licence\etminpro.txt"

; Components page
!insertmacro MUI_PAGE_COMPONENTS
; Directory page
;!insertmacro MUI_PAGE_DIRECTORY
;!insertmacro MUI_PAGE_STARTMENU "Application" $StartMenuFolder
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES

; Finish page
;!define MUI_FINISHPAGE_RUN
;!define MUI_FINISHPAGE_RUN_FUNCTION RunTCE

;Function RunTCE
;  SetOutPath $INSTDIR
;  Exec "$INSTDIR\etminpro.exe"
;  Exec '"$INSTDIR\et.exe" +set fs_game tcetest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\${PRODUCT_NAME}$\"'
;FunctionEnd

!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_WELCOME
;!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_COMPONENTS
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
Caption "${PRODUCT_NAME}"
OutFile "setup_tc_wet_${PRODUCT_VERSION}.exe"
InstallDir "$PROGRAMFILES\${PRODUCT_NAME}"

InstallDirRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_DIR_REGKEY}" ""

; Request application privileges for Windows 7
RequestExecutionLevel admin

XPStyle on
WindowIcon on

Function .onInit
	; The plugins dir is automatically deleted when the installer exits

	InitPluginsDir
	File /oname=$PLUGINSDIR\splash.bmp "splash\splash.bmp"

	; Optional
	File /oname=$PLUGINSDIR\splash.wav "splash\splash.wav"

	advsplash::show 4000 600 400 -1 $PLUGINSDIR\splash

	Pop $0	;	$0 has '1' if the user closed the splash screen early,
        	;	'0' if everything closed normally, and '-1' if some error occurred.

	Delete $PLUGINSDIR\splash.bmp
	Delete $PLUGINSDIR\splash.waw

	; Unistall old version
	Exec $INSTDIR\uninstall.exe
FunctionEnd

Section "WET. TCE. CQB." TC
  SectionIn 1 RO
  SetOutPath "$INSTDIR"
  SetOverwrite try
  ; Put file there
  File /r "files\*"

  inetc::get /NOCANCEL "http://tc.oneladgames.com/files/wet/pak0.pk3" "$INSTDIR\etmain\pak0.pk3" /end
  inetc::get /NOCANCEL "http://tc.oneladgames.com/files/wet/pak1.pk3" "$INSTDIR\etmain\pak1.pk3" /end
  inetc::get /NOCANCEL "http://tc.oneladgames.com/files/wet/pak2.pk3" "$INSTDIR\etmain\pak2.pk3" /end

  ; Main Shortcuts
  CreateShortCut "$INSTDIR\${PRODUCT_ENGINE} ${PRODUCT_TCE}.lnk" "$INSTDIR\et.exe" "+set fs_game tcetest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\${PRODUCT_NAME}$\"" "$INSTDIR\tce.ico" 0 "" ""
  CreateShortCut "$INSTDIR\${PRODUCT_ENGINE} ${PRODUCT_CQB}.lnk" "$INSTDIR\et.exe" "+set fs_game cqbtest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set s_khz 44 +set r_maxpolyverts 16384 +set r_maxpolys 4096 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\${PRODUCT_NAME}$\"" "$INSTDIR\cqb.ico" 0 "" ""

  CreateShortCut "$INSTDIR\Alt+X.lnk" "$INSTDIR\etminpro.exe" "" "$INSTDIR\etminpro.ico" 0 "" ""

  ${If} ${FileExists} "$INSTDIR\etmain\etkey"
  ${Else}
    ;NSISdl::download http://etkey.org/etkey.php $INSTDIR\etmain\etkey
    inetc::get /NOCANCEL "https://etkey.eu/genkey.php" "$INSTDIR\etmain\etkey" /end
  ${EndIf}
SectionEnd

Section "Desktop Shortcuts" DESKTOP
  SectionIn 2
  SetOutPath "$INSTDIR"
  SetOverwrite try

  ; Desktop Shortcuts
  CreateShortCut "$DESKTOP\${PRODUCT_ENGINE} ${PRODUCT_TCE}.lnk" "$INSTDIR\et.exe" "+set fs_game tcetest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\${PRODUCT_NAME}$\"" "$INSTDIR\tce.ico" 0 "" ""
  CreateShortCut "$DESKTOP\${PRODUCT_ENGINE} ${PRODUCT_CQB}.lnk" "$INSTDIR\et.exe" "+set fs_game cqbtest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set s_khz 44 +set r_maxpolyverts 16384 +set r_maxpolys 4096 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\${PRODUCT_NAME}$\"" "$INSTDIR\cqb.ico" 0 "" ""

  CreateShortCut "$DESKTOP\Alt+X.lnk" "$INSTDIR\etminpro.exe" "" "$INSTDIR\etminpro.ico" 0 "" ""
SectionEnd

Section "Inga Servers Package" INGAMAPS
  SectionIn 3
  ;SetOutPath "$INSTDIR\tcetest"
  ;SetOverwrite try
  ;File "maps\*.*"

  SetOutPath "$DOCUMENTS\${PRODUCT_NAME}\tcetest"
  SetOverwrite try
  inetc::get /NOCANCEL "http://tc.oneladgames.com/files/maps/ingamaps.7z" "$DOCUMENTS\${PRODUCT_NAME}\tcetest\ingamaps.7z" /end
  Nsis7z::ExtractWithDetails "ingamaps.7z" "Extracting maps %s..."
  Delete "$OUTDIR\ingamaps.7z"

  SetOutPath "$INSTDIR"

  CreateShortCut "$DESKTOP\${SERVER_INGA} ${PRODUCT_ENGINE} ${PRODUCT_TCE} BC.lnk" "$INSTDIR\et.exe" "+set fs_game tcetest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\${PRODUCT_NAME}$\" +connect ${IP_ADDRESS}:27961" "$INSTDIR\tce.ico" 0 "" ""
  CreateShortCut "$DESKTOP\${SERVER_INGA} ${PRODUCT_ENGINE} ${PRODUCT_TCE} OBJ.lnk" "$INSTDIR\et.exe" "+set fs_game tcetest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\${PRODUCT_NAME}$\" +connect ${IP_ADDRESS}:27962" "$INSTDIR\tce.ico" 0 "" ""
  CreateShortCut "$DESKTOP\${SERVER_INGA} ${PRODUCT_ENGINE} ${PRODUCT_CQB} BC.lnk" "$INSTDIR\et.exe" "+set fs_game cqbtest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set s_khz 44 +set r_maxpolyverts 16384 +set r_maxpolys 4096 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\${PRODUCT_NAME}$\" +connect ${IP_ADDRESS}:27969" "$INSTDIR\cqb.ico" 0 "" ""

  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${SERVER_INGA} ${PRODUCT_ENGINE} ${PRODUCT_TCE} BC.lnk" "$INSTDIR\et.exe" "+set fs_game tcetest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\${PRODUCT_NAME}$\" +connect ${IP_ADDRESS}:27961" "$INSTDIR\tce.ico" 0 "" ""
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${SERVER_INGA} ${PRODUCT_ENGINE} ${PRODUCT_TCE} OBJ.lnk" "$INSTDIR\et.exe" "+set fs_game tcetest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\${PRODUCT_NAME}$\" +connect ${IP_ADDRESS}:27962" "$INSTDIR\tce.ico" 0 "" ""
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${SERVER_INGA} ${PRODUCT_ENGINE} ${PRODUCT_CQB} BC.lnk" "$INSTDIR\et.exe" "+set fs_game cqbtest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set s_khz 44 +set r_maxpolyverts 16384 +set r_maxpolys 4096 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\${PRODUCT_NAME}$\" +connect ${IP_ADDRESS}:27969" "$INSTDIR\cqb.ico" 0 "" ""
SectionEnd

Section "Default Profiles" PROFILES
  SectionIn 4
  ${If} ${FileExists} "$DOCUMENTS\${PRODUCT_NAME}\tcetest\profiles\*.*"
  ${Else}
    SetOutPath "$DOCUMENTS\${PRODUCT_NAME}"
    SetOverwrite try
    ; Put file there
    File /r "profiles\*"
    Call SetProfile
  ${EndIf}
SectionEnd

Function SetProfile
  System::Call 'user32::GetSystemMetrics(i 1) i .r1'
  System::Call 'user32::GetSystemMetrics(i 0) i .r0'

  IntOp $3 $0 * 100
  IntOp $4 $3 / $1
  ${If} $4 == 133
    StrCpy $2 2
  ${Else}
    StrCpy $2 1
  ${EndIf}

  FileOpen $5 "$DOCUMENTS\${PRODUCT_NAME}\tcetest\profiles\User\etconfig.cfg" a

  FileSeek $5 0 END
  FileWrite $5 "$\r$\n" ; we write a new line
  FileWrite $5 'seta r_customheight "$1"'
  FileWrite $5 "$\r$\n" ; we write a new line
  FileWrite $5 'seta r_customwidth "$0"'
  FileWrite $5 "$\r$\n" ; we write an extra line
  FileWrite $5 'seta cg_aspectMode "$2"'
  FileWrite $5 "$\r$\n" ; we write an extra line
  FileWrite $5 'seta name "User-${TIME_STAMP}"'
  FileWrite $5 "$\r$\n" ; we write an extra line
  FileClose $5 ; and close the file

  FileOpen $5 "$DOCUMENTS\${PRODUCT_NAME}\cqbtest\profiles\User\etconfig.cfg" a

  FileSeek $5 0 END
  FileWrite $5 "$\r$\n" ; we write a new line
  FileWrite $5 'seta r_customheight "$1"'
  FileWrite $5 "$\r$\n" ; we write a new line
  FileWrite $5 'seta r_customwidth "$0"'
  FileWrite $5 "$\r$\n" ; we write an extra line
  FileWrite $5 'seta cg_aspectMode "$2"'
  FileWrite $5 "$\r$\n" ; we write an extra line
  FileWrite $5 'seta name "User-${TIME_STAMP}"'
  FileWrite $5 "$\r$\n" ; we write an extra line
  FileClose $5 ; and close the file
FunctionEnd

Section -AdditionalIcons
  ; Startmenu Shortcuts
  CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_ENGINE} ${PRODUCT_TCE}.lnk" "$INSTDIR\et.exe" "+set fs_game tcetest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\${PRODUCT_NAME}$\"" "$INSTDIR\tce.ico" 0 "" ""
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_ENGINE} ${PRODUCT_CQB}.lnk" "$INSTDIR\et.exe" "+set fs_game cqbtest +set com_hunkMegs 512 +set com_zoneMegs 256 +set com_soundMegs 64 +set s_khz 44 +set r_maxpolyverts 16384 +set r_maxpolys 4096 +set r_primitives 2 +set fs_homepath $\"$DOCUMENTS\${PRODUCT_NAME}$\"" "$INSTDIR\cqb.ico" 0 "" ""

  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\un.ico" 0 "" ""

  ; Url Shortcuts
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\TC Website.lnk" "$INSTDIR\TCWebsite.url"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\TC AIO Installer Website.lnk" "$INSTDIR\InstallerWebsite.url"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninstall.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\et.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\un.ico"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

; Section descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${TC} "This component is Required to run ${PRODUCT_NAME}. It contains Wolfenstein: Enemy Territory, True Combat: Elite, True Combat: Close Quarters Battle. Downloads Wolfenstein: Enemy Territory Assets."
!insertmacro MUI_DESCRIPTION_TEXT ${DESKTOP} "This component is Optional. It contains Desktop shortcuts for True Combat: Elite and True Combat: Close Quarters Battle."
!insertmacro MUI_DESCRIPTION_TEXT ${INGAMAPS} "This component is Optional. It downloads additional maps for Inga WET Servers and adds Desktop shortcuts."
!insertmacro MUI_DESCRIPTION_TEXT ${PROFILES} "This component is Optional. It contains default User Profiles."
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Section "un.WET. TCE. CQB." UNTC
  SectionIn 1 RO
  ; Remove shortcuts and folder
  Delete "$DESKTOP\${PRODUCT_ENGINE} ${PRODUCT_TCE}.lnk"
  Delete "$DESKTOP\${PRODUCT_ENGINE} ${PRODUCT_CQB}.lnk"
  Delete "$DESKTOP\${SERVER_INGA} ${PRODUCT_ENGINE} ${PRODUCT_TCE} BC.lnk"
  Delete "$DESKTOP\${SERVER_INGA} ${PRODUCT_ENGINE} ${PRODUCT_TCE} OBJ.lnk"
  Delete "$DESKTOP\${SERVER_INGA} ${PRODUCT_ENGINE} ${PRODUCT_CQB} BC.lnk"
  Delete "$DESKTOP\Alt+X.lnk"

  ; Remove shortcuts and folder
  RMDir /r "$SMPROGRAMS\${PRODUCT_NAME}"

  ; Close files
  ExecWait "taskkill /im et.exe"
  ExecWait "taskkill /im etminpro.exe"

  ; Remove files and uninstaller
  Rename $INSTDIR\etmain\etkey $PLUGINSDIR\etkey
  RMDir /r $INSTDIR # Remembering, of course, that you should do this with care
  CreateDirectory $INSTDIR\etmain
  Rename $PLUGINSDIR\etkey $INSTDIR\etmain\etkey

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_DIR_REGKEY}"
SectionEnd

Section "un.Profiles" UNPROFILES
  SectionIn 2
  ; Remove Game Profiles 
  RMDir /r "$DOCUMENTS\${PRODUCT_NAME}"
SectionEnd

; Section descriptions
!insertmacro MUI_UNFUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${UNTC} "Remove ${PRODUCT_NAME}. It contains Wolfenstein: Enemy Territory, True Combat: Elite, True Combat: Close Quarters Battle."
!insertmacro MUI_DESCRIPTION_TEXT ${UNPROFILES} "Remove User Profiles."
!insertmacro MUI_UNFUNCTION_DESCRIPTION_END
