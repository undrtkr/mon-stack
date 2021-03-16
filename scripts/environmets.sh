#!/usr/bin/env bash

#Environments
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ZBX_SERVER_URL="https://localhost:8443"
ZBX_PUBLIC_IP=$(ip route get 1 | awk '{print $NF;exit}')
GRF_SERVER_URL="https://admin:zabbix@localhost:3000"
yesPattern="^[Yy][Ee][Ss]"
HOST_GROUPS=(
 "DSP-Global" \
 "DSP-Filiais" \
 "DSP-Routers" \
 "DSP-Switchs" \
 "DSP-Printers" \
 "DSP-DVRs" \
 "DSP-Accesspoints" \
 "F001-DSP" \
 "F002-DSP" \
 "F003-DSP" \
 "F004-DSP" \
 "F005-DSP" \
 "F006-DSP" \
 "F007-DSP" \
 "F008-DSP" \
 "F009-DSP" \
 "F010-DSP" \
 "F011-DSP" \
 "F012-DSP" \
 "F013-DSP" \
 "F014-DSP" \
 "F015-DSP" \
 "F016-DSP" \
 "F017-DSP" \
 "F018-DSP" \
 "F019-DSP" \
 "F020-DSP" \
 "F021-DSP" \
 "F022-DSP" \
 "F023-DSP" \
 "F024-DSP" \
 "F025-DSP" \
 "F026-DSP" \
 "F027-DSP" \
 "F028-DSP" \
 "F029-DSP" \
 "F030-DSP" \
 "F031-DSP" \
 "F036-DSP" \
 "F037-DSP" \
 "F040-DSP" \
 "F041-DSP" \
 "F042-DSP" \
 "F043-DSP" \
 "F045-DSP" \
 "F050-DSP" \
 "F052-DSP" \
 "F072-DSP" \
 "F153-DSP" \
 "F157-DSP" \
 "F159-DSP" \
 "VM-Local-Global" \
 "VM-Local-QION" \
 "VM-Local-Services" \
 "VM-Cloud-Global" \
 "VM-Cloud-SIAGRI" \
 "VM-Cloud-SENIOR" \
 "VM-Cloud-QLIK" \
 "VM-Cloud-CLOVER" \
 "SRV-Local"
)
