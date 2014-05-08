# ElixirTtt
ElixirTtt is a command-line tic-tac-toe game written in Elixir, with human vs. human and human vs.
computer options. For 'X' and 'O' players, you can select among three different player type options--human (h), easy computer (c), and unbeatable computer (a).

## Getting Started
To get started with ElixirTtt:
- Install Erlang and Elixir - [See
  instructions.](http://elixir-lang.org/getting_started/1.html) 
- Clone this repository  
`git clone https://github.com/tarynsauer/elixir_ttt.git`  
`cd elixir_ttt`  
- Get dependencies  
`mix deps`

## Troubleshooting
If you have previously installed versions of Elixir and/or Erlang, you experience version issues. In such cases, try uninstalling and reinstalling them:  
`brew unlink elixir`  
`brew unlink erlang`  
`brew install --devel erlang`  
`brew install elixir`  

## Running the Test Suite
To run all unit tests:  
`mix test`

Integration tests are not run by default. To include integration tests, run:  
`mix test --include integration:true`

## Playing the Game
Run the following commands to generate an escript:  
`mix clean`  
`mix escriptize`   
Once you've generated the escript, run the following command to play the game:  
`./elixir_ttt`  
