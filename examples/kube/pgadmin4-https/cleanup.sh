#!/bin/bash
# Copyright 2018 Crunchy Data Solutions, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

kubectl delete service pgadmin4
kubectl delete pod pgadmin4
kubectl delete secret pgadmin-secrets
kubectl delete secret pgadmin-tls

kubectl delete pvc pgadmin-https-pvc

rm -f ./server.crt ./server.key ./privkey.pem

$CCPROOT/examples/waitforterm.sh pgadmin4 kubectl

sudo CCP_STORAGE_PATH=$CCP_STORAGE_PATH rm -rf $CCP_STORAGE_PATH/pgadmin4.db $CCP_STORAGE_PATH/pgadmin4.log
sudo CCP_STORAGE_PATH=$CCP_STORAGE_PATH rm -rf $CCP_STORAGE_PATH/sessions $CCP_STORAGE_PATH/storage
