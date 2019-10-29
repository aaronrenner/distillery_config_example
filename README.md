# DistilleryConfigExample

This project shows how Distillery compiles application config into a
mix release. It also illustrates how secrets that are available at
build time are included in plain text into the release.

## Setup

1. Install the dependencies

    ```
    $ mix deps.get
    ```

2. Build the release and pass in an API key.

    ```
    $ MIX_ENV=prod API_KEY=supersecret mix release
    ```

3. Cd into the root of the build directory

    ```
    $ cd _build/prod/rel/distillery_config_example
    ```

    This is the folder that usually gets TARed up and shipped to
    the production server.

4. Look at the contents of `releases/<version_number>/sys.config`

    ```
    $ cat releases/0.1.0/sys.config
    %% coding: utf-8
    %% RUNTIME_CONFIG=false
    [{distillery_config_example,[{api_key,<<115,117,112,101,114,115,101,99,114,101,116>>}]}].
    ```

5. Paste the binary of the API key into iEX to see the raw value.

    ```
    $ iex
    Erlang/OTP 22 [erts-10.4.4] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [hipe]

    Interactive Elixir (1.9.1) - press Ctrl+C to exit (type h() ENTER for help)
    iex(1)> <<115,117,112,101,114,115,101,99,114,101,116>>
    "supersecret"
    ```

This shows that config values that are available at build time are compiled into the release and easily
readable if someone gets ahold of your build. Instead, secrets should be injected at runtime. Elixir
1.9's `config/releases.exs` is a great place to start if you want to read in environment variables
at runtime as you start your app.
