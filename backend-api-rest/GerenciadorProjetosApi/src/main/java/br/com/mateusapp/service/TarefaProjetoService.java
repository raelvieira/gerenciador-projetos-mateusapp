package br.com.mateusapp.service;

import br.com.mateusapp.exceptions.ProjetoException;
import br.com.mateusapp.model.StatusTarefa;
import br.com.mateusapp.model.TarefaProjeto;
import br.com.mateusapp.repository.TarefaProjetoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Objects;
import java.util.Optional;

@Service
public class TarefaProjetoService {
    @Autowired
    private TarefaProjetoRepository tarefaProjetoRepository;

    @Autowired
    private ProjetoService projetoService;

    @Transactional
    public TarefaProjeto criar(TarefaProjeto tarefa) {
        validarInfosTarefa(tarefa.getTitulo());

        tarefa.setDataCriacao(LocalDateTime.now());
        tarefa.setStatus(StatusTarefa.ABERTA);

        return tarefaProjetoRepository.save(tarefa);
    }

    @Transactional(readOnly = true)
    public Page<TarefaProjeto> buscarPorProjeto(int idProjeto, Pageable paginacao) {
        return tarefaProjetoRepository.findByProjeto_Id(idProjeto, paginacao);
    }

    @Transactional(readOnly = true)
    public Optional<TarefaProjeto> buscar(Integer id) {
        return tarefaProjetoRepository.findById(id);
    }

    @Transactional
    public TarefaProjeto editar(TarefaProjeto tarefaAtualizacao, TarefaProjeto tarefaNovosDados) {
        validarInfosTarefa(tarefaNovosDados.getTitulo());
        tarefaAtualizacao.setTitulo(tarefaNovosDados.getTitulo());

        return tarefaProjetoRepository.save(tarefaAtualizacao);
    }

    @Transactional
    public void exlcuir(int id) { tarefaProjetoRepository.deleteById(id); }

    @Transactional
    public void finalizarTarefa(TarefaProjeto tarefaProjeto) {
        projetoService.atualizaStatusEmAndamento(tarefaProjeto.getProjeto().getId(), "A");
        tarefaProjetoRepository.atualizaStatus(tarefaProjeto.getId(), StatusTarefa.FINALIZADA);
    }

    private void validarInfosTarefa(String titulo) {
        if(Objects.isNull(titulo) || titulo.isEmpty())
            throw new ProjetoException("Por favor, digite um título para a tarefa!");
    }
}
