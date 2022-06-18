Feature: Editar dados de um usuário
Como um síndico
Quero poder editar os dados de um usuário já cadastrado

Cenário: Dados Válidos
Dado que o síndico informou dados válidos
Quando solicitar para atualizar o usuário
Então o sistema deve enviar síndico para a tela de cadastro de usuário
E exibir uma mensagem de sucesso

Cenário: Dados Inválidos
Dado que o síndico informou dados inválidos
Quando solicitar para atualizar o usuário
Então o sistema deve retornar uma mensagem de erro