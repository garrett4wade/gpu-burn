#!/bin/bash

srun --gpus=tesla:8 --cpus-per-gpu=15 --mem-per-gpu=100G \
     --container-image=gpu-burn --container-mounts=/lustre:/lustre \
     --container-mount-home --nodelist=QH-com12 \
     --pty bash