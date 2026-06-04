# Condominios Administração — Banco de Dados

## 1. Cenário

No dia a dia, administradoras de condomínicos (quando possuem vários a administrar) precisam ter acesso fácil a informações
como cnpj dos condominios, endereço, nome, quais funcionarios trabalham em quais condominios, proprietarios das unidades em um condominio, quem é o sindico e quando vence seu mandato (para que possam ser organizadas assembleias) além de muitas outras informações. Então, nesse Banco de Dados buscarei centralizar dados sobre condomínios, unidades, proprietários, 
síndicos, funcionários e contas bancárias.

Entidades e Atributos

Condomínio
- id_condominio — atributo chave
- cnpj — atributo simples
- nome — atributo simples
- endereco — atributo composto (rua, número, bairro, cidade, CEP)
- qtd_unidades — atributo derivado (calculado a partir das unidades cadastradas)

Síndico
- id_sindico — atributo chave
- cpf — atributo simples
- nome — atributo simples
- email —  atributo multivalorado (pode ter mais de um)
- telefone — atributo multivalorado (pode ter mais de um)
- Venc_mandato — atributo simples

Unidade
- id_unidade — atributo chave
- numero — atributo simples
- bloco — atributo simples

Proprietário
- id_proprietario — atributo chave
- cpf — atributo simples
- nome — atributo simples
- email — atributo multivalorado (pode ter mais de um)
- telefone — atributo multivalorado (pode ter mais de um)
  
Funcionário
- id_funcionario — atributo chave
- cpf — atributo simples
- nome — atributo simples
- cargo — atributo simples
- salario — atributo simples
- data_admissao — atributo simples

 Conta Bancária
- id_conta — atributo chave
- banco — atributo simples
- agencia — atributo simples
- conta_com_digito — atributo simples

 #Relacionamentos#
Sequencia de informações (Relacionamento - Tipo e Descrição)

- Condomínio e Conta Bancária (1:1) Cada condomínio possui uma única conta bancária ativa 
- Síndico e Condomínio (1:N) Um síndico profissional pode gerenciar vários condomínios 
- Condomínio e Unidade (1:N) Um condomínio possui várias unidades 
- Proprietário e Unidade (1:N) Um proprietário pode ter várias unidades 
- Funcionário e Condomínio (N:N) Um funcionário pode trabalhar em vários condomínios 
