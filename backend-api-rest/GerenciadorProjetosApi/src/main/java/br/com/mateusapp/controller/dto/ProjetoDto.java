package br.com.mateusapp.controller.dto;

import br.com.mateusapp.model.Projeto;

public class ProjetoDto {
    private Integer id;
    private String titulo;

    public ProjetoDto(Projeto projeto) {
        this.id = projeto.getId();
        this.titulo = projeto.getTitulo();
    }

    public Integer getId() {
        return id;
    }

    public String getTitulo() {
        return titulo;
    }
}
