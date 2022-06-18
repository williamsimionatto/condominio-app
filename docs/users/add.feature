Feature: Adicionar um novo usuário
Como um síndico
Quero poder adicionar um novo usuário para um condôminio
Para que ele possa acessar o sistema

Cenário: Dados Válidos
Dado que o síndico informou dados válidos
Quando solicitar para adicionar o usuário
Então o sistema deve enviar síndico para a tela de cadastro de usuário
E exibir uma mensagem de sucesso

Cenário: Dados Inválidos
Dado que o síndico informou dados inválidos
Quando solicitar para adicionar o usuário
Então o sistema deve retornar uma mensagem de erro