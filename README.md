# IBM-FlashSystem-API-Zabbix-template

For this template to work, you need to create the macros **{$USERNAME}** and **{$PASSWORD}**. which will contain credential to the flashsystem.
You cann add this macro globaly inside the template or localy on each flashsys which you need to monitor.
The external scripts behind this template are separated because you can use this template to monitor a large number of FlashSystems.
All scripts should be in **/usr/lib/zabbix/externalscripts** directory.
