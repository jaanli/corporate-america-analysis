#!/bin/bash

states=(ak al ar az ca co ct dc de fl ga hi ia id il in ks ky la ma md me mi mn mo ms mt nc nd ne nh nj nm nv ny oh ok or pa ri sc sd tn tx ut va vt wa wi wv wy)

model_content='{% set state_code = model.name.split("_")[1] %}
{{ process_state_companies(state_code) }}'

for state in "${states[@]}"; do
    filename="us_${state}_companies.sql"
    echo "$model_content" > "models/$filename"
    echo "Created $filename"
done

echo "All state models created successfully."