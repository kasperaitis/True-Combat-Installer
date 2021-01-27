## NSIS scripts to create Windows All in One True Combat installer.

### Wolfenstein Enemy Territory (TC WET)
`Wolfenstein Enemy Territory` 2.60b, Downloads WET Assets, Punkbuster, True Combat Elite 0.49b, True Combat CQB 0.223, ETMinPro Minimizer, Some Fixes, Downloads Optional Maps, Gets etkey from etkey.org, Activates PunkBuster.

Compiled:
http://tc.garagegame.eu/files/private/setup_tc_wet_1.8.6.exe

### Enemy Territory: Legacy (TC ETL)
`Enemy Territory: Legacy` 2.76, Downloads WET Assets, True Combat Elite 0.49b, Close Quarters Battle 0.223, Downloads Optional Maps.

Compiled:
http://tc.garagegame.eu/files/private/setup_tc_etl_1.0.3.exe

### Folder Structure

**TC ETL**
- Contains the script and files needed to create TC Installer with `Enemy Territory: Legacy`.

**TC WET**
- Contains the script and files needed to create TC Installer with `Wolfenstein Enemy Territory`.

**maps**
- Contains additional maps.

### Compiling

1. Clone https://gitlab.com/kasperaitis/true-combat-installer repository.
2. Install NSIS. You could take it from NSIS folder or https://nsis.sourceforge.io.
3. Install NSIS "Inetc" plugin. You could take it from NSIS folder or https://nsis.sourceforge.io/Inetc_plug-in.
4. Install NSIS "Nsis7z" plugin. You could take it from NSIS folder or https://nsis.sourceforge.io/Nsis7z_plug-in.
5. Enter "TC ETL" or "TC WET" depending which version of Installer you want to compile "Enemy Territory: Legacy" or "Wolfenstein Enemy Territory".
6. Right click on setup_tc_*.nsi and choose "Compile NSIS Script".
7. After compilation you should find setup_tc_*.exe in the same folder.

### Donation

If you find it **useful** feel free to Donate on Paypal https://www.paypal.me/kasperaitis.
