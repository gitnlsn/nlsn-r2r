FROM pgvector/pgvector:pg17

ENV POSTGRES_DB=db \
    POSTGRES_USER=user \
    POSTGRES_PASSWORD=pass
    
ENV R2R_POSTGRES_USER=user \
    R2R_POSTGRES_PASSWORD=pass \
    R2R_POSTGRES_HOST=localhost \
    R2R_POSTGRES_PORT=5432 \
    R2R_POSTGRES_DBNAME=db

WORKDIR app

COPY run.sh ./
COPY init.sql /docker-entrypoint-initdb.d/

# Dependecies
RUN apt update && apt upgrade -y && apt install -y python3 pip python3.11-venv git curl wget

# R2R core setup
RUN python3 -m venv venv && . venv/bin/activate && pip install 'r2r[core]'

# Dashboard setup
#RUN wget -qO- https://get.pnpm.io/install.sh | ENV="$HOME/.bashrc" SHELL="$(which bash)" bash -
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
RUN . ~/.nvm/nvm.sh && nvm install --lts && node install -g pnpm
RUN git clone https://github.com/SciPhi-AI/R2R-Application.git && cd R2R-Application && . ~/.nvm/nvm.sh && pnpm install && pnpm build

EXPOSE 5432
EXPOSE 7272

ENTRYPOINT ["/app/run.sh"]
