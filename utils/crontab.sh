#minute hour    day_of_month    month   weekday         command
#40      4       *               *       1-6             /rman_bkp/scripts/freeezeVeritas.sh
#40      5       *               *       1-6             /rman_bkp/scripts/unfreeezeVeritas.sh
#00      15      *               *       6               /rman_bkp/scripts/freeezeVeritas.sh
#00      22      *               *       0               /rman_bkp/scripts/unfreeezeVeritas.sh
#
#Caractere      Exemplo         Siginificado
#Hífen          2-4             intervalo de 2 a 4
#virgula        2,4,6,8         os números 2,4,6 e 8
#barra          */10            de dez em dez
#asterisco      *               todas as opções possiveis
#
#Exemplo
#minute hour    day_of_month    month   weekday         command
#40      4       *               *       1-6             /rman_bkp/scripts/freeezeVeritas.sh
#igual a
#minute 40 AND hour 4 AND day_of_month * AND month * AND weekday 1-6 --> Condicoes para executar
#
# 0 = domingo | 1 = segunda-feira | ... | 6 = sábado

# List crontab entries
crontab -l

# Edit crontab entries
crontab -e
