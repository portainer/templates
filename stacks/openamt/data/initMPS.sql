/*********************************************************************
* Copyright (c) Intel Corporation 2021
* SPDX-License-Identifier: Apache-2.0
**********************************************************************/
CREATE DATABASE mpsdb;

\connect mpsdb

CREATE TABLE IF NOT EXISTS devices(
                                      guid uuid NOT NULL,
                                      tags text[],
                                      hostname varchar(256),
    mpsinstance text,
    connectionstatus boolean,
    mpsusername text,
    tenantid varchar(36),
    PRIMARY KEY (guid,tenantid)
    );
