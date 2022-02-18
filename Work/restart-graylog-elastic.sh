#!/bin/bash

######################################
#               ZOOP                 #
#    ---------------------------     #
# SCRIPT FOR RESTART GRAYLOG ELASTIC #
######################################
#                                    #
#  Created by: Anderson Menezes      #
#                                    #
#  Last update by: Anderson Menezes  #
#                                    #
#  Last update made in: 2020/08/13   #
#                                    #
######################################


# FUNCAO RESPONSAVEL POR DESABILITAR A REPLICA ENTRE OS NOS DO ELASTIC

function _disable_replica() {
    echo -e "\n\e[32m Iniciando execucao do script... \e[0m"
    sleep 3
    echo -e "\n\e[34m Desabilitando replica entre os nos do Elastic \e[0m\n"
    curl -X PUT "http://graylog-server-elasticsearch-5.zoop.tech:9200/_cluster/settings?pretty" -H 'Content-Type: application/json' -d'
    {
        "transient" : {
            "cluster.routing.allocation.enable" : "none"
        }
    }'
}

# FUNCAO RESPONSAVEL POR REALIZAR O RESTART NOS SERVICOS DO ELASTIC EM CADA NO

function _restart_services() {
    echo -e "\n\e[32m Realizando restart dos servicos do Elastic... \e[0m"
    sleep 60
    echo -e "\n\e[33m Restartando o no 5, aguarde... \e[0m\n"
    ssh graylog-server-elasticsearch-5.zoop.tech 'sudo service elasticsearch restart'
    sleep 60
    echo -e "\n\e[33m Restartando o no 4, aguarde... \e[0m\n"
    ssh graylog-server-elasticsearch-4.zoop.tech 'sudo service elasticsearch restart'
    sleep 60
    echo -e "\n\e[33m Restartando o no 3, aguarde... /e[0m\n"
    ssh graylog-server-elasticsearch-3.zoop.tech 'sudo service elasticsearch restart'
}

# FUNCAO RESPONSAVEL POR HABILITAR A REPLICA ENTRE OS NOS DO ELASTIC

function _enable_replica() {
    echo -e "\n\e[34m Habilitando replica entre os nos do Elastic \e[0m\n"
    sleep 60
    curl -XPUT http://graylog-server-elasticsearch-5.zoop.tech:9200/_cluster/settings -d '
    {
        "transient" :{
            "cluster.routing.allocation.enable" : "all",
            "cluster.routing.allocation.node_initial_primaries_recoveries": 10,
            "cluster.routing.allocation.node_concurrent_recoveries" : 20,
            "indices.recovery.max_bytes_per_sec" : "80mb"
        }
    }'
}

_disable_replica
_restart_services
_enable_replica

echo -e "\n\n\e[32m Procedimento concluido com sucesso! \e[0m"