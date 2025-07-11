#!/bin/bash
set -e

# Ждём, пока хостовая БД будет доступна
until PGPASSWORD="$HOST_PG_PASSWORD" psql -h "$HOST_PG_HOST" -U "$HOST_PG_USER" -d "$HOST_PG_DB" -c '\q'; do
  echo "Ожидание хостовой БД..."
  sleep 2
done

echo "Копируем структуру и данные из хостовой БД в контейнерную..."
PGPASSWORD="$HOST_PG_PASSWORD" pg_dump -h "$HOST_PG_HOST" -U "$HOST_PG_USER" "$HOST_PG_DB" \
  | psql -U "$POSTGRES_USER" -d "$POSTGRES_DB"

