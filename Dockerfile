FROM pgvector/pgvector:pg17

ENV POSTGRES_DB=db \
    POSTGRES_USER=user \
    POSTGRES_PASSWORD=pass

COPY init.sql /docker-entrypoint-initdb.d/

EXPOSE 5432
