#!/bin/bash

# shellcheck disable=SC1091

# Load libraries
. /opt/bitnami/scripts/libfs.sh
. /opt/bitnami/scripts/libinfluxdb.sh

# Load InfluxDB environment variables
. /opt/bitnami/scripts/influxdb-env.sh

ensure_user_exists "$INFLUXDB_DAEMON_USER" --group "$INFLUXDB_DAEMON_GROUP"

# Ensure directories used by InfluxDB exist and have proper ownership and permissions
for dir in "$INFLUXDB_VOLUME_DIR" "$INFLUXDB_DATA_DIR" "$INFLUXDB_DATA_WAL_DIR" "$INFLUXDB_META_DIR" "$INFLUXDB_CONF_DIR" "$INFLUXDB_INITSCRIPTS_DIR"; do
    ensure_dir_exists "$dir"
    chmod -R g+rwX "$dir"
    chown -R "${INFLUXDB_DAEMON_USER}:root" "$dir"
done

touch "$HOME/.influx_history" && chmod g+rwX "$HOME/.influx_history"
