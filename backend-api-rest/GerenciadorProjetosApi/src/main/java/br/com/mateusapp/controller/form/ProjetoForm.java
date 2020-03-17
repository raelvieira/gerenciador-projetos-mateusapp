package br.com.mateusapp.controller.form;

import br.com.mateusapp.model.Projeto;

import javax.validation.constraints.FutureOrPresent;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;
import java.time.LocalDateTime;

public class ProjetoForm {

    @NotEmpty @Size(min = 1, max = 50)
    private String titulo;
    @Size(max = 100)
    private String descricao;
    @NotEmpty @FutureOrPresent
    private LocalDateTime dataPrevisaoEntrega;

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

    public LocalDateTime getDataPrevisaoEntrega() {
        return dataPrevisaoEntrega;
    }

    public void setDataPrevisaoEntrega(LocalDateTime dataPrevisaoEntrega) {
        this.dataPrevisaoEntrega = dataPrevisaoEntrega;
    }

    public Projeto converter() {
        return new Projeto(titulo, descricao, dataPrevisaoEntrega);
    }
}
