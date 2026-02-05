NPROC_PER_NODE=8
CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
ADAPTER=yourpath

NPROC_PER_NODE=$NPROC_PER_NODE CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES swift infer \
    --infer_backend pt \
    --max_new_tokens 512 \
    --val_dataset label/binary-SFT/19la_eval.json \
    --adapters "$ADAPTER" \
    --max_batch_size 16 \
    --temperature 0 \
    --write_batch_size 100 

NPROC_PER_NODE=$NPROC_PER_NODE CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES swift infer \
    --infer_backend pt \
    --max_new_tokens 512 \
    --val_dataset label/binary-SFT/singfake_eval.json \
    --adapters "$ADAPTER" \
    --max_batch_size 16 \
    --temperature 0 \
    --write_batch_size 100 

NPROC_PER_NODE=$NPROC_PER_NODE CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES swift infer \
    --infer_backend pt \
    --max_new_tokens 512 \
    --val_dataset label/binary-SFT/fakemusiccaps_eval.json \
    --adapters "$ADAPTER" \
    --max_batch_size 16 \
    --temperature 0 \
    --write_batch_size 100 

NPROC_PER_NODE=$NPROC_PER_NODE CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES swift infer \
    --infer_backend pt \
    --max_new_tokens 512 \
    --val_dataset label/binary-SFT/ESDD_eval.json \
    --adapters "$ADAPTER" \
    --max_batch_size 16 \
    --temperature 0 \
    --write_batch_size 100
