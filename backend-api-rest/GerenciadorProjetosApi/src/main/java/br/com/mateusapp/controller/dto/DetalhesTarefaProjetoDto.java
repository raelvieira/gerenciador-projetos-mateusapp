package br.com.mateusapp.controller.dto;

import br.com.mateusapp.model.StatusTarefa;
import br.com.mateusapp.model.TarefaProjeto;
import org.springframework.data.domain.Page;

public class DetalhesTarefaProjetoDto {
    private Integer id;
    private String titulo;
    private StatusTarefa status;
    private ProjetoDto projeto;

    public DetalhesTarefaProjetoDto(TarefaProjeto tarefa) {
        this.id = tarefa.getId();
        this.titulo = tarefa.getTitulo();
        this.status = tarefa.getStatus();
        this.projeto = new ProjetoDto(tarefa.getProjeto());
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

    public StatusTarefa getStatus() {
        return status;
    }

    public void setStatus(StatusTarefa status) {
        this.status = status;
    }

    public ProjetoDto getProjeto() {
        return projeto;
    }

    public void setProjeto(ProjetoDto projeto) {
        this.projeto = projeto;
    }

    public static Page<DetalhesTarefaProjetoDto> converter(Page<TarefaProjeto> tarefas) { return tarefas.map(DetalhesTarefaProjetoDto::new); }
}
