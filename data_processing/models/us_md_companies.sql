{% set state_code = model.name.split("_")[1] %}
{{ process_state_companies(state_code) }}
