#!/bin/bash

source ~/.bashrc
source ~/.nvm/nvm.sh
source venv/bin/activate

python3 -m r2r.serve &
cd R2R-Application && pnpm start &

wait


