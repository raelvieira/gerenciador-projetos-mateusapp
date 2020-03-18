package br.com.mateusapp.service;

import br.com.mateusapp.exceptions.ProjetoException;
import br.com.mateusapp.model.Projeto;
import br.com.mateusapp.model.StatusProjeto;
import br.com.mateusapp.repository.ProjetoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class ProjetoService {
    @Autowired
    private ProjetoRepository projetoRepository;

    @Autowired
    private StatusProjetoService statusService;

    @Transactional
    public Projeto criar(Projeto projeto) {
        validarInfosProjeto(projeto.getTitulo(), projeto.getDataPrevisaoEntrega());
        projeto.setStatus(statusService.getSituacaoIniciado());
        projeto.setDataCriacao(LocalDateTime.now());

        return projetoRepository.save(projeto);
    }

    @Transactional(readOnly = true)
    public Optional<Projeto> buscar(int idProjeto) {
        return projetoRepository.findById(idProjeto);
    }

    @Transactional(readOnly = true)
    public List<Projeto> buscarTodos() {
        return projetoRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Page<Projeto> buscarTodos(Pageable paginacao) {
        return projetoRepository.findAll(paginacao);
    }

    @Transactional(readOnly = true)
    public Page<Projeto> buscarPorTitulo(String tituloProjeto, Pageable paginacao) {
        return projetoRepository.findByTitulo(tituloProjeto, paginacao);
    }

    @Transactional
    public Projeto editar(Projeto projetoAtualizacao, Projeto projetoNovosDados) {
        validarInfosProjeto(projetoNovosDados.getTitulo(), projetoNovosDados.getDataPrevisaoEntrega());

        projetoAtualizacao.setDataPrevisaoEntrega(projetoNovosDados.getDataPrevisaoEntrega());
        projetoAtualizacao.setDescricao(projetoNovosDados.getDescricao());
        projetoAtualizacao.setTitulo(projetoNovosDados.getTitulo());

        return projetoRepository.save(projetoAtualizacao);
    }

    @Transactional
    public void excluir(int id) {
        projetoRepository.deleteById(id);
    }

    @Transactional
    public void finalizarProjeto(Projeto projeto) {
        if(temTarefasNaoConcluidas(projeto))
            throw new ProjetoException("Para finalizar este projeto é necessário concluir todas as suas tarefas!");

        atualizaProjeto(projeto.getId(), "F");
    }

    @Transactional
    public void atualizaStatusEmAndamento(Integer idProjeto, String codStatusProjeto) {
        atualizaProjeto(idProjeto, codStatusProjeto);
    }

    private void atualizaProjeto(Integer idProjeto, String codStatusProjeto) {
        StatusProjeto status = new StatusProjeto();
        status.setCodigo(codStatusProjeto);

        projetoRepository.atualizaStatus(idProjeto, status);
    }

    private void validarInfosProjeto(String titulo, LocalDateTime dataPrevisaoEntrega) {
        if(titulo.isEmpty() || Objects.isNull(titulo))
            throw new ProjetoException("Por favor, digite um título para o projeto!");

        if(dataPrevisaoEntrega.isBefore(LocalDateTime.now()))
            throw new ProjetoException("A data de entrega não pode ser anterior a data atual!");
    }

    private boolean temTarefasNaoConcluidas(Projeto projeto) {
        Long quantidade = projetoRepository.countTarefasNaoConcluidas(projeto);
        return quantidade.intValue() != 0;
    }
}
