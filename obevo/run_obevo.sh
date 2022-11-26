#!/bin/ash

java -cp obevo/resources:obevo/classes:obevo/libs/* \
 "com.gs.obevo.dist.Main" deploy \
 -forceEnvSetup \
 -noPrompt \
 -sourcePath schemas \
 -env "$ENVIRONMENT" \
 -deployUserId "$PGUSER" -password "$PGPASSWORD"
