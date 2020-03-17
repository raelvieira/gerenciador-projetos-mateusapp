package br.com.mateusapp.repository;

import br.com.mateusapp.model.Projeto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProjetoRepository extends JpaRepository<Projeto, Integer> {
    Page<Projeto> findByTitulo(String tituloProjeto, Pageable paginacao);
}
