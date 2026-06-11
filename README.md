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

_Relacionamentos_
 
Sequencia de informações (Relacionamento - Tipo e Descrição)

- Condomínio e Conta Bancária (1:1) Cada condomínio possui uma única conta bancária ativa 
- Síndico e Condomínio (1:N) Um síndico profissional pode gerenciar vários condomínios 
- Condomínio e Unidade (1:N) Um condomínio possui várias unidades 
- Proprietário e Unidade (1:N) Um proprietário pode ter várias unidades 
- Funcionário e Condomínio (N:N) Um funcionário pode trabalhar em vários condomínios 

## 2. Modelagem Conceitual

![DER](imagens/Diagrama)

## 3. Modelo Lógico

![Modelo Lógico](imagens/Supabase.modelo)

`Modelo Lógico SQL copiado do Supabase`  

`-- WARNING: This schema is for context only and is not meant to be run.`
-- Table order and constraints may not be valid for execution.

CREATE TABLE public.sindico (
  id_sindico integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  cpf character varying NOT NULL UNIQUE,
  nome character varying NOT NULL,
  venc_mandato date NOT NULL,
  CONSTRAINT sindico_pkey PRIMARY KEY (id_sindico)
);
CREATE TABLE public.condominio (
  id_condominio integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  id_sindico integer,
  cnpj character varying NOT NULL UNIQUE,
  nome character varying NOT NULL,
  rua character varying NOT NULL,
  numero character varying NOT NULL,
  bairro character varying NOT NULL,
  cidade character varying NOT NULL,
  cep character varying NOT NULL,
  CONSTRAINT condominio_pkey PRIMARY KEY (id_condominio),
  CONSTRAINT condominio_id_sindico_fkey FOREIGN KEY (id_sindico) REFERENCES public.sindico(id_sindico)
);
CREATE TABLE public.conta_bancaria (
  id_conta integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  id_condominio integer NOT NULL,
  banco character varying NOT NULL,
  agencia character varying NOT NULL,
  conta_com_digito character varying NOT NULL UNIQUE,
  CONSTRAINT conta_bancaria_pkey PRIMARY KEY (id_conta),
  CONSTRAINT conta_bancaria_id_condominio_fkey FOREIGN KEY (id_condominio) REFERENCES public.condominio(id_condominio)
);
CREATE TABLE public.proprietario (
  id_proprietario integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  cpf character varying NOT NULL UNIQUE,
  nome character varying NOT NULL,
  CONSTRAINT proprietario_pkey PRIMARY KEY (id_proprietario)
);
CREATE TABLE public.unidade (
  id_unidade integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  id_condominio integer,
  id_proprietario integer,
  numero character varying NOT NULL,
  bloco character varying,
  CONSTRAINT unidade_pkey PRIMARY KEY (id_unidade),
  CONSTRAINT unidade_id_condominio_fkey FOREIGN KEY (id_condominio) REFERENCES public.condominio(id_condominio),
  CONSTRAINT unidade_id_proprietario_fkey FOREIGN KEY (id_proprietario) REFERENCES public.proprietario(id_proprietario)
);
CREATE TABLE public.funcionario (
  id_funcionario integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  cpf character varying NOT NULL UNIQUE,
  nome character varying NOT NULL,
  cargo character varying NOT NULL,
  salario numeric NOT NULL,
  data_admissao date NOT NULL,
  CONSTRAINT funcionario_pkey PRIMARY KEY (id_funcionario)
);
CREATE TABLE public.funcionario_condominio (
  id_funcionario integer NOT NULL,
  id_condominio integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  CONSTRAINT funcionario_condominio_id_funcionario_fkey FOREIGN KEY (id_funcionario) REFERENCES public.funcionario(id_funcionario),
  CONSTRAINT funcionario_condominio_id_condominio_fkey FOREIGN KEY (id_condominio) REFERENCES public.condominio(id_condominio)
);
CREATE TABLE public.sindico_telefone (
  id integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  id_sindico integer NOT NULL,
  telefone character varying,
  CONSTRAINT sindico_telefone_pkey PRIMARY KEY (id),
  CONSTRAINT sindico_telefone_id_sindico_fkey FOREIGN KEY (id_sindico) REFERENCES public.sindico(id_sindico)
);
CREATE TABLE public.sindico_email (
  id integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  id_sindico integer NOT NULL,
  email character varying,
  CONSTRAINT sindico_email_pkey PRIMARY KEY (id),
  CONSTRAINT sindico_email_id_sindico_fkey FOREIGN KEY (id_sindico) REFERENCES public.sindico(id_sindico)
);
CREATE TABLE public.proprietario_telefone (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  id_proprietario integer NOT NULL,
  telefone character varying NOT NULL,
  CONSTRAINT proprietario_telefone_pkey PRIMARY KEY (id),
  CONSTRAINT proprietario_telefone_id_proprietario_fkey FOREIGN KEY (id_proprietario) REFERENCES public.proprietario(id_proprietario)
);
CREATE TABLE public.proprietario_email (
  id integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  id_proprietario integer NOT NULL,
  email character varying NOT NULL,
  CONSTRAINT proprietario_email_pkey PRIMARY KEY (id),
  CONSTRAINT proprietario_email_id_proprietario_fkey FOREIGN KEY (id_proprietario) REFERENCES public.proprietario(id_proprietario)
);

## 4. MODELAGEM FISICA
![MODELAGEM](imagens/modelagemfisica)


## 5. Inserção de Dados:
  Foram adicionados na pasta SQL (02_insercao_dados.sql)
  ![INSERÇÃO](imagens/parte5)

## 6. CRUD:

Create:
![CREATE](imagens/crud_create)

Read:
![READ](imagens/crud_read)

Update:
![UPDATE](imagens/crud_update)
