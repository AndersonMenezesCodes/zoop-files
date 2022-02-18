#!/bin/sh

curl -X POST https://api.opsgenie.com/v2/alerts
    -H "Content-Type: application/json"
    -H "Authorization: GenieKey c8d2778c-87b0-4a05-9cb1-c2f23c577e9a"
    -d
'{
    "message": "An example alert message",
    "alias": "Test alert",
    "description":"Every alert needs a description",
    "responders":[
        {"id":"9ea54789-0581-492a-b492-d15ce26a164b", "type":"team"},
        {"name":"NOC", "type":"team"},
        {"id":"84140a94-b91a-40d1-861a-161031392a58", "type":"escalation"},
        {"name":"NOC_escalation", "type":"escalation"},
        {"id":"97bd9987-aa13-4055-95f3-d0790588f206", "type":"schedule"},
        {"name":"NOC_Schedule", "type":"schedule"}
    ],
    "visibleTo":[
        {"id":"9ea54789-0581-492a-b492-d15ce26a164b","type":"team"},
        {"name":"NOC","type":"team"},
    ],
    "tags": ["OverwriteQuietHours","Critical"],
    "priority":"P1"
}'
