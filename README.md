## Como rodar

O docker do projeto está configurado, tive que realizar algumas alterações pra conseguir instalar a gem factory-bot já que o Gemfile.lock estava em modo "frozen". Rode no terminal:

docker compose up --build

E depois, no bash do container rode:

rails db:create
rails db:migrate
rails db:seed
