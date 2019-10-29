import Config

config :distillery_config_example, :api_key, System.get_env("API_KEY", "default_secret")
