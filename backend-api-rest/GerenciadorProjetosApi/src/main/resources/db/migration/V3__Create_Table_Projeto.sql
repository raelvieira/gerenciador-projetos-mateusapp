CREATE TABLE projeto (
    id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(50) UNIQUE NOT NULL,
    descricao VARCHAR(100),
    data_criacao DATETIME NOT NULL,
    data_previsao_entrega DATETIME,
    status_codigo CHAR(1) NOT NULL,
    CONSTRAINT pk_id_projeto PRIMARY KEY (id),
    CONSTRAINT fk_codigo_status FOREIGN KEY (status_codigo) REFERENCES status_projeto(codigo)
)engine=InnoDB DEFAULT CHARSET=utf8;
