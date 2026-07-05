#!/bin/sh
set -e

echo "Waiting for database to be ready..."
python -c "
import time
from app.database import engine
while True:
    try:
        conn = engine.connect()
        conn.close()
        print('Database ready!')
        break
    except Exception as e:
        print(f'Waiting for DB... {e}')
        time.sleep(1)
"

exec uvicorn app.main:app --host 0.0.0.0 --port 8000
