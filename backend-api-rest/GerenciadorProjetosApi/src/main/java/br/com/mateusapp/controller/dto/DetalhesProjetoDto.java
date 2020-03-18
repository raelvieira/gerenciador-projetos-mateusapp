package br.com.mateusapp.controller.dto;

import br.com.mateusapp.model.Projeto;
import org.springframework.data.domain.Page;

import java.time.LocalDateTime;

public class DetalhesProjetoDto {
    private Integer id;
    private String titulo;
    private String descricao;
    private LocalDateTime dataPrevisaoEntrega;
    private StatusProjetoDto status;

    public DetalhesProjetoDto(Projeto projeto) {
        this.id = projeto.getId();
        this.titulo = projeto.getTitulo();
        this.descricao = projeto.getDescricao();
        this.dataPrevisaoEntrega = projeto.getDataPrevisaoEntrega();
        this.status = new StatusProjetoDto(projeto.getStatus());
    }

    public Integer getId() {
        return id;
    }

    public String getTitulo() {
        return titulo;
    }

    public String getDescricao() {
        return descricao;
    }

    public LocalDateTime getDataPrevisaoEntrega() {
        return dataPrevisaoEntrega;
    }

    public StatusProjetoDto getStatus() {
        return status;
    }

    public static Page<DetalhesProjetoDto> converter(Page<Projeto> projetos) {
        return projetos.map(DetalhesProjetoDto::new);
    }
}
