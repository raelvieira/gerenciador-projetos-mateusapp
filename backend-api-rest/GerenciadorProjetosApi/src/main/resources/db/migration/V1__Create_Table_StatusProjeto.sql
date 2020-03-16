CREATE TABLE statusprojeto(
    codigo CHAR(1) NOT NULL,
    descricao VARCHAR(12) NOT NULL,
    CONSTRAINT pk_codigo_status PRIMARY KEY (codigo)
)engine=InnoDB DEFAULT CHARSET=utf8;