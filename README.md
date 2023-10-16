# IBM-FlashSystem-API-Zabbix-template

This is a Zabbix template for IBM FlashSystem storage which based on API requests.
For this template to work, you need to create the macros **{$USERNAME}** and **{$PASSWORD}**. which will contain credential to the flashsystem and port 7443 should be opened from zabbix server(proxy) to destination storage.
You cann add this macro globaly inside the template or localy on each flashsys which you need to monitor.
The external scripts behind this template are separated because you can use this template to monitor a large number of FlashSystems.
All scripts should be in **/usr/lib/zabbix/externalscripts** directory.
