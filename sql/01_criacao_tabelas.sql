CREATE TABLE sindico (
  id_sindico SERIAL PRIMARY KEY,
  nome VARCHAR(120) NOT NULL,
  cpf VARCHAR (11) NOT NULL UNIQUE,
  venc_mandato DATE NOT NULL
);

CREATE TABLE  condominio(
  id_condominio SERIAL PRIMARY KEY,
  cnpj VARCHAR(15) NOT NULL UNIQUE,
  nome VARCHAR(100) NOT NULL,
  rua VARCHAR(100) NOT NULL,
  numero VARCHAR(5) NOT NULL,
  bairro VARCHAR(60) NOT NULL,
  cidade VARCHAR(100) NOT NULL,
  cep VARCHAR(9) NOT NULL,
  id_sindico INT references sindico(id_sindico)
);

CREATE TABLE conta_bancaria(
  id_conta SERIAL PRIMARY KEY,
  banco VARCHAR(50) NOT NULL,
  agencia VARCHAR(10) NOT NULL,
  conta_com_digito VARCHAR(15)  NOT NULL,
  id_condominio INT UNIQUE references condominio(id_condominio)
);

CREATE TABLE proprietario (
  id_proprietario SERIAL PRIMARY KEY,
  cpf VARCHAR(11) NOT NULL UNIQUE,
  nome VARCHAR(100) NOT NULL
);

CREATE TABLE unidade (
  id_unidade SERIAL PRIMARY KEY,
  numero VARCHAR(10) NOT NULL,
  bloco VARCHAR(100),
  id_condominio INT references condominio(id_condominio),
  id_proprietario INT references proprietario(id_proprietario)
);

CREATE TABLE funcionario(
  id_funcionario SERIAL PRIMARY KEY,
  cpf VARCHAR(11) NOT NULL UNIQUE,
  nome VARCHAR(100) NOT NULL,
  cargo VARCHAR(60) NOT NULL,
  salario DECIMAL(10,2) NOT NULL,
  data_admissao DATE NOT NULL
);

CREATE TABLE funcionario_condominio(
  id_funcionario INT references funcionario(id_funcionario),
  id_condominio INT references condominio(id_condominio),
  PRIMARY KEY (id_funcionario, id_condominio)
);

CREATE TABLE sindico_telefone(
  id SERIAL PRIMARY KEY,
  id_sindico INT references sindico(id_sindico),
  telefone VARCHAR(13) NOT NULL
);


CREATE TABLE sindico_email(
  id SERIAL PRIMARY KEY,
  id_sindico INT references sindico(id_sindico),
  email VARCHAR(100) NOT NULL
);

CREATE TABLE proprietario_telefone(
  id SERIAL PRIMARY KEY,
  id_proprietario INT references proprietario(id_proprietario),
  telefone VARCHAR(13) NOT NULL
);


CREATE TABLE proprietario_email(
  id SERIAL PRIMARY KEY,
  id_proprietario INT references proprietario(id_proprietario),
  email VARCHAR(100) NOT NULL
);
