set CIQ_HOME=C:\Users\cwlin\AppData\Roaming\Garmin\ConnectIQ\Sdks\connectiq-sdk-win-6.3.0-2023-08-29-fc81ed416\
set PATH=%PATH%;%CIQ_HOME%\bin
connectiq &
monkeyc -d fenix7x -f monkey.jungle -o bin/ZsInvoice.prg -y c:\connectiq-sdk-manager\key\developer_key
monkeydo bin/ZsInvoice.prg fenix7x