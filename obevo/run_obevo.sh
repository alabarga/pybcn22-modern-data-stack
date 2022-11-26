#!/bin/bash

java -cp obevo/resources:obevo/classes:obevo/libs/* \
 "com.gs.obevo.dist.Main" deploy \
 -forceEnvSetup \
 -noPrompt \
 -sourcePath schemas \
 -env "postgres" \
 -deployUserId "postgres" -password "passw0rd"
