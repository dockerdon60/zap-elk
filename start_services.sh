#!/bin/bash
/etc/init.d/elasticsearch start
sleep 5
echo "==== testing elasticsearch ===="
curl http://localhost:9200
/etc/init.d/kibana start
sleep 5
echo "==== testing kibana ===="
curl http://localhost:5601
