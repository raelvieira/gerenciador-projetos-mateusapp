package br.com.mateusapp.controller.dto;

import br.com.mateusapp.model.StatusTarefa;
import br.com.mateusapp.model.TarefaProjeto;
import org.springframework.data.domain.Page;

public class TarefaProjetoDto {
    private Integer id;
    private String titulo;

    public TarefaProjetoDto(TarefaProjeto tarefa) {
        this.id = tarefa.getId();
        this.titulo = tarefa.getTitulo();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }
}
