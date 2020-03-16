package br.com.mateusapp.models;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
public class Projeto {
    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(length = 50, nullable = false)
    private String titulo;

    @Column(length = 100, nullable = true)
    private String descricao;

    @Column(nullable = false)
    private LocalDateTime dataCriacao;

    @Column(nullable = true)
    private LocalDateTime dataPrevisaoEntrega;

    @ManyToOne(optional = false)
    private StatusProjeto status;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public LocalDateTime getDataCriacao() {
        return dataCriacao;
    }

    public void setDataCriacao(LocalDateTime dataCriacao) {
        this.dataCriacao = dataCriacao;
    }

    public LocalDateTime getDataPrevisaoEntrega() {
        return dataPrevisaoEntrega;
    }

    public void setDataPrevisaoEntrega(LocalDateTime dataPrevisaoEntrega) {
        this.dataPrevisaoEntrega = dataPrevisaoEntrega;
    }

    public StatusProjeto getStatus() {
        return status;
    }

    public void setStatus(StatusProjeto status) {
        this.status = status;
    }
}
