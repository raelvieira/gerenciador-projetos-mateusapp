package br.com.mateusapp.service;

import br.com.mateusapp.exceptions.ProjetoException;
import br.com.mateusapp.model.Projeto;
import br.com.mateusapp.repository.ProjetoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    public Projeto criar(Projeto projeto) {
        validarInfosProjeto(projeto.getTitulo(), projeto.getDataPrevisaoEntrega());
        projeto.setStatus(statusService.getSituacaoIniciado());
        projeto.setDataCriacao(LocalDateTime.now());

        return projetoRepository.save(projeto);
    }

    public Projeto buscar(int idProjeto) {
        Optional<Projeto> projetoOpt = projetoRepository.findById(idProjeto);
        if(!projetoOpt.isPresent())
            throw new ProjetoException("Não foi encontrado nenhum projeto para o id = " + idProjeto);

        return projetoOpt.get();
    }

    public List<Projeto> buscarTodos() {
        return projetoRepository.findAll();
    }

    public Projeto atualizar(Projeto projeto) {
        Projeto projetoAtualizacao = this.buscar(projeto.getId());
        validarInfosProjeto(projeto.getTitulo(), projeto.getDataPrevisaoEntrega());

        projetoAtualizacao.setDataPrevisaoEntrega(projeto.getDataPrevisaoEntrega());
        projetoAtualizacao.setDescricao(projeto.getDescricao());
        projetoAtualizacao.setTitulo(projeto.getTitulo());

        return projetoRepository.save(projetoAtualizacao);
    }

    public void excluir(int id) {
        Projeto projeto = buscar(id);
        projetoRepository.deleteById(projeto.getId());
    }

    private void validarInfosProjeto(String titulo, LocalDateTime dataPrevisaoEntrega) {
        if(titulo.isEmpty() || Objects.isNull(titulo))
            throw new ProjetoException("Por favor, digite um título para o projeto!");

        if(dataPrevisaoEntrega.isBefore(LocalDateTime.now()))
            throw new ProjetoException("A data de entrega não pode ser anterior a data atual!");
    }
}
