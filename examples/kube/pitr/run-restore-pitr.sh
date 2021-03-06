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



DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

kubectl delete pod primary-pitr-restore
kubectl delete pod primary-pitr
$CCPROOT/examples/waitforterm.sh primary-pitr kubectl
$CCPROOT/examples/waitforterm.sh primary-pitr-restore kubectl

kubectl create -f $DIR/recover-pv.json
kubectl create -f $DIR/recover-pvc.json
kubectl create -f $DIR/primary-pitr-restore-pvc.json

# start up the database container
expenv -f $DIR/primary-pitr-restore-service.json | kubectl create -f -
expenv -f $DIR/primary-pitr-restore-pod.json | kubectl create -f -
