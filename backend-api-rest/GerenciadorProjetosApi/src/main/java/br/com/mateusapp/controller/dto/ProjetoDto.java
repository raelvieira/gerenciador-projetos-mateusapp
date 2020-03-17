package br.com.mateusapp.controller.dto;

import br.com.mateusapp.model.Projeto;
import org.springframework.data.domain.Page;

import java.time.LocalDateTime;

public class ProjetoDto {
    private Integer id;
    private String titulo;
    private String descricao;
    private LocalDateTime dataPrevisaoEntrega;
    private StatusProjetoDto status;

    public ProjetoDto(Projeto projeto) {
        this.id = projeto.getId();
        this.titulo = projeto.getTitulo();
        this.descricao = projeto.getDescricao();
        this.dataPrevisaoEntrega = projeto.getDataPrevisaoEntrega();
        this.status = new StatusProjetoDto(projeto.getStatus());
    }

    public static Page<ProjetoDto> converter(Page<Projeto> projetos) {
        return projetos.map(ProjetoDto::new);
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
}
