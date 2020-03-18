package br.com.mateusapp.controller.form;

import br.com.mateusapp.exceptions.ProjetoException;
import br.com.mateusapp.model.Projeto;
import br.com.mateusapp.model.TarefaProjeto;
import br.com.mateusapp.service.ProjetoService;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Positive;
import javax.validation.constraints.Size;
import java.util.Optional;

public class TarefaProjetoForm {
    @NotEmpty
    @Size(min = 1, max = 50)
    private String titulo;

    @NotNull @Positive
    private Integer idProjeto;

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public Integer getIdProjeto() {
        return idProjeto;
    }

    public void setIdProjeto(Integer idProjeto) {
        this.idProjeto = idProjeto;
    }

    public TarefaProjeto converter(ProjetoService service) {
        Optional<Projeto> projeto = service.buscar(idProjeto);
        if (!projeto.isPresent())
            throw new ProjetoException("A tarefa não pode ser criada ou modificada em um projeto que não existe!");

        return new TarefaProjeto(titulo, projeto.get());
    }
}
