package br.com.mateusapp.controller.dto;

import br.com.mateusapp.model.StatusProjeto;

public class StatusProjetoDto {
    private String descricao;

    public StatusProjetoDto(StatusProjeto statusProjeto) {
        this.descricao = statusProjeto.getDescricao();
    }

    public String getDescricao() {
        return descricao;
    }

}
