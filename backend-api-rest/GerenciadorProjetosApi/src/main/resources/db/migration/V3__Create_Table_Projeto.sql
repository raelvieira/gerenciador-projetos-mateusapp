CREATE TABLE projeto (
    id INT(11) NOT NULL,
    titulo VARCHAR(50),
    descricao VARCHAR(100),
    datacriacao DATETIME NOT NULL,
    dataprevisaoentrega DATETIME,
    status_codigo CHAR(1) NOT NULL,
    CONSTRAINT pk_id_projeto PRIMARY KEY (id),
    CONSTRAINT fk_codigo_status FOREIGN KEY (status_codigo) REFERENCES statusprojeto(codigo)
)engine=InnoDB DEFAULT CHARSET=utf8;
