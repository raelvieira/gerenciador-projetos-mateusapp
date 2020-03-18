package br.com.mateusapp.model;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "tarefa_projeto")
public class TarefaProjeto {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 50, nullable = false)
    private String titulo;

    @Column(name = "data_criacao",nullable = false)
    private LocalDateTime dataCriacao;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private StatusTarefa status;

    @ManyToOne(optional = false)
    @JoinColumn(columnDefinition = "integer", name = "projeto_id")
    private Projeto projeto;

    public TarefaProjeto() { }

    public TarefaProjeto(String titulo, Projeto projeto) {
        this.titulo = titulo;
        this.projeto = projeto;
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

    public LocalDateTime getDataCriacao() {
        return dataCriacao;
    }

    public void setDataCriacao(LocalDateTime dataCriacao) {
        this.dataCriacao = dataCriacao;
    }

    public StatusTarefa getStatus() {
        return status;
    }

    public void setStatus(StatusTarefa status) {
        this.status = status;
    }

    public Projeto getProjeto() {
        return projeto;
    }

    public void setProjeto(Projeto projeto) {
        this.projeto = projeto;
    }
}
