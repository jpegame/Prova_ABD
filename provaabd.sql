CREATE DATABASE intro_orm;
use intro_orm;

CREATE TABLE pais (
    id_pais int NOT NULL AUTO_INCREMENT,
    nome varchar(150) DEFAULT NULL,
    PRIMARY KEY (id_pais)
);

CREATE TABLE estado (
    id_estado int NOT NULL AUTO_INCREMENT,
    nome varchar(150) DEFAULT NULL,
    id_pais int DEFAULT NULL,
    PRIMARY KEY (id_estado),
    KEY id_pais (id_pais),
    CONSTRAINT estado_ibfk_1 FOREIGN KEY (id_pais) REFERENCES pais (id_pais)
);

CREATE TABLE cidade (
  id_cidade int NOT NULL AUTO_INCREMENT,
  nome varchar(150) DEFAULT NULL,
  id_estado int DEFAULT NULL,
  PRIMARY KEY (id_cidade),
  KEY id_estado (id_estado),
  CONSTRAINT cidade_ibfk_1 FOREIGN KEY (id_estado) REFERENCES estado (id_estado)
);

CREATE TABLE endereco (
  id_endereco int NOT NULL AUTO_INCREMENT,
  nome varchar(150) DEFAULT NULL,
  CEP varchar(150) DEFAULT NULL,
  numero int DEFAULT NULL,
  id_cidade int DEFAULT NULL,
  PRIMARY KEY (id_endereco),
  KEY id_cidade (id_cidade),
  CONSTRAINT endereco_ibfk_1 FOREIGN KEY (id_cidade) REFERENCES cidade (id_cidade)
);

CREATE TABLE loja (
  id_loja int NOT NULL AUTO_INCREMENT,
  nome varchar(150) DEFAULT NULL,
  id_endereco int DEFAULT NULL,
  PRIMARY KEY (id_loja),
  KEY id_endereco (id_endereco),
  CONSTRAINT loja_ibfk_1 FOREIGN KEY (id_endereco) REFERENCES endereco (id_endereco)
);

CREATE TABLE produto (
  id_produto int NOT NULL AUTO_INCREMENT,
  nome varchar(150) DEFAULT NULL,
  preco int DEFAULT NULL,
  quantidade int DEFAULT NULL,
  PRIMARY KEY (id_produto)
);


CREATE TABLE loja_produto (
  id_loja int DEFAULT NULL,
  id_produto int DEFAULT NULL,
  KEY id_loja (id_loja),
  KEY id_produto (id_produto),
  CONSTRAINT loja_produto_ibfk_1 FOREIGN KEY (id_loja) REFERENCES loja (id_loja),
  CONSTRAINT loja_produto_ibfk_2 FOREIGN KEY (id_produto) REFERENCES produto (id_produto)
);

CREATE TABLE pessoa (
  id_pessoa int NOT NULL AUTO_INCREMENT,
  nome varchar(150) DEFAULT NULL,
  CPF int DEFAULT NULL,
  PRIMARY KEY (id_pessoa)
);

CREATE TABLE endereco_pessoa (
  id_pessoa int DEFAULT NULL,
  id_endereco int DEFAULT NULL,
  KEY id_pessoa (id_pessoa),
  KEY id_endereco (id_endereco),
  CONSTRAINT endereco_pessoa_ibfk_1 FOREIGN KEY (id_pessoa) REFERENCES pessoa (id_pessoa),
  CONSTRAINT endereco_pessoa_ibfk_2 FOREIGN KEY (id_endereco) REFERENCES endereco (id_endereco)
);

CREATE TABLE cliente (
  id_cliente int NOT NULL AUTO_INCREMENT,
  id_pessoa int DEFAULT NULL,
  PRIMARY KEY (id_cliente),
  KEY id_pessoa (id_pessoa),
  CONSTRAINT cliente_ibfk_1 FOREIGN KEY (id_pessoa) REFERENCES pessoa (id_pessoa)
);

CREATE TABLE vendedor (
  id_vendedor int NOT NULL AUTO_INCREMENT,
  id_pessoa int DEFAULT NULL,
  PRIMARY KEY (id_vendedor),
  KEY id_pessoa (id_pessoa),
  CONSTRAINT vendedor_ibfk_1 FOREIGN KEY (id_pessoa) REFERENCES pessoa (id_pessoa)
);

CREATE TABLE compra (
  id_compra int NOT NULL AUTO_INCREMENT,
  id_cliente int DEFAULT NULL,
  id_vendedor int DEFAULT NULL,
  id_loja int DEFAULT NULL,
  PRIMARY KEY (id_compra),
  KEY id_cliente (id_cliente),
  KEY id_vendedor (id_vendedor),
  KEY id_loja (id_loja),
  CONSTRAINT compra_ibfk_1 FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
  CONSTRAINT compra_ibfk_2 FOREIGN KEY (id_vendedor) REFERENCES vendedor (id_vendedor),
  CONSTRAINT compra_ibfk_3 FOREIGN KEY (id_loja) REFERENCES loja (id_loja)
);

CREATE TABLE comprasprodutos (
  id_compraproduto int NOT NULL AUTO_INCREMENT,
  quantidade int DEFAULT NULL,
  id_compra int DEFAULT NULL,
  id_produto int DEFAULT NULL,
  PRIMARY KEY (id_compraproduto),
  KEY id_compra (id_compra),
  KEY id_produto (id_produto),
  CONSTRAINT comprasprodutos_ibfk_1 FOREIGN KEY (id_compra) REFERENCES compra (id_compra),
  CONSTRAINT comprasprodutos_ibfk_2 FOREIGN KEY (id_produto) REFERENCES produto (id_produto)
);




