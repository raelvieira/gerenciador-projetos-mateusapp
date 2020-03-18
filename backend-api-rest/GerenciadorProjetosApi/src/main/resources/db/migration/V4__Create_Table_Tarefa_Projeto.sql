CREATE TABLE tarefa_projeto (
    id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(50)  NOT NULL,
    data_criacao DATETIME NOT NULL,
    status VARCHAR(10) NOT NULL,
    projeto_id INT(11) UNSIGNED NOT NULL,
    CONSTRAINT pk_id_tarefa_projeto PRIMARY KEY (id),
    CONSTRAINT fk_projeto_id FOREIGN KEY (projeto_id) REFERENCES projeto(id)
)engine=InnoDB DEFAULT CHARSET=utf8;
