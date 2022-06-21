echo off

git config --global github.accesstoken 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

set webFolderName=%1%2
set DBName=%webFolderName%
set dbRootUsername="root"
set dbRootPassword=""
set DrupalVersion=%2


set MySqlCommand="C:\xampp\mysql\bin\mysql.exe"

IF %DrupalVersion%.==. GOTO :ContinueAfterDrupalVersionCheck
IF %DrupalVersion%.==8. GOTO :ContinueAfterDrupalVersionCheck
IF %DrupalVersion%.==9. GOTO :ContinueAfterDrupalVersionCheck
IF %DrupalVersion%.==10. GOTO :ContinueAfterDrupalVersionCheck
GOTO EOF

:ContinueAfterDrupalVersionCheck

IF %webFolderName%.==. GOTO EOF
	%MySqlCommand% -u %dbRootUsername% -p  %dbRootPassword% -e "DROP DATABASE IF EXISTS %DBName%"
	%MySqlCommand% -u %dbRootUsername% -p  %dbRootPassword% -e "CREATE DATABASE %webFolderName%"

   if exist %webFolderName%\ (
  RMDIR "%webFolderName%\" /S /Q
)


IF %DrupalVersion%.==. GOTO InstallCommerce
IF %DrupalVersion%.==C. GOTO InstallCommerce
IF %DrupalVersion%.==c. GOTO InstallCommerce
IF %DrupalVersion%.==KS. GOTO InstallKickStart
IF %DrupalVersion%.==ks. GOTO InstallKickStart
IF %DrupalVersion%.==Ks. GOTO InstallKickStart
IF %DrupalVersion%.==kS. GOTO InstallKickStart
IF %DrupalVersion%.==8. GOTO Install8
IF %DrupalVersion%.==9. GOTO Install9
IF %DrupalVersion%.==10. GOTO Install10

GOTO EOF

:InstallKickStart
call composer create-project -s dev centarro/commerce-kickstart-project %webFolderName%
cd %webFolderName%
call composer require drupal/commerce_demo:*
GOTO ContinueAfterDrupalInitialise


:InstallCommerce
call composer create-project drupalcommerce/project-base "%webFolderName%" --stability dev
cd %webFolderName%
call composer update "drupal/core-*" --with-all-dependencies
GOTO ContinueAfterDrupalInitialise

:Install7
call composer create-project drupal-composer/drupal-project:7.x-dev -n "%webFolderName%"
cd %webFolderName%
call composer update "drupalcommerce/commerce*" --with-all-dependencies
GOTO ContinueAfterDrupalInitialise

:Install8
call composer create-project drupal/recommended-project:8.9.20 "%webFolderName%"
cd %webFolderName%
call composer update "drupalcommerce/commerce*" --with-all-dependencies
GOTO ContinueAfterDrupalInitialise

:Install9
call composer create-project drupal/recommended-project:9.4.0 "%webFolderName%"
cd %webFolderName%
call composer update "drupalcommerce/commerce*" --with-all-dependencies
GOTO ContinueAfterDrupalInitialise

:Install10
call composer create-project drupal/recommended-project:10.0.0-alpha5@alpha "%webFolderName%"
cd %webFolderName%
call composer update "drupalcommerce/commerce*" --with-all-dependencies




:ContinueAfterDrupalInitialise
Rem bat start:
call composer require drupal/facets:*
call composer require drupal/bat_api:*
call composer require drupal/fullcalendar_library:*
call composer require drupal/bat:^1.3
call composer update "drupal/bat*" --with-all-dependencies
Rem bat end:

Rem Commerce Start
call composer require drupal/commerce_demo:*
rem call composer update drupal/commerce_demo --with-dependencies
Rem Commerce Start
cd ..
call composer update

:EOF
echo on

rem git config --global github.accesstoken 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

rem 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

